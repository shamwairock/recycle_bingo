import 'dart:math';

class NumberUtil {
  static final Random _random = Random.secure();

  static int createCryptoRandomString([int length = 32]) {
    return _random.nextInt(256);
  }
}