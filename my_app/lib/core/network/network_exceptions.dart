class NetworkExceptions {
  static String handleError(dynamic error) {
    if (error is Exception) {
      return error.toString();
    }
    return "Unknown error occurred";
  }
}
