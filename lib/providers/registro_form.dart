import 'package:finanzas_personales/models/_models.dart';
import 'package:flutter/material.dart';

class RegistroForm extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final RegistroModel _registro;
  RegistroModel get registro => _registro;

  RegistroForm(this._registro);

  bool isValidForm() => formKey.currentState?.validate() ?? false;
}
