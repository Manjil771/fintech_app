class AppSession {
  static bool _hasRun = false;

  static void runOnce(Function action) {
    if (!_hasRun) {
      _hasRun = true;
      action();
    }
  }
}
