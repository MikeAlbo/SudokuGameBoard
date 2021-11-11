import 'dart:async';

class ReadyState {
  late Future<bool> r;

  Future<bool> get ready async {
    return await ready == true;
  }

  void notReady() {
    r = false as Future<bool>;
  }

  void isReady() {
    r = true as Future<bool>;
  }
}
