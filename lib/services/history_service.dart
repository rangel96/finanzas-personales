import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryServices with ChangeNotifier {
  // Variables hidden
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _collectionMain = 'Registros';

  // Variables public
  final List<String> years = [];
  final List<String> months = [];

  HistoryServices() {
    years.clear();
    _getYears();
    // getMonths('2023');
    test();
  }

  final DateTime _today = DateTime.now();

  // Method hidden
  void _getYears() async {
    final docRef = _db.collection(_collectionMain);
    docRef.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        years.add(doc.id);
      }
      years.sort();

      notifyListeners();
    });
  }

  getMonths(String year) async {
    months.clear();

    final docRef = _db.collection(_collectionMain).doc(year);
    docRef.get().then(
      (documentSnapshot) {
        if (!documentSnapshot.exists) {
          return;
        }

        final data = documentSnapshot.data()!['meses'];
        months.clear();
        months.addAll(data);
      },
    );
  }

  test() async {
    final docRef = _db.collection(_collectionMain).doc('2023');
    docRef.get().then(
      (documentSnapshot) {
        if (!documentSnapshot.exists) {
          return;
        }

        final data = documentSnapshot.data()!;
        if (data['meses'] == null) {
          docRef.set({
            'meses': [_today.month]
          });
          return;
        }

        final List dataList = documentSnapshot.data()!['meses'];
        final index = dataList.indexOf(_today.month);
        if (index != -1) {
          return;
        }

        dataList.add(_today.month);
        docRef.set({'meses': dataList});
      },
    );
  }
}
