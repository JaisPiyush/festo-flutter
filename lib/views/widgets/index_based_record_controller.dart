import 'package:flutter/material.dart';

class IndexBasedRecordController<T> extends ChangeNotifier {
  Map<int, T> record = {};
  IndexBasedRecordController({Map<int, T>? record}) {
    this.record = record ?? {};
  }

  void setRecord(int key, T value) {
    record[key] = value;
    notifyListeners();
  }

  factory IndexBasedRecordController.fromList(List<T> array) {
    Map<int, T> record = {};
    for (var i = 0; i < array.length; i++) {
      record[i] = array[i];
    }
    return IndexBasedRecordController(record: record);
  }
}
