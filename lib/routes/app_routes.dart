import 'package:finanzas_personales/screens/_screens.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'movimientos';

  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({'movimientos': (_) => const MovimientosScreen()});
    appRoutes.addAll({'movimiento': (_) => const MovimientoScreen()});
    appRoutes.addAll({'historial': (_) => const HistorialScreen()});

    return appRoutes;
  }
}
