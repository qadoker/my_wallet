import 'package:flutter/material.dart';

class MenuOption extends StatelessWidget {
  final IconData icon;
  final String screenName;
  final Function pushScreen;
  MenuOption({this.icon, this.screenName, this.pushScreen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: pushScreen,
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, size: 30,),
                SizedBox(width: 10.0),
                Text(screenName, style: TextStyle(color: Colors.white, fontSize: 18),),
              ],
            ),
            SizedBox(height: 15.0,)
          ],
        ));
  }
}
