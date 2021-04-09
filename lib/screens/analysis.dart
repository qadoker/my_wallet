import 'package:flutter/material.dart';
import 'package:my_wallet/firebase/firestore/operation_fdb.dart';
import 'package:my_wallet/firebase/models/operation.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class Analysis extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);


    Size size = MediaQuery
        .of(context)
        .size;
    screenWidth = size.width;
    screenHeight = size.height;

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
                padding: EdgeInsets.only(top: 20.0, left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                  appLang.analysis,
                  style: TextStyle(
                    color: Color(0XFF009BFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                    StreamBuilder<List<Operation>>(
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
                                    income = income + double.parse(operation.price);
                                  } else {
                                    expense += double.parse(operation.price);
                                  }
                                }

                                Map<String, double> walletMap = {
                                  appLang.income: income,
                                  appLang.expense: (-expense)
                                };

                                return PieChart(
                                  dataMap: walletMap,
                                  animationDuration: Duration(milliseconds: 800),
                                  chartRadius: screenWidth*0.7,
                                  colorList: [Colors.blue, Colors.red],
                                  initialAngleInDegree: 0,
                                  chartValuesOptions: ChartValuesOptions(
                                    chartValueBackgroundColor: Colors.white,
                                    showChartValueBackground: true,
                                    showChartValues: true,
                                    showChartValuesInPercentage: true,
                                    showChartValuesOutside: false,
                                  ),
                                  legendOptions: LegendOptions(
                                      legendTextStyle: TextStyle(color: Colors.black),
                                      legendPosition: LegendPosition.bottom
                                  ),
                                );
                              }
                          }
                        })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
