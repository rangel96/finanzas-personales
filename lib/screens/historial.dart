import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:finanzas_personales/services/_services.dart';

class HistorialScreen extends StatelessWidget {
  const HistorialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final years = Provider.of<HistoryServices>(context).years;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Historial Screen'),
      ),
      body: BodyScreen(years: years),
    );
  }
}

class BodyScreen extends StatelessWidget {
  const BodyScreen({
    Key? key,
    required this.years,
  }) : super(key: key);

  final List<String> years;

  @override
  Widget build(BuildContext context) {
    return years.isNotEmpty
        ? Column(
            children: [
              const SizedBox(height: 20),
              Text('Año', style: _title(30)),
              // Years
              Expanded(
                child: ListView.separated(
                    itemBuilder: (_, __) => const Divider(),
                    separatorBuilder: (context, index) => ListTile(
                          title: Text(
                            years[index],
                            style: _title(20),
                          ),
                          trailing:
                              const Icon(Icons.arrow_forward_ios_outlined),
                          onTap: null,
                          contentPadding: const EdgeInsets.only(left: 25),
                        ),
                    itemCount: years.length + 1),
              ),
            ],
          )
        : const Center(
            child: CircularProgressIndicator.adaptive(
            semanticsLabel: 'Cargando...',
          ));
  }

  TextStyle _title(double fontSizeText) => TextStyle(
        fontSize: fontSizeText,
        fontWeight: FontWeight.w600,
      );
}
