import 'dart:collection';

import 'package:flutter/material.dart';

class Currencies extends ChangeNotifier{

  List<String> _currencies = ['AZN', 'USD', 'TLR'];
  String currency;

  UnmodifiableListView get currencies {
    return UnmodifiableListView(_currencies);
  }
}
