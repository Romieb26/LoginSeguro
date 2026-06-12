import 'package:flutter/material.dart';
import 'dart:io';

class SecurityBlockScreen extends StatelessWidget {
  const SecurityBlockScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future.delayed(
      Duration.zero,
          () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return AlertDialog(
              title: const Text(
                "Alerta de Seguridad",
              ),
              content: const Text(
                "La depuración USB está activa.\n\n"
                    "Por políticas de seguridad la aplicación "
                    "no puede ejecutarse.\n\n"
                    "Desactive la opción "
                    "Depuración USB desde los ajustes del dispositivo.",
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: const Text(
                    "Cerrar Aplicación",
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}