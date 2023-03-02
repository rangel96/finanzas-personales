import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finanzas_personales/models/_models.dart';
import 'package:flutter/material.dart';

class TagService with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final collectionMain = 'Etiquetas';

  final List<String> tagList = [];

  TagService() {
    _getPays();
  }

  Future _getPays() async {
    final docRef = _db.collection(collectionMain).orderBy('name');
    docRef.snapshots().listen((event) {
      tagList.clear();

      for (var doc in event.docs) {
        var response = PayModel.fromMap(doc.data());
        tagList.add(response.name);
      }

      notifyListeners();
    });
  }
}
