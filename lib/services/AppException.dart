class AppException implements Exception {
 final String message;
 final String prfix;
 final String  url;

  AppException({this.message, this.prfix, this.url});
}
class BadRequestException extends AppException {
  BadRequestException ([String message, String url]) :super (message: message, prfix: 'Bad Request', url: url );
}
class FetchdataException extends AppException {
  FetchdataException ([String message, String url]) :super (message: message, prfix: 'Unable to process', url: url );

}
class ApiNotRespondingException extends AppException {
  ApiNotRespondingException ([String message, String url]) :super (message: message, prfix: 'Api not responding', url: url );

}

class UnAutorizedException extends AppException {
  UnAutorizedException ([String message, String url]) :super (message: message, prfix: 'Un-autorized access', url: url );

}
