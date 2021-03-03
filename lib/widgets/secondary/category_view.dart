import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wallet/database/wallet_database.dart';
import 'package:my_wallet/screens/secondary/add_category.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatefulWidget {
  bool showCategoryDeleteButton;

  CategoryView({this.showCategoryDeleteButton});

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<Categorie> categories = [];

  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<WalletDatabase>(context, listen: false).categoryDao;
    return Flexible(
      child: StreamBuilder<List<Categorie>>(
          stream: dao.watchCategories(),
          builder: (context, AsyncSnapshot<List<Categorie>> snapshot) {
            categories = snapshot.data;

            if (categories?.length == 0) {
              Provider.of<WalletDatabase>(context).categoryDao.insertCategory(
                  Categorie(
                      iconName: Icons.credit_card.codePoint, name: 'Maaş'));
              Provider.of<WalletDatabase>(context).categoryDao.insertCategory(
                  Categorie(
                      iconName: Icons.add_shopping_cart.codePoint,
                      name: 'Mağaza'));
            }

            // if (snapshot.connectionState != ConnectionState.done) {
            //   print('==data==: ${snapshot.data}');
            //   return Center(child: CircularProgressIndicator());
            // }
            // if (!snapshot.hasData || snapshot.data == null) return Container();

            return ListView.separated(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black12,
                  height: 1.0,
                );
              },
              itemCount: snapshot.connectionState == ConnectionState.active
              ? categories?.length : 0,
              itemBuilder: (context, index) {
                final item = categories[index];
                return ListTile(
                  leading: Icon(
                      IconData(item.iconName, fontFamily: 'MaterialIcons'),
                      color: Color(0XFF009BFF)),
                  title: Text(item.name,
                      style: TextStyle(color: Colors.black38, fontSize: 20.0)),
                  trailing: widget.showCategoryDeleteButton == true
                      ? IconButton(
                          icon: Icon(Icons.delete, color: Colors.red[900]),
                          onPressed: () {
                            dao.deleteCategory(item);
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
          }),
    );
  }
}
