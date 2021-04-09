import 'package:flutter/cupertino.dart';
import 'package:my_wallet/firebase/firestore/operation_fdb.dart';
import 'package:my_wallet/firebase/models/operation.dart';

class OperationProvider extends ChangeNotifier {
  List<Operation> _operations = [];

  List<Operation> get operations => _operations;

  List<Operation> setOperations(List<Operation> operations) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _operations = operations;
      notifyListeners();
    });
  }

  void addOperation(Operation operation) =>
      OperationFDB.createOperation(operation);

  void removeOperation(Operation operation) =>
      OperationFDB.deleteOperation(operation);

  void updateOperation({Operation operation, String price, String categoryName, int categoryIconVal}) {
    operation.price = price;
    operation.categoryName = categoryName;
    operation.categoryIconVal = categoryIconVal;

    OperationFDB.updateOperation(operation);
  }

}