import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:my_wallet/database/wallet_database.dart';
import 'package:provider/provider.dart';

class AddOperation extends StatefulWidget {
  String newPrice;
  Categorie categoryVal;
  bool isAddedOperation;
  Operation operation;
  AddOperation({this.newPrice, this.categoryVal,  this.isAddedOperation, this.operation});

  @override
  _AddOperationState createState() => _AddOperationState();
}

class _AddOperationState extends State<AddOperation> {
  double screenWidth, screenHeight;
  TextEditingController newPriceController;
  FocusNode textField = FocusNode();

  void resetValuesAfterSubmit() {
    setState(() {
      widget.categoryVal = null;
      widget.newPrice = null;
      newPriceController.clear();
    });
  }
  @override
  void initState() {
    if(widget.isAddedOperation==false){
      newPriceController = TextEditingController(text: widget.newPrice);
      newPriceController.selection = TextSelection.fromPosition(TextPosition(offset: newPriceController.text.length));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    Color light_blue = Color(0XFF9DDEFF);
    Color blue = Color(0XFF009BFF);
    return Scaffold(
      backgroundColor: light_blue,
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: screenWidth*0.1, top: screenHeight*0.1, right: screenWidth*0.1, bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(children: [
            Text(widget.isAddedOperation==false ? 'Edit operation' : 'Add operation', style: TextStyle(color: Color(0XFF009BFF), fontSize: 25.0, fontWeight: FontWeight.bold,),),
            SizedBox(height: screenHeight*0.1),
            TextFormField(
                focusNode: FocusNode(canRequestFocus: false),
                decoration: InputDecoration(
                    labelText: 'Enter price:',
                    labelStyle: TextStyle(color: blue.withOpacity(0.8),),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: blue)
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: blue.withOpacity(0.1))
                    )
                ),
                style: TextStyle(color: blue, fontSize: 20.0),
                cursorColor: blue,
                controller: newPriceController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.digitsOnly
                // ],
                onChanged: (value){
                  setState(() {
                    widget.newPrice = value;
                  });
                }

            ),
            SizedBox(height: screenHeight*0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Choose Category: ', style: TextStyle(color: blue),),
                SizedBox(width: screenWidth*0.05),
                Flexible(
                  child: StreamBuilder<List<Categorie>>(
                      stream: Provider.of<WalletDatabase>(context, listen: false).categoryDao
                          .watchCategories(),
                      builder: (context, snapshot) {

                        if(snapshot.hasData){
                          final _data = snapshot.data;
                          if (_data.length == 0) {
                            Provider.of<WalletDatabase>(context).categoryDao.insertCategory(
                                Categorie(
                                    iconName: Icons.credit_card.codePoint, name: 'Maaş'));
                            Provider.of<WalletDatabase>(context).categoryDao.insertCategory(
                                Categorie(
                                    iconName: Icons.add_shopping_cart.codePoint, name: 'Mağaza'));
                          }
                          final categories = snapshot.data;
                          String selectedCategory = categories[0].name;

                          return DropdownButton(
                              focusNode: FocusNode(canRequestFocus: false),
                            icon: Icon(IconData(Icons.arrow_drop_down.codePoint, fontFamily: 'MaterialIcons'), color: blue,),
                            style: TextStyle(color: blue, fontSize: 20),
                            underline: SizedBox(),
                            hint: Text(selectedCategory),
                            dropdownColor: light_blue,
                            items: categories
                                .map((Categorie categorie) => DropdownMenuItem<Categorie>(
                                child: Row(
                                  children: [
                                    Icon(IconData(categorie.iconName, fontFamily: 'MaterialIcons'), color: blue,),
                                    SizedBox(width: 15.0),
                                    Text(categorie.name)
                                  ],), value: categorie))
                                .toList(),
                            onChanged: (Categorie newValue) {
                              setState(() {
                                widget.categoryVal = newValue;
                                print(widget.categoryVal);
                              });
                            },
                            isExpanded: true,
                            value: widget.categoryVal != null ? widget.categoryVal : widget.categoryVal = snapshot.data[0],
                          );
                        }else if(snapshot.hasError){
                          return Text('No data avaible right now');
                        }else{
                          return CircularProgressIndicator();
                        }
                      }),
                ),
              ],
            ),
            SizedBox(height: screenHeight*0.05),
            TextButton(
              child: Text(widget.isAddedOperation==false ? 'Edit': 'Add',
                  style: TextStyle(color: blue, fontSize: 20.0)),
              onPressed: () {
                setState(() {
                  print('${widget.categoryVal.name}, ${widget.newPrice}');
                  if(widget.newPrice != null && widget.categoryVal.name != null ){
                    final dao = Provider.of<WalletDatabase>(context, listen: false).operationDao;
                    if(widget.isAddedOperation==false){
                      if(double.parse(widget.newPrice)>=0){
                        dao.updateOperation(widget.operation.copyWith(income: double.parse(widget.newPrice), categoryName: widget.categoryVal?.name));
                      }else{
                        dao.updateOperation(widget.operation.copyWith(expense: double.parse(widget.newPrice), categoryName: widget.categoryVal?.name));
                      }
                    }else{
                      if(double.parse(widget.newPrice)>=0){
                        final operation = OperationsCompanion(
                            income: moor.Value(double.parse(widget.newPrice)),
                            categoryName: moor.Value(widget.categoryVal?.name));
                        dao.insertOperation(operation);
                      }else{
                        final operation = OperationsCompanion(
                            expense: moor.Value(double.parse(widget.newPrice)),
                            categoryName: moor.Value(widget.categoryVal?.name));
                        dao.insertOperation(operation);
                      }
                    }
                    Navigator.pop(context);
                  }else{
                    resetValuesAfterSubmit();
                  }

                });

              }),
          ]),
        ),
      ),
    );
  }
}
