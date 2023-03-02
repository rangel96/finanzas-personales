import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finanzas_personales/models/_models.dart';
import 'package:flutter/material.dart';

class PayService with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final collectionMain = 'Pagos';

  final List<String> payList = [];

  PayService() {
    _getPays();
  }

  Future _getPays() async {
    final docRef = _db.collection(collectionMain).orderBy('name');
    docRef.snapshots().listen((event) {
      payList.clear();

      for (var doc in event.docs) {
        var response = PayModel.fromMap(doc.data());
        payList.add(response.name);
      }

      notifyListeners();
    });
  }
}
