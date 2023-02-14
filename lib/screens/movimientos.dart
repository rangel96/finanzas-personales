import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:finanzas_personales/services/registros_service.dart';
import 'package:finanzas_personales/themes/app_theme.dart';
import 'package:finanzas_personales/models/_models.dart';

// Variables globales
const FontWeight _fontWeight = FontWeight.w600;
final numberFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

final DateTime now = DateTime.now();
final List<String> month = [
  'Enero',
  'Febrero',
  'Marzo',
  'Abril',
  'Mayo',
  'Junio',
  'Julio',
  'Agosto',
  'Septiembre',
  'Octubre',
  'Noviembre',
  'Diciembre'
];

class MovimientosScreen extends StatelessWidget {
  const MovimientosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    final registroServices = Provider.of<RegistrosService>(context);
    List<RegistroModel> registros = registroServices.registros;
    double sumTotal = Provider.of<RegistrosService>(context).sumTotal;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        centerTitle: true,
        title: Text(
          'Movimientos \n ${month[now.month - 1]}',
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          // Total
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              numberFormat.format(sumTotal),
              style: const TextStyle(
                fontSize: 45,
                fontWeight: _fontWeight,
              ),
            ),
          ),

          // Registro List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => Slidable(
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: _slidableActionList(
                    registroServices,
                    registros[index],
                  ),
                ),
                child: _Movimiento(movimiento: registros[index]),
              ),
              itemCount: registros.length,
              separatorBuilder: (_, __) => const Divider(),
            ),
          ),
        ],
      ),

      // Footer
      bottomNavigationBar: _Footer(registroServices: registroServices),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.registroServices});

  final RegistrosService registroServices;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      style: _footerButtonStyle(size),
      onPressed: () {
        final registro = RegistroModel(amount: 0.00, title: '');

        registroServices.selectRegistro = registro;
        Navigator.pushNamed(context, 'movimiento');
      },
      child: const Text(
        'Agregar',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  ButtonStyle _footerButtonStyle(Size size) {
    return ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll<Color>(
        AppTheme.colorFooter,
      ),
      fixedSize: MaterialStatePropertyAll(Size(size.width, 60)),
      alignment: Alignment.topCenter,
    );
  }
}

class _Movimiento extends StatelessWidget {
  const _Movimiento({required this.movimiento});

  final RegistroModel movimiento;

  @override
  Widget build(BuildContext context) {
    String color = '90AFC5';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title, Amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Title
              Expanded(
                child: Text(
                  movimiento.title!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: _fontWeight,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Amount
              Text(
                numberFormat.format(movimiento.amount),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: _fontWeight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),

          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Date, Pay
              Row(
                children: [
                  // Date
                  if (movimiento.fechaC!.day > 9)
                    Text('${movimiento.fechaC!.day}')
                  else
                    Text('0${movimiento.fechaC!.day}'),
                  const SizedBox(width: 10, child: Text('-')),
                  Text(
                      '${movimiento.fechaC!.hour}:${movimiento.fechaC!.minute}'),
                  const SizedBox(width: 10, child: Text('-')),

                  // Pay
                  Text(movimiento.pay!),
                ],
              ),

              // Tag
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(int.parse('0xff$color')),
                ),
                // child: Icon(
                //   Icons.subscriptions_outlined,
                //   size: 15.0,
                //   semanticLabel: movimiento.tag,
                // ),
                child: Text(movimiento.tag!),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<Widget> _slidableActionList(
  RegistrosService registrosServices,
  RegistroModel registro,
) {
  void editRegistro(BuildContext context) {
    registrosServices.selectRegistro = registro;
    Navigator.pushNamed(context, 'movimiento');
  }

  void deleteRegistro() {
    registrosServices.deleteMovimiento(registro);
  }

  return [
    SlidableAction(
      onPressed: (_) => deleteRegistro(),
      backgroundColor: const Color(0xFFFE4A49),
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'Eliminar',
    ),
    SlidableAction(
      onPressed: editRegistro,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      icon: Icons.edit,
      label: 'Editar',
    ),
  ];
}
