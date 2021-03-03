import 'package:flutter/material.dart';

class OperationTile extends StatelessWidget {
  final int icon;
  final String categoryName;
  final double amount;
  final String currency;
  final Function onTap;
  final Function onDeleteTap;
  bool showOperationDeleteButton;

  OperationTile({this.icon, this.categoryName, this.amount, this.currency, this.onTap, this.onDeleteTap, this.showOperationDeleteButton});


  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Row(
        children: [
          Icon(IconData(icon != null ? icon : Icons.error.codePoint , fontFamily: 'MaterialIcons'), color: Color(0XFF009BFF),),
          SizedBox(width: 10.0),
          Text(categoryName != null ? categoryName : 'No name',style: TextStyle(color: Colors.black26, fontSize: 20.0) ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(amount.toStringAsFixed(1),style: TextStyle(color: amount>0 ? Colors.green[900] : Colors.red[900], fontSize: 20.0, fontWeight: FontWeight.bold)),
          SizedBox(width: 10.0),
          Text(currency,style: TextStyle(color: Color(0XFF009BFF), fontSize: 20.0)),
          showOperationDeleteButton == true ? IconButton(icon: Icon(Icons.delete, color: Colors.red[900]), onPressed:onDeleteTap) : SizedBox(width: 0,)
        ],
      ),
    );
  }
}
