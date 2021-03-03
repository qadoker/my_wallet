import 'package:flutter/material.dart';
import 'package:my_wallet/database/wallet_database.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class Analysis extends StatefulWidget {
  @override
  _AnalysisState createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  double screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    final dao =
        Provider
            .of<WalletDatabase>(context, listen: false)
            .operationDao;

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
                  'Analysis',
                  style: TextStyle(
                    color: Color(0XFF009BFF),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                    StreamBuilder(
                        stream: dao.watchAllOperations(),
                        builder: (context,
                            AsyncSnapshot<List<OperationWithCategory>> snapshot) {
                          final operations = snapshot.data ?? List();
                          double income = operations.map((operation) =>
                          operation.operation.income != null ? operation.operation.income : 0).fold(0, (p, income) => p + income);
                          double expense = operations.map((operation) =>
                          operation.operation.expense != null ? operation.operation.expense : 0).fold(0, (p, e) => p + e);
                          if (snapshot.hasData) {
                            Map<String, double> walletMap = {
                              'Income': income,
                              'Expense': (-expense)
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
                          } else {
                            print('==data==: ${snapshot.data}');
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
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
