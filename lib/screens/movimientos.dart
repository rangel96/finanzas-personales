import 'package:finanzas_personales/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'dart:math' show Random;
import 'package:intl/intl.dart';

// Variables globales
const FontWeight _fontWeight = FontWeight.w600;
final Random _random = Random();
final DateTime now = DateTime.now();
final numberFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

class MovimientosScreen extends StatelessWidget {
  const MovimientosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              numberFormat.format(_random.nextInt(30000).toDouble()),
              style: const TextStyle(
                fontSize: 45,
                fontWeight: _fontWeight,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'movimiento'),
              child: ListView.separated(
                itemCount: 15,
                separatorBuilder: (_, __) => const Divider(thickness: 3),
                itemBuilder: (context, index) => _Movimiento(),
              ),
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
              const Text(
                'Pago Spotify',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: _fontWeight,
                ),
              ),
              Text(
                numberFormat.format(_random.nextInt(500).toDouble()),
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
              Text('${now.day} - ${now.hour}:${now.minute} - Efectivo'),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                ),
                child: const Icon(Icons.subscriptions_outlined, size: 15.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
