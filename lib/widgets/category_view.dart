import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/firebase/firebase_providers/categories_provider.dart';
import 'package:my_wallet/firebase/firestore/category_fdb.dart';
import 'package:my_wallet/firebase/models/category.dart';
import 'package:my_wallet/screens/add_category.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CategoryView extends StatefulWidget {
  bool showCategoryDeleteButton;

  CategoryView({this.showCategoryDeleteButton});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<Category> categories = [];

  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    return Flexible(
      child: StreamBuilder<List<Category>>(
          stream: CategoryFDB.readCategories(),
          builder: (context, snapshot) {
            categories = snapshot.data;
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if(snapshot.hasError){
                  return Center(child: Text('Error'));
                } else{
                  if(snapshot.data.length == 0){
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
                  final categories = snapshot.data;
                  return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.black12,
                        height: 1.0,
                      );
                    },
                    itemCount: categories?.length,
                    // snapshot.connectionState == ConnectionState.active ? categories?.length : 0,
                    itemBuilder: (context, index) {
                      final item = categories[index];
                      return ListTile(
                        leading: Icon(
                            IconData(item.iconValue, fontFamily: 'MaterialIcons'),
                            color: Color(0XFF009BFF)),
                        title: Text(item.name,
                            style: TextStyle(color: Colors.black38, fontSize: 20.0)),
                        trailing: widget.showCategoryDeleteButton == true
                            ? IconButton(
                            icon: Icon(Icons.delete, color: Colors.red[900]),
                            onPressed: () {
                              categoryProvider.removeCategory(item);
                            })
                            : SizedBox(
                          width: 0,
                        ),
                        onTap: () {
                          setState(() {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return AddCategory(
                                    isAddedCategory: false,
                                    categoryName: item.name,
                                    category: item,
                                  );
                                });
                          });
                        },
                      );
                    },
                  );
                }
            }
          }),
    );
  }
}
