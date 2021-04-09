import 'package:flutter/material.dart';
import 'package:my_wallet/app_providers/currency_provider.dart';
import 'package:my_wallet/firebase/firebase_providers/operations_provider.dart';
import 'package:my_wallet/firebase/firestore/operation_fdb.dart';
import 'package:my_wallet/firebase/models/operation.dart';
import 'package:my_wallet/screens/add_operation.dart';
import 'package:provider/provider.dart';

import 'operation_tile.dart';


class OperationView extends StatefulWidget {
  bool showOperationDeleteButton;
  Function onDeleteTap;

  OperationView({this.showOperationDeleteButton, this.onDeleteTap});

  @override
  _OperationViewState createState() => _OperationViewState();
}

class _OperationViewState extends State<OperationView> {
  List<Operation> operations = [];


  @override
  Widget build(BuildContext context) {
    final operationProvider =
        Provider.of<OperationProvider>(context, listen: false);
    return Expanded(
      child: StreamBuilder<List<Operation>>(
          stream: OperationFDB.readOperations(),
          builder: (context, snapshot) {
            operations = snapshot.data ?? [];
            switch(snapshot.connectionState){
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if(snapshot.hasError){
                  return Center(child: Text('Error'),);
                } else{
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

                      return OperationTile(
                        onDeleteTap: () {
                          operationProvider.removeOperation(item);
                        },
                        showOperationDeleteButton: widget.showOperationDeleteButton,
                        icon: item.categoryIconVal !=null ? item.categoryIconVal : Icons.error.codePoint,
                        categoryName: item.categoryName != null ? item.categoryName : 'No name',
                        amount: double.parse(item.price),
                        currency: Provider.of<Currencies>(context, listen: false).currency ?? 'AZN',
                        onTap: () {
                          setState(() {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return AddOperation(
                                    isAddedOperation: false,
                                    newPrice: item.price.toString(),
                                    operation: item,
                                  );
                                });
                          });
                        },
                      );
                    },
                    itemCount: operations.length,
                  );
                }
            }
          }),
    );
  }
}
