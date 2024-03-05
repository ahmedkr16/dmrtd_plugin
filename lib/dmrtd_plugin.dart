import 'package:dmrtd_plugin/models/document..dart';
import 'dmrtd_platform_interface.dart';

class DmrtdPlugin {
  Future<Document> read(String passportNumber, String expirationDate, String birthDate, Function(String) onStatusChange) {
    return DmrtdPlatform.instance.read(passportNumber, expirationDate, birthDate, onStatusChange);
  }
}
