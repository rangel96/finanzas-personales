// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:finanzas_personales/providers/flutterfire.dart';
import 'package:finanzas_personales/themes/app_theme.dart';

import '../models/_models.dart';

// Variables globales
const FontWeight _fontWeight = FontWeight.w600;
final Random _random = Random();
final DateTime now = DateTime.now();
final numberFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

class MovimientosScreen extends StatelessWidget {
  const MovimientosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterFireProvider movProvider = Provider.of<FlutterFireProvider>(context);
    List<ResponseRegistro> registros = movProvider.registros;
    double sumTotal = Provider.of<FlutterFireProvider>(context).sumTotal;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primary,
        title: const Text('Movimientos', style: TextStyle(fontSize: 20)),
      ),
      body: Column(
        children: [
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
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => Slidable(
                startActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: _slidableActionListL(registros[index]),
                ),
                child: _Movimiento(movimiento: registros[index]),
              ),
              itemCount: registros.length,
              separatorBuilder: (_, __) => const Divider(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _Footer(),
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextButton(
      style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll<Color>(
            AppTheme.colorFooter,
          ),
          fixedSize: MaterialStatePropertyAll(Size(size.width, 55))),
      onPressed: () => Navigator.pushNamed(context, 'movimiento'),
      child: const Text(
        'Agregar',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _Movimiento extends StatelessWidget {
  const _Movimiento({required this.movimiento});

  final ResponseRegistro movimiento;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  movimiento.description,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: _fontWeight,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (movimiento.fechaC.day > 9)
                    Text('${movimiento.fechaC.day}')
                  else
                    Text('0${movimiento.fechaC.day}'),
                  const SizedBox(width: 10, child: Text('-')),
                  Text('${movimiento.fechaC.hour}:${movimiento.fechaC.minute}'),
                  const SizedBox(width: 10, child: Text('-')),
                  Text(movimiento.pay),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                ),
                child: Icon(
                  Icons.subscriptions_outlined,
                  size: 15.0,
                  semanticLabel: movimiento.tag,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

List<Widget> _slidableActionListL(ResponseRegistro movimiento) {
  return [
    SlidableAction(
      onPressed: (_) {
        // todo: Delete item
        print(movimiento.id);
      },
      backgroundColor: const Color(0xFFFE4A49),
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'Eliminar',
    ),
    SlidableAction(
      onPressed: (context) => Navigator.pushNamed(
        context,
        'movimiento',
        arguments: movimiento,
      ),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      icon: Icons.edit,
      label: 'Editar',
    ),
  ];
}
