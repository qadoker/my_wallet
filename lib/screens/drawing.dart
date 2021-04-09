import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'analysis.dart';
import 'categories.dart';
import 'main_screen.dart';
import 'menu.dart';


class Drawing extends StatefulWidget {
  static const String id = 'drawer';

  @override
  _DrawingState createState() => _DrawingState();
}

class _DrawingState extends State<Drawing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [MenuScreen(), HomeScreen()],
    ));
  }
}

class HomeScreen extends StatefulWidget {
  static const String id = 'main_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  double screenWidth, screenHeight;

  Duration duration = Duration(milliseconds: 500);
  bool isCollapsed = true;

  AnimationController _controller;
  Animation<double> _scaleanimation;


  int _selectedIndex = 1;

  List<Widget> screens = [
    null,
    MainScreen(),
    Categories(),
    Analysis(),
  ];

  void onItemTap(int index) {
    setState(() {
      if (index == 0) {
        if (isCollapsed) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
        isCollapsed = !isCollapsed;
      } else {
        _selectedIndex = index;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: duration, vsync: this);
    _scaleanimation = Tween<double>(begin: 1, end: 0.6).animate(_controller);
    // _coloranimation = Tween<Color>(begin: Colors.red, end: Colors.green).animate(_controller);
    // _slideanimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appLang = AppLocalizations.of(context);
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.4 * screenWidth,
      right: isCollapsed ? 0 : -0.6 * screenWidth,
      child: ScaleTransition(
        scale: _scaleanimation,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 15.0,
            selectedIconTheme: IconThemeData(size: 30),
            selectedItemColor: Colors.lightBlue[800],
            elevation: 0,
            currentIndex: _selectedIndex,
            onTap: onItemTap,
            items:  <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Digər',
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: appLang.home,
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: appLang.categories,
                backgroundColor: Colors.transparent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics),
                label: appLang.analysis,
                backgroundColor: Colors.transparent,
              )
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                image: DecorationImage(
                    image: AssetImage('assets/images/mainscrbackground.jpg'),
                    fit: BoxFit.fill),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      blurRadius: 8.0,
                      offset: Offset(-1, 8.0))
                ]),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isCollapsed == false) {
                    _controller.reverse();
                    isCollapsed = !isCollapsed;
                  }
                });
              },
              child: screens[_selectedIndex],
            ),
          ),
        ),
      ),
    );
  }
}
