enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorized,
  internalServerError,
  connectTimeOut,
  cancel,
  receiveTimeOut,
  sentTimeout,
  cacheError,
  noInternetConnection,
  unKnown
}

class ResponseCode{
  static const int success = 200; // success with data
  static const int noContent = 201; // success without data {NO CONTENT}
  static const int badRequest = 400; // failure, API rejected request
  static const int unAuthorized = 401; // failure, user is not authorized
  static const int forbidden = 403; // failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side


  // local status code
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receiveTimeOut = -3;
  static const int sentTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int unKnown = -7;

}
class ResponseMassage{
  static const String success = 'success'; // success with data
  static const String noContent = 'success'; // success without data {NO CONTENT}
  static const String badRequest = 'Bad Request, Try Again Later'; // failure, API rejected request
  static const String unAuthorized = 'Un Authorized user ,Try Again Later'; // failure, user is not authorized
  static const String forbidden = 'Forbidden Request ,Try Again Later '; // failure, API rejected request
  static const String internalServerError = 'something went wrong , Try Again Later'; // failure, crash in server side


  // local status code
  static const String connectTimeOut = 'Time Out Error , Try Again Later  ';
  static const String cancel = 'The Request Canceled, Try Again Later ';
  static const String receiveTimeOut = 'Time Out Error , Try Again Later  ';
  static const String sentTimeout ='Time Out Error , Try Again Later  ';
  static const String cacheError ='Cache Error,Try Again Later ' ;
  static const String noInternetConnection ='Please Check Your Internet Connection' ;
  static const String unKnown = 'something went wrong , Try Again Later';

}

