import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_wallet/firebase/firebase_providers/categories_provider.dart';
import 'package:my_wallet/firebase/models/category.dart';
import 'package:my_wallet/widgets/operation_view.dart';
import 'package:my_wallet/widgets/price_amount.dart';
import 'package:provider/provider.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'add_operation.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double screenWidth, screenHeight;
  bool _showDelete = false;

  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    screenWidth = size.width;
    screenHeight = size.height;
    String delButtonName(bool show) {
      if (show == false) {
        return appLang.delete_operation;
      } else {
        return appLang.undelete_operation;
      }
    }

    return Scaffold(
      floatingActionButton: UnicornDialer(
        parentButtonBackground: Colors.blue,
        backgroundColor: Color(0XFF009BFF).withOpacity(0.2),
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.menu),
        hasNotch: true,
        childButtons: [
          UnicornButton(
            hasLabel: true,
            labelText: appLang.add_operation,
            currentButton: FloatingActionButton(
              heroTag: 'Add operation',
              backgroundColor: Colors.blue,
              mini: true,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      if(categoryProvider.categories.length == 0){
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
                      return AddOperation(isAddedOperation: true);
                    });
              },
            ),
          ),
          UnicornButton(
            hasLabel: true,
            labelText: delButtonName(_showDelete),
            currentButton: FloatingActionButton(
              heroTag: 'Delete operation',
              backgroundColor: _showDelete == false ? Colors.red : Colors.green,
              mini: true,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (_showDelete == true) {
                    _showDelete = false;
                  } else {
                    _showDelete = true;
                  }
                });
              },
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
                top: screenHeight * 0.13,
                bottom: screenHeight * 0.58),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                elevation: 5,
                color: Colors.white,
                child: PriceAmount()),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                top: screenHeight * 0.4),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                appLang.operations,
                style: TextStyle(
                    color: Color(0XFF009BFF),
                    letterSpacing: 3.0,
                    fontSize: 20.0),
              ),
              OperationView(
                showOperationDeleteButton: _showDelete,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
