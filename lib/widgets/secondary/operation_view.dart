import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:my_wallet/database/wallet_database.dart';
import 'package:my_wallet/screens/secondary/add_operation.dart';
import 'package:provider/provider.dart';
import 'package:my_wallet/widgets/secondary/operation_tile.dart';
import 'package:my_wallet/constants.dart';

class OperationView extends StatefulWidget {
  bool showOperationDeleteButton;
  Function onDeleteTap;

  OperationView({this.showOperationDeleteButton, this.onDeleteTap});

  @override
  _OperationViewState createState() => _OperationViewState();
}

class _OperationViewState extends State<OperationView> {
  List<OperationWithCategory> operations = [];


  //
  // @override
  // void initState() {
  //   deleteOperationWithFunction();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final dao =
        Provider.of<WalletDatabase>(context, listen: false).operationDao;
    return Expanded(
      child: StreamBuilder(
          stream: dao.watchAllOperations(),
          builder:
              (context, AsyncSnapshot<List<OperationWithCategory>> snapshot) {
            operations = snapshot.data ?? List();
            print(operations.length);
            if (snapshot.hasData) {
              print('==data==: ${snapshot.data}');
              return ListView.separated(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.black12,
                    height: 1.0,
                  );
                },
                itemBuilder: (context, index) {
                  final item = operations[index];
                  // while (item.categorie.iconName == null) {
                  //   dao.deleteOperation(item.operation);
                  // }
                  // if (item.categorie == null) {
                  //   item.categorie.name = 'no name'
                  //   );
                  //   // dao.updateOperation(item.operation.copyWith(categoryName: category.name))
                  //   dao.insertCategory(category);
                  // }

                  return OperationTile(
                    onDeleteTap: () {
                      dao.deleteOperation(item.operation);
                    },
                    showOperationDeleteButton: widget.showOperationDeleteButton,
                    icon: item.categorie !=null ? item.categorie.iconName : Icons.error.codePoint,
                    categoryName: item.categorie != null ? item.categorie.name : 'No name',
                    amount: item.operation.income ?? item.operation.expense,
                    currency: currency[0],
                    onTap: () {
                      setState(() {
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return AddOperation(
                                isAddedOperation: false,
                                newPrice: item.operation.income != null
                                    ? item.operation.income.toString()
                                    : item.operation.expense.toString(),
                                categoryVal: item?.categorie != null
                                    ? item.categorie
                                    : null,
                                operation: item?.operation,
                              );
                            });
                      });
                    },
                  );

                  return SizedBox();
                },
                itemCount: operations.length,
              );
            } else {
              print('==data==: ${snapshot.data}');
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
