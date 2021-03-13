import 'package:flutter/material.dart';
import 'package:my_wallet/providers/currency_provider.dart';
import 'package:my_wallet/database/wallet_database.dart';
import 'package:my_wallet/widgets/primary/textCard.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PriceAmount extends StatefulWidget {
  @override
  _PriceAmountState createState() => _PriceAmountState();
}

class _PriceAmountState extends State<PriceAmount> {



  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);
    final dao = Provider.of<WalletDatabase>(context, listen: false).operationDao;
    String currency = Provider.of<Currencies>(context, listen: false).currency;
    return StreamBuilder<List<OperationWithCategory>>(
      stream: dao.watchAllOperations(),
      builder: (context, snapshot) {
        final operations = snapshot.data ?? [];
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
                            text: appLang.income,
                            amountText: '${income.toStringAsFixed(1)} $currency',
                          ))),
                  Container(
                    color: Colors.black54,
                    width: 1.0,
                  ),
                  Expanded(
                    child: Container(
                        child: TextCard(
                          text: appLang.expense,
                          amountText: expense==0 ? '0.0 $currency' : '${(-expense).toStringAsFixed(1)} $currency',
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
                          text: appLang.balance,
                          amountText: '${(income + expense).toStringAsFixed(1)} $currency'
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
