import 'dart:developer' as developer;

class Logger {
  static void Write(String message){
    var now = new DateTime.now();
    developer.log(message, name: now.toString());
  }
}