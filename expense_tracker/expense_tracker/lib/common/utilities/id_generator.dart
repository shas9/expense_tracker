class IdGenerator {
  static int generateId() {
    return (DateTime.now().millisecondsSinceEpoch + 
           (DateTime.now().microsecondsSinceEpoch % 1000)) % 1000000007;
  }
}