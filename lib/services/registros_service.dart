import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:finanzas_personales/models/_models.dart';

class RegistrosService with ChangeNotifier {
  // Variables hidden
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final _collectionMain = 'Registros';
  final DateTime _today = DateTime.now();

  // Getters
  double _sumTotal = 0;
  double get sumTotal => _sumTotal;

  // Variables public
  final List<RegistroModel> registros = [];
  late RegistroModel selectRegistro;

  // onInit
  RegistrosService() {
    _getMovimientos();
  }

  // Method public
  void addUpdateMovimiento(RegistroModel registro) async {
    (registro.id != null) ? _setMovimiento(registro) : _addMovimiento(registro);
  }

  void deleteMovimiento(RegistroModel registro) async {
    await _db
        .collection(_collectionMain)
        .doc(registro.fechaC!.year.toString())
        .collection(registro.fechaC!.month.toString())
        .doc(registro.id)
        .delete();
  }

  // Method hidden
  void _getMovimientos() async {
    final docRef = _db
        .collection(_collectionMain)
        .doc(_today.year.toString())
        .collection(_today.month.toString())
        .orderBy('fechaC', descending: true);

    docRef.snapshots().listen(
      (event) {
        registros.clear();
        _sumTotal = 0;

        for (var doc in event.docs) {
          var data = _docParce(doc);
          var response = RegistroModel.fromMap(data);
          _sumTotal += response.amount!;
          registros.add(response);
        }

        notifyListeners();
      },
      // onError: (error) => print("Listen failed: $error"),
    );
  }

  void _addMovimiento(RegistroModel registro) async {
    await _db
        .collection(_collectionMain)
        .doc(_today.year.toString())
        .collection(_today.month.toString())
        .add(registro.toMap());

    final docRef = _db.collection(_collectionMain).doc(_today.year.toString());
    docRef.get().then(
      (documentSnapshot) {
        final data = documentSnapshot.data()!;
        if (data['meses'] == null) {
          docRef.set({
            'meses': [_today.month]
          });
          return;
        }

        final List dataList = data['meses'];
        final index = dataList.indexOf(_today.month);
        if (index != -1) {
          return;
        }

        dataList.add(_today.month);
        docRef.set({'meses': dataList});
      },
    );
  }

  void _setMovimiento(RegistroModel registro) async {
    await _db
        .collection(_collectionMain)
        .doc(registro.fechaC!.year.toString())
        .collection(registro.fechaC!.month.toString())
        .doc(registro.id)
        .set(registro.toMap());
  }

  Map<String, dynamic> _docParce(dynamic doc) {
    return {
      ...doc.data(),
      "id": doc.id,
    };
  }
}
