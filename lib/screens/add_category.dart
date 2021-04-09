import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/firebase/firebase_providers/categories_provider.dart';
import 'package:my_wallet/firebase/firebase_providers/operations_provider.dart';
import 'package:my_wallet/firebase/models/category.dart';
import 'package:my_wallet/firebase/models/operation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddCategory extends StatefulWidget {
  bool isAddedCategory;
  String categoryName;
  Icon iconN;
  Category category;

  AddCategory(
      {this.categoryName, this.isAddedCategory, this.iconN, this.category});

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  double screenWidth, screenHeight;
  TextEditingController newNameController;
  FocusNode textField = FocusNode();

  @override
  void initState() {
    if (widget.isAddedCategory == false) {
      newNameController = TextEditingController(text: widget.categoryName);
      newNameController.selection = TextSelection.fromPosition(
          TextPosition(offset: newNameController.text.length));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(children: [
            Text(
              widget.isAddedCategory == false
                  ? appLang.edit_category
                  : appLang.add_category,
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
                    labelText: appLang.enter_name,
                    labelStyle: TextStyle(
                      color: blue.withOpacity(0.8),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: blue)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: blue.withOpacity(0.1)))),
                style: TextStyle(color: blue, fontSize: 20.0),
                cursorColor: blue,
                controller: newNameController,
                validator: (String value) {
                  return value.isEmpty ? appLang.enter_name : null;
                },
                textAlign: TextAlign.center,
                keyboardType: TextInputType.name,
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.digitsOnly
                // ],
                onChanged: (value) {
                  setState(() {
                    widget.categoryName = value;
                  });
                }),
            SizedBox(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  appLang.choose_icon,
                  style: TextStyle(color: blue),
                ),
                SizedBox(width: screenWidth * 0.05),
                Flexible(
                    child: DropdownButton<Icon>(
                  focusNode: FocusNode(canRequestFocus: false),
                  icon: Icon(
                    IconData(Icons.arrow_drop_down.codePoint,
                        fontFamily: 'MaterialIcons'),
                    color: blue,
                  ),
                  style: TextStyle(color: blue, fontSize: 20),
                  underline: SizedBox(),
                  dropdownColor: lightBlue,
                  items: categoryIcons
                      .map((Icon icon) =>
                          DropdownMenuItem<Icon>(child: icon, value: icon))
                      .toList(),
                  onChanged: (Icon newIcon) {
                    setState(() {
                      widget.iconN = newIcon;
                    });
                  },
                  value:
                      widget.iconN
                )),
              ],
            ),
            SizedBox(height: screenHeight * 0.05),
            TextButton(
                child: Text(
                    widget.isAddedCategory == false
                        ? appLang.edit
                        : appLang.add,
                    style: TextStyle(color: blue, fontSize: 20.0)),
                onPressed: () {
                  setState(() {
                    if (widget.iconN != null && widget.categoryName != null) {
                      final categoryProvider =
                          Provider.of<CategoryProvider>(context, listen: false);
                      final operationProvider = Provider.of<OperationProvider>(
                          context,
                          listen: false);
                      if (widget.isAddedCategory == false) {
                        for (Operation operation
                            in operationProvider.operations) {
                          if (widget.categoryName == operation.categoryName) {
                            operationProvider.updateOperation(
                                operation: operation,
                                price: operation.price,
                                categoryName: widget.categoryName,
                                categoryIconVal: widget.iconN.icon.codePoint);
                          }
                        }
                        categoryProvider.updateCategory(
                            category: widget.category,
                            name: widget.categoryName,
                            iconValue: widget.iconN.icon.codePoint);
                      } else {
                        final category = Category(
                            name: widget.categoryName,
                            iconValue: widget.iconN.icon.codePoint);
                        categoryProvider.addCategory(category);
                      }
                      Navigator.pop(context);
                    } else {
                      SizedBox();
                    }
                  });
                }),
          ]),
        ),
      ),
    );
  }
}

const List<Icon> categoryIcons = [
  Icon(Icons.credit_card),
  Icon(Icons.add_shopping_cart),
  Icon(Icons.card_giftcard),
  Icon(Icons.shopping_bag),
  Icon(Icons.store),
  Icon(Icons.local_shipping),
  Icon(Icons.build),
  Icon(Icons.event),
  Icon(Icons.phone),
  Icon(Icons.directions_bus),
  Icon(Icons.directions_car),
  Icon(Icons.local_cafe),
  Icon(Icons.medical_services),
  Icon(Icons.restaurant),
  Icon(Icons.checkroom),
  Icon(Icons.room_service),
  Icon(Icons.school)
];
