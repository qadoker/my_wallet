import 'package:flutter/material.dart';
import 'package:my_wallet/screens/secondary/add_operation.dart';
import 'package:my_wallet/widgets/secondary/operation_view.dart';
import 'package:my_wallet/widgets/secondary/price_amount.dart';
import 'package:unicorndial/unicorndial.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  double screenWidth, screenHeight;
  bool _showDelete=false;
  String delButtonName(bool show){
    if(show==false){
      return 'Delete operation';
    }else{
      return 'Undelete operation';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;

    return Scaffold(
      floatingActionButton: UnicornDialer(
        parentButtonBackground: Colors.blue,
        backgroundColor: Color(0XFF009BFF).withOpacity(0.2),
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.menu),
        hasNotch: true,
        childButtons: [
          UnicornButton(
            hasLabel: true,
            labelText: 'Add operation',
            currentButton: FloatingActionButton(
              heroTag: 'Add operation',
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
                      return AddOperation(
                          isAddedOperation: true
                      );
                    });
              },
            ),
          ),
          UnicornButton(
            hasLabel: true,
            labelText: delButtonName(_showDelete),
            currentButton: FloatingActionButton(
              heroTag: 'Delete operation',
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
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.1,
                right: screenWidth * 0.1,
                top: screenHeight * 0.13,
                bottom: screenHeight * 0.58),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 5.0,
                      offset: Offset(0, 5.0))
                ],
                color: Colors.white,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  PriceAmount()
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                top: screenHeight * 0.4),
            child:
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "   Əməliyyatlar",
                        style: TextStyle(
                            color: Color(0XFF009BFF),
                            letterSpacing: 3.0,
                            fontSize: 20.0),
                      ),
                      OperationView(showOperationDeleteButton: _showDelete,),
                      ]
                ),
          )
        ],
      ),
    );
  }
}
