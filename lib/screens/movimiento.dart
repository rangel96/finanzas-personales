import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

import 'package:finanzas_personales/providers/registro_form.dart';
import 'package:finanzas_personales/services/_services.dart';
import 'package:finanzas_personales/themes/app_theme.dart';
import 'package:finanzas_personales/widgets/_widgets.dart';

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

    final payList = Provider.of<PayService>(context).payList;
    final tagList = Provider.of<TagService>(context).tagList;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movimiento'),
      ),
      body: Center(
        child: _RegistroForm(
          registroForm: registroForm,
          payList: payList,
          tagList: tagList,
        ),
      ),
      bottomNavigationBar: FooterButton(
        title: registro.id != null ? 'Actualizar' : 'Registrar',
        backgroundColor: AppTheme.colorReset,
        color: Colors.white,
        onPressed: () {
          registro.fechaC ??= DateTime.now();

          if (!registroForm.isValidForm()) return;

          registrosService.addUpdateMovimiento(registro);
          Navigator.pop(context);
        },
      ),
    );
  }
}

class _RegistroForm extends StatelessWidget {
  const _RegistroForm({
    required this.registroForm,
    required this.payList,
    required this.tagList,
  });

  final RegistroForm registroForm;
  final List<String> payList;
  final List<String> tagList;

  @override
  Widget build(BuildContext context) {
    final registro = registroForm.registro;
    var amount = '';

    if (payList.isNotEmpty) {
      registro.pay = payList.first;
    }

    if (tagList.isNotEmpty) {
      registro.tag = tagList.first;
    }

    // if (registro.amount != null) {
    //   registro.amount = toCurrencyString(registro.amount.toString());
    // }
    String toCurrency(double value) {
      return toCurrencyString(
        value.toString(),
        leadingSymbol: '\$',
        useSymbolPadding: true,
      );
    }

    return Form(
        key: registroForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Precio
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: TextFormField(
                autofocus: true,
                initialValue: registro.amount != null
                    // ? '\$ ${registro.amount}'
                    ? toCurrency(registro.amount!)
                    : '',
                // toCurrency(registro.amount.toString()),
                validator: (value) =>
                    (value == null || value.length < 2) ? '* Requerido' : null,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Precio'),
                style: const TextStyle(fontSize: 35),
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
                validator: (value) {
                  return (value == null || value.length < 2)
                      ? '* Requerido'
                      : null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: 'Nombre'),
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
                decoration: const InputDecoration(labelText: 'Descripción'),
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
            const SizedBox(height: 40),
          ],
        ));
  }
}
