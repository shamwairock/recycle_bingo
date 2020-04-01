import 'dart:developer' as developer;

class Logger {
  static void write(String message){
    var now = new DateTime.now();
    developer.log(message, name: now.toString());
  }
}