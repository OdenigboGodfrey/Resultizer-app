enum ResponseDataSource {
  clientClosedRequest,
  internalServerError,
  networkConnectError,
  unexpected,
}

class ResponseStatusCode {
  static const int clientClosedRequest = 499;
  static const int internalServerError = 500;
  static const int networkConnectError = 599;
  static const int unexpected = -1;
}