import 'package:firebase_messaging/firebase_messaging.dart';
import 'secure_storage_service.dart';

class FcmWipeService {

  static Future<void> init() async {

    print("🔥 FCM WIPE SERVICE INICIADO");

    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) async {

        print("=========== MENSAJE RECIBIDO ===========");
        print(message.data);

        String? currentUser =
        await SecureStorageService.getUser();

        print("Usuario actual:");
        print(currentUser);

        print("Action:");
        print(message.data['action']);

        print("User:");
        print(message.data['user']);

        if (message.data['action'] == 'WIPE_USER' &&
            message.data['user'] == currentUser) {

          print("🚨 WIPE REMOTO ACTIVADO");

          await SecureStorageService.clearSession();

          print("🚨 DATOS SENSIBLES ELIMINADOS");
        }
      },
    );
  }
}