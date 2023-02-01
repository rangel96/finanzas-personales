import 'package:finanzas_personales/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

const List<String> list = <String>['Efectivo', 'Nu', 'Rappi Card', 'Banorte'];
const List<String> tag = <String>['Suscripción', 'Housing', 'Comida', 'Renta'];

class MovimientoScreen extends StatelessWidget {
  const MovimientoScreen({Key? key}) : super(key: key);

  // Variables

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, dynamic> formValues = {
      'money': 0,
      'description': '',
      'pay': '',
      'tag': '',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movimiento'),
      ),
      body: Center(
        child: Form(
            key: myFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: TextFormField(
                    autofocus: true,
                    textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                    ),
                    style: const TextStyle(
                      fontSize: 35,
                    ),
                    inputFormatters: [
                      CurrencyInputFormatter(leadingSymbol: '\$'),
                    ],
                    onChanged: (value) => formValues['money'] = value,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                    ),
                    onChanged: (value) => formValues['description'] = value,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: _DropdownButtonCustom(
                    value: list.first,
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      formValues['pay'] = value;
                      print(value);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: _DropdownButtonCustom(
                    value: tag.first,
                    items: tag.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      formValues['tag'] = value;
                      print(value);
                    },
                  ),
                ),
              ],
            )),
      ),
      bottomNavigationBar: _Footer(formValues: formValues),
    );
  }
}

class _DropdownButtonCustom extends StatelessWidget {
  const _DropdownButtonCustom({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<DropdownMenuItem<String>> items;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      isExpanded: true,
      underline: Container(
        height: 1,
        color: Colors.grey,
      ),
      items: items,
      onChanged: onChanged,
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.formValues});

  void _onSummit() {
    print(formValues);
  }

  void _onReset() {
    print('Reset form');
  }

  final Map<String, dynamic> formValues;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double width = size.width / 2;
    const double height = 60;
    const double fontSize = 25;

    return Row(
      children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(
              AppTheme.colorAdd,
            ),
            fixedSize: MaterialStatePropertyAll(Size(width, height)),
          ),
          onPressed: _onSummit,
          child: const Text(
            'Agregar',
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(
              AppTheme.colorReset,
            ),
            fixedSize: MaterialStatePropertyAll(Size(width, height)),
          ),
          onPressed: _onReset,
          child: const Text(
            'Limpiar',
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
