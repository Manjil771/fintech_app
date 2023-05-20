class CustomException implements Exception {
  CustomException([this._message, this._prefix]);

  final dynamic _message;
  final dynamic _prefix;

  dynamic get message => _message;
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class NoInternetException extends CustomException {
  NoInternetException([String? message])
      : super(message, "No Ineternet Connection");
}

class BadRequestException extends CustomException {
  BadRequestException([String? message]) : super(message, "Invalid Request ");
}

class ResourceNotFoundException extends CustomException {
  ResourceNotFoundException([String? message])
      : super(message, "Resource not found.Error code  404 ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([String? message]) : super(message, "Unauthorised  ");
}

class InternalServerErrorException extends CustomException {
  InternalServerErrorException([String? message])
      : super(message, "Server error ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input ");
}
