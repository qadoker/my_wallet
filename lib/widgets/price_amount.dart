import 'package:flutter/material.dart';
import 'package:my_wallet/app_providers/currency_provider.dart';
import 'package:my_wallet/firebase/firestore/operation_fdb.dart';
import 'package:my_wallet/firebase/models/operation.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'amount_text.dart';

class PriceAmount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);
    String currency = Provider.of<Currencies>(context, listen: false).currency;

    return StreamBuilder<List<Operation>>(
        stream: OperationFDB.readOperations(),
        builder: (context, snapshot) {
          final operations = snapshot.data ?? [];

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
              } else {
                double income = 0, expense = 0;

                for (Operation operation in operations) {
                  if (double.parse(operation.price) > 0) {
                    income += double.parse(operation.price);
                  } else {
                    expense += double.parse(operation.price);
                  }
                }

                return Column(
                  children: [
                    Expanded(
                      child: Row(children: [
                        Expanded(
                            child: Container(
                                child: AmountText(
                          text: appLang.income,
                          amountText: income != null
                              ? '${income.toStringAsFixed(1)} $currency'
                              : '0 $currency',
                        ))),
                        Container(
                          color: Colors.black54,
                          width: 1.0,
                        ),
                        Expanded(
                          child: Container(
                              child: AmountText(
                            text: appLang.expense,
                            amountText: expense != null
                                ? '${(-expense).toStringAsFixed(1)} $currency'
                                : '0.0 $currency',
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
                            child: AmountText(
                                text: appLang.balance,
                                amountText:
                                    '${(income + expense).toStringAsFixed(1)} $currency')))
                  ],
                );
              }
          }
        });
  }
}
