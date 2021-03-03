import 'package:flutter/material.dart';
import 'package:my_wallet/constants.dart';
import 'package:my_wallet/database/wallet_database.dart';
import 'package:my_wallet/widgets/primary/textCard.dart';
import 'package:provider/provider.dart';

class PriceAmount extends StatefulWidget {
  @override
  _PriceAmountState createState() => _PriceAmountState();
}

class _PriceAmountState extends State<PriceAmount> {



  @override
  Widget build(BuildContext context) {
    final dao = Provider.of<WalletDatabase>(context, listen: false).operationDao;
    return StreamBuilder<List<OperationWithCategory>>(
      stream: dao.watchAllOperations(),
      builder: (context, snapshot) {
        final operations = snapshot.data ?? List();
        double income = operations.map((operation) =>
        operation.operation.income != null ? operation.operation.income : 0).fold(0, (p, income) => p + income);
        double expense = operations.map((operation) =>
        operation.operation.expense != null ? operation.operation.expense : 0).fold(0, (p, e) => p + e);
        if(snapshot.hasData){
          return Column(
            children: [
              Expanded(
                child: Row(children: [
                  Expanded(
                      child: Container(
                          child: TextCard(
                            text: 'Gəlir',
                            amountText: '${income.toStringAsFixed(1)} ${currency[0]}',
                          ))),
                  Container(
                    color: Colors.black54,
                    width: 1.0,
                  ),
                  Expanded(
                    child: Container(
                        child: TextCard(
                          text: 'Xərc',
                          amountText: expense==0 ? '0.0 ${currency[0]}' : '${(-expense).toStringAsFixed(1)} ${currency[0]}',
                        )),
                  )
                ]),
              ),
              Container(
                color: Colors.black54,
                height: 1.0,
              ),
              Expanded(
                  child: Container(
                      child: TextCard(
                          text: 'Balans',
                          amountText: '${(income + expense).toStringAsFixed(1)} ${currency[0]}'
                      )
                  )
              )
            ],
          );
        }else if(snapshot.hasError){
          return Text('No data');
        }else{
          return Text('');
        }

      }
    );
  }
}
