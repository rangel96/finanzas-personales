import 'package:finanzas_personales/models/_models.dart';
import 'package:finanzas_personales/widgets/_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'package:finanzas_personales/providers/registro_form.dart';
import 'package:finanzas_personales/services/_services.dart';
import 'package:finanzas_personales/themes/app_theme.dart';

class MovimientoScreen extends StatelessWidget {
  const MovimientoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registrosService = Provider.of<RegistrosService>(context);

    return ChangeNotifierProvider(
      create: (_) => RegistroForm(registrosService.selectRegistro),
      child: _RegistroScreenBody(registrosService: registrosService),
    );
  }
}

class _RegistroScreenBody extends StatelessWidget {
  const _RegistroScreenBody({
    required this.registrosService,
  });

  final RegistrosService registrosService;

  @override
  Widget build(BuildContext context) {
    final registroForm = Provider.of<RegistroForm>(context);
    final registro = registroForm.registro;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movimiento'),
      ),
      body: Center(
        child: _RegistroForm(registroForm: registroForm),
      ),
      bottomNavigationBar: _footer(
        context,
        registrosService,
        registroForm,
        registro,
      ),
    );
  }
}

class _RegistroForm extends StatelessWidget {
  const _RegistroForm({
    required this.registroForm,
  });

  final RegistroForm registroForm;

  @override
  Widget build(BuildContext context) {
    final payList = Provider.of<PayService>(context).payList;

    final registro = registroForm.registro;
    if (registro.pay == '' && payList.isNotEmpty) registro.pay = payList.first;

    final tagList = Provider.of<TagService>(context).tagList;
    if (registro.tag == '' && tagList.isNotEmpty) registro.tag = tagList.first;

    return Form(
        key: registroForm.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Precio
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: TextFormField(
                autofocus: true,
                initialValue: '\$ ${registro.amount}',
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Precio',
                ),
                style: const TextStyle(
                  fontSize: 35,
                ),
                inputFormatters: [
                  CurrencyInputFormatter(
                    leadingSymbol: '\$',
                    useSymbolPadding: true,
                    onValueChange: (value) {
                      registro.amount = value.toDouble();
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                autofocus: true,
                initialValue: registro.title,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                ),
                onChanged: (value) => registro.title = value,
              ),
            ),
            const SizedBox(height: 20),

            // Description
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextFormField(
                autofocus: true,
                initialValue: registro.description,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                ),
                onChanged: (value) => registro.description = value,
              ),
            ),
            const SizedBox(height: 20),

            // Pay
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: DropdownButtonWidget(
                list: payList,
                value: registro.pay ?? '',
                onChanged: (value) {
                  if (value == null) return;

                  registro.pay = value;
                  registroForm.updatePay(value);
                },
              ),
            ),
            const SizedBox(height: 20),

            // Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: DropdownButtonWidget(
                list: tagList,
                value: registro.tag ?? '',
                onChanged: (value) {
                  if (value == null) return;

                  registro.tag = value;
                  registroForm.updateTag(value);
                },
              ),
            ),
            const SizedBox(height: 30),
          ],
        ));
  }
}

Widget _footer(
  BuildContext context,
  RegistrosService registrosService,
  RegistroForm registroForm,
  RegistroModel formValues,
) {
  void onSummit() {
    formValues.fechaC = DateTime.now();
    registrosService.addUpdateMovimiento(formValues);
    Navigator.pop(context);
  }

  Size size = MediaQuery.of(context).size;
  final double width = size.width;
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
        onPressed: onSummit,
        child: const Text(
          'Agregar',
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
