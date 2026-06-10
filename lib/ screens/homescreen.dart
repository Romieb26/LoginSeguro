import 'package:flutter/material.dart';
import '../services/session_service.dart';
import '../services/secure_storage_service.dart';
import 'loginscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String token = "";
  String expiration = "";
  String user = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    loadSessionData();
    startTimer();
  }

  Future<void> loadSessionData() async {
    String? savedToken =
    await SecureStorageService.getToken();

    String? savedExpiration =
    await SecureStorageService.getExpiration();

    String? savedUser =
    await SecureStorageService.getUser();

    String? savedEmail =
    await SecureStorageService.getEmail();

    setState(() {
      token = savedToken ?? "No encontrado";
      expiration =
          savedExpiration ?? "No encontrado";
      user = savedUser ?? "No encontrado";
      email = savedEmail ?? "No encontrado";
    });
  }

  void startTimer() {
    SessionService.startSession(
      seconds: 5,
      onTimeout: () async {
        await SecureStorageService.clearSession();

        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
                (route) => false,
          );

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Sesión cerrada por inactividad",
              ),
            ),
          );
        }
      },
    );
  }

  void resetTimer() {
    print("Usuario interactuó");

    SessionService.resetSession(
      seconds: 5,
      onTimeout: () async {
        await SecureStorageService.clearSession();

        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
                (route) => false,
          );
        }
      },
    );
  }

  Future<void> logout() async {
    await SecureStorageService.clearSession();

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: resetTimer,
      onPanDown: (_) => resetTimer(),
      onScaleStart: (_) => resetTimer(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Inicio"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_user,
                        size: 90,
                        color: Colors.green,
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Sesión Iniciada",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "La sesión se encuentra activa y protegida.",
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 25),

                      Text(
                        "Token:",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: Colors
                              .grey
                              .shade700,
                        ),
                      ),

                      const SizedBox(height: 10),

                      SelectableText(
                        token,
                        textAlign:
                        TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "Expiración:",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: Colors
                              .grey
                              .shade700,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        expiration,
                        textAlign:
                        TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "Usuario:",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: Colors
                              .grey
                              .shade700,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        user,
                        textAlign:
                        TextAlign.center,
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "Email:",
                        style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          color: Colors
                              .grey
                              .shade700,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        email,
                        textAlign:
                        TextAlign.center,
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.logout,
                          ),
                          label: const Text(
                            "Cerrar Sesión",
                          ),
                          onPressed: logout,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}