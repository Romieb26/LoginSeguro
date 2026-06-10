import 'package:flutter/material.dart';
import '../widgets/custom_textfield.dart';
import '../utils/constants.dart';
import '../widgets/custom_button.dart';
import '../services/fake_gps_service.dart';
import '../services/secure_storage_service.dart';
import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _blocked = false;

  @override
  void initState() {
    super.initState();
    checkFakeGps();
  }

  Future<void> checkFakeGps() async {
    bool fake = await FakeGpsService.detectFakeGps();

    if (fake) {
      setState(() {
        _blocked = true;
      });
    }
  }

  Future<void> login() async {
    // Datos sensibles

    await SecureStorageService.saveToken(
      "TOKEN_123456",
    );

    await SecureStorageService.saveUser(
      "romina",
    );

    await SecureStorageService.saveEmail(
      "romina@gmail.com",
    );

    DateTime expiration = DateTime.now().add(
      const Duration(seconds: 5),
    );

    await SecureStorageService.saveExpiration(
      expiration.toIso8601String(),
    );

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_blocked) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_off,
                  size: 90,
                  color: Colors.red,
                ),
                SizedBox(height: 20),
                Text(
                  "Aplicación Bloqueada",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Se detectó el uso de una aplicación Fake GPS.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 12,
              shadowColor: Colors.black26,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                width: 350,
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 35,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lock_outline,
                        size: 50,
                        color: AppColors.primary,
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      "Bienvenido",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Inicia sesión para continuar",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 30),

                    const CustomTextField(
                      label: "Usuario",
                      icon: Icons.person_outline,
                    ),

                    const SizedBox(height: 20),

                    const CustomTextField(
                      label: "Contraseña",
                      icon: Icons.lock_outline,
                      obscureText: true,
                    ),

                    const SizedBox(height: 30),

                    CustomButton(
                      text: "Iniciar Sesión",
                      onPressed: () async {
                        await login();
                      },
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "La sesión se almacenará de forma segura.",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}