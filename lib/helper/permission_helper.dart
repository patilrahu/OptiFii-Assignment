import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestCameraPermission() async {
    await Permission.camera.request();
    var status = await Permission.camera.status;
    if (status == PermissionStatus.granted) {
      if (await Permission.camera.request().isGranted) {
        return true;
      } else {
        return false;
      }
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    } else {
      return false;
    }
  }
}
