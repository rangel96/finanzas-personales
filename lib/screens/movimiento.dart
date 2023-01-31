import 'package:finanzas_personales/themes/app_theme.dart';
import 'package:flutter/material.dart';

const List<String> list = <String>['Efectivo', 'Nu', 'Rappi Card', 'Banorte'];

class MovimientoScreen extends StatelessWidget {
  const MovimientoScreen({Key? key}) : super(key: key);

  // Variables

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movimiento'),
      ),
      body: Center(
        child: Form(
            key: myFormKey,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Precio',
                    ),
                  ),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                    ),
                  ),
                ],
              ),
            )),
      ),
      bottomNavigationBar: _Footer(),
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
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final width = size.width / 2;
    return Row(
      children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(
              AppTheme.colorFooter,
            ),
            fixedSize: MaterialStatePropertyAll(Size(width, 55)),
          ),
          onPressed: () {},
          child: const Text(
            'Agregar',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        TextButton(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(
              AppTheme.colorFooter,
            ),
            fixedSize: MaterialStatePropertyAll(Size(width, 55)),
          ),
          onPressed: () {},
          child: const Text(
            'Limpiar',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
