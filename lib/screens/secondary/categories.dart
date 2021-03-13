import 'package:flutter/material.dart';
import 'package:my_wallet/screens/secondary/add_category.dart';
import 'package:my_wallet/widgets/secondary/category_view.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  double screenWidth, screenHeight;

  bool _showDelete=false;


  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    Color blue = Color(0XFF009BFF);
    String delButtonName(bool show){
      if(show==false){
        return appLang.delete_category;
      }else{
        return appLang.undelete_category;
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.8,
            width: screenWidth,
            padding: EdgeInsets.only(
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
                top: screenHeight * 0.15),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              elevation: 5,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLang.categories,
                      style: TextStyle(
                        color: blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CategoryView(
                      showCategoryDeleteButton: _showDelete,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: UnicornDialer(
        parentButtonBackground: Colors.blue,
        backgroundColor: Color(0XFF009BFF).withOpacity(0.2),
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.menu),
        hasNotch: true,
        childButtons: [
          UnicornButton(
            hasLabel: true,
            labelText: appLang.add_category,
            currentButton: FloatingActionButton(
              heroTag: 'Add category',
              backgroundColor: Colors.blue,
              mini: true,
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: (){
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return AddCategory(
                          isAddedCategory: true
                      );
                    });
              },
            ),
          ),
          UnicornButton(
            hasLabel: true,
            labelText: delButtonName(_showDelete),
            currentButton: FloatingActionButton(
              heroTag: 'Delete category',
              backgroundColor: _showDelete==false ? Colors.red : Colors.green,
              mini: true,
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              onPressed: (){
                setState(() {
                  if(_showDelete ==true){
                    _showDelete=false;
                  }else{
                    _showDelete = true;
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
