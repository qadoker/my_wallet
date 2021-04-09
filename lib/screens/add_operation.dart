import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/firebase/firebase_providers/categories_provider.dart';
import 'package:my_wallet/firebase/firebase_providers/operations_provider.dart';
import 'package:my_wallet/firebase/models/category.dart';
import 'package:my_wallet/firebase/models/operation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class AddOperation extends StatefulWidget {
  String newPrice;
  bool isAddedOperation;
  Operation operation;

  AddOperation({this.newPrice, this.isAddedOperation, this.operation});

  @override
  _AddOperationState createState() => _AddOperationState();
}

class _AddOperationState extends State<AddOperation> {
  double screenWidth, screenHeight;
  TextEditingController newPriceController;
  FocusNode textField = FocusNode();
  Category opCategory;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  void resetValuesAfterSubmit() {
    setState(() {
      widget.newPrice = null;
      newPriceController.clear();
    });
  }

  @override
  void initState() {
    if (widget.isAddedOperation == false) {
      newPriceController = TextEditingController(text: widget.newPrice);
      newPriceController.selection = TextSelection.fromPosition(
          TextPosition(offset: newPriceController.text.length));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    Category defaultCategory = categoryProvider.categories.first;
    var appLang = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;


    Color lightBlue = Color(0XFF9DDEFF);
    Color blue = Color(0XFF009BFF);
    return Scaffold(
      backgroundColor: lightBlue,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: screenWidth * 0.1,
              top: screenHeight * 0.1,
              right: screenWidth * 0.1,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Text(
                widget.isAddedOperation == false
                    ? appLang.edit_operation
                    : appLang.add_operation,
                style: TextStyle(
                  color: Color(0XFF009BFF),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
              TextFormField(
                  focusNode: FocusNode(canRequestFocus: false),
                  decoration: InputDecoration(
                      labelText: appLang.enter_price,
                      labelStyle: TextStyle(
                        color: blue.withOpacity(0.8),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: blue)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: blue.withOpacity(0.1)))),
                  style: TextStyle(color: blue, fontSize: 20.0),
                  cursorColor: blue,
                  controller: newPriceController,
                  validator: (String value) {
                    return value.isEmpty ? appLang.enter_price : null;
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  // inputFormatters: <TextInputFormatter>[
                  //   FilteringTextInputFormatter.digitsOnly
                  // ],
                  onChanged: (value) {
                    setState(() {
                      widget.newPrice = value;
                    });
                  }),
              SizedBox(height: screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appLang.choose_category,
                    style: TextStyle(color: blue),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('category')
                            .snapshots(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: CircularProgressIndicator());
                            default:
                              if (snapshot.hasError) {
                                return Center(child: Text('Error'));
                              } else {
                                if(snapshot.data.size == 0){
                                  Category category1 = Category(
                                      name: appLang.salary,
                                      iconValue: Icons.credit_card.codePoint);
                                  Category category2 = Category(
                                      name: appLang.store,
                                      iconValue:
                                      Icons.add_shopping_cart.codePoint);
                                  categoryProvider.addCategory(category1);
                                  categoryProvider.addCategory(category2);
                                }

                                List<Category> categoriesList =
                                    categoryProvider.categories;

                                return DropdownButton<Category>(
                                  focusNode: FocusNode(canRequestFocus: false),
                                  icon: Icon(
                                    IconData(Icons.arrow_drop_down.codePoint,
                                        fontFamily: 'MaterialIcons'),
                                    color: blue,
                                  ),
                                  style: TextStyle(color: blue, fontSize: 20),
                                  dropdownColor: lightBlue,
                                  items: categoriesList
                                      .map((Category category) =>
                                          DropdownMenuItem<Category>(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    IconData(category.iconValue,
                                                        fontFamily:
                                                            'MaterialIcons'),
                                                    color: blue,
                                                  ),
                                                  SizedBox(width: 15.0),
                                                  Text(category.name)
                                                ],
                                              ),
                                              value: category))
                                      .toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      opCategory = newValue;
                                    });
                                  },
                                  isExpanded: true,
                                  value: opCategory ?? categoriesList.first,
                                );
                              }
                          }
                        }),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              TextButton(
                  child: Text(
                      widget.isAddedOperation == false
                          ? appLang.edit
                          : appLang.add,
                      style: TextStyle(color: blue, fontSize: 20.0)),
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState.validate()) {
                        final operationProvider =
                            Provider.of<OperationProvider>(context,
                                listen: false);
                        if (widget.isAddedOperation == false) {
                          operationProvider.updateOperation(
                              operation: widget.operation,
                              price: widget.newPrice,
                              categoryName: opCategory == null
                                  ? widget.operation.categoryName
                                  : opCategory.name,
                              categoryIconVal: opCategory == null
                                  ? widget.operation.categoryIconVal
                                  : opCategory.iconValue
                          );
                        } else {
                          Operation operation = Operation(
                            createdTime: DateTime.now(),
                            price: widget.newPrice,
                            categoryName: opCategory == null
                                ? defaultCategory.name
                                : opCategory.name,
                            categoryIconVal: opCategory == null
                                ? defaultCategory.iconValue
                                : opCategory.iconValue,
                          );
                          operationProvider.addOperation(operation);
                        }
                        Navigator.pop(context);
                      }
                    });
                  }),
            ]),
          ),
        ),
      ),
    );
  }
}
