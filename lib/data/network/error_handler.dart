import 'package:dio/dio.dart';

import 'failure/failure.dart';


// NOTE : read this class from bottom to above



class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      // error from API response or dio
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.defaultError.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeOut.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sentTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeOut.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.badRequest.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? "");
      } else {
        return DataSource.defaultError.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.unknown:
      return DataSource.internalServerError.getFailure();
  }
}
extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMassage.success);

      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMassage.noContent);

      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMassage.badRequest);

      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMassage.forbidden);

      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMassage.notFound);

      case DataSource.unAuthorized:
        return Failure(ResponseCode.unAuthorized, ResponseMassage.unAuthorized);

      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMassage.internalServerError);

      case DataSource.connectTimeOut:
        return Failure(
            ResponseCode.connectTimeOut, ResponseMassage.connectTimeOut);

      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMassage.cancel);

      case DataSource.receiveTimeOut:
        return Failure(
            ResponseCode.receiveTimeOut, ResponseMassage.receiveTimeOut);

      case DataSource.sentTimeout:
        return Failure(ResponseCode.sentTimeout, ResponseMassage.sentTimeout);

      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMassage.cacheError);

      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMassage.noInternetConnection);

      case DataSource.defaultError:
        return Failure(ResponseCode.defaultError, ResponseMassage.defaultError);
    }
  }
}
enum DataSource {
  success,
  noContent,
  badRequest,
  notFound,
  forbidden,
  unAuthorized,
  internalServerError,
  connectTimeOut,
  cancel,
  receiveTimeOut,
  sentTimeout,
  cacheError,
  noInternetConnection,
  defaultError,
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 201; // success without data {NO CONTENT}
  static const int badRequest = 400; // failure, API rejected request
  static const int unAuthorized = 401; // failure, user is not authorized
  static const int forbidden = 403; // failure, API rejected request
  static const int notFound = 404; //failure, not found
  static const int internalServerError = 500; // failure, crash in server side

  // local status code
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receiveTimeOut = -3;
  static const int sentTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int defaultError = -7;
}

class ResponseMassage {
  static const String success = 'success'; // success with data
  static const String noContent =
      'success'; // success without data {NO CONTENT}
  static const String badRequest =
      'Bad Request, Try Again Later'; // failure, API rejected request
  static const String unAuthorized =
      'Un Authorized user ,Try Again Later'; // failure, user is not authorized
  static const String forbidden =
      'Forbidden Request ,Try Again Later '; // failure, API rejected request
  static const String notFound = "Not Found";
  static const String internalServerError =
      'something went wrong , Try Again Later'; // failure, crash in server side

  // local status code
  static const String connectTimeOut = 'Time Out Error , Try Again Later  ';
  static const String cancel = 'The Request Canceled, Try Again Later ';
  static const String receiveTimeOut = 'Time Out Error , Try Again Later  ';
  static const String sentTimeout = 'Time Out Error , Try Again Later  ';
  static const String cacheError = 'Cache Error,Try Again Later ';
  static const String noInternetConnection =
      'Please Check Your Internet Connection';
  static const String defaultError = 'something went wrong , Try Again Later';
}


// this class for api status code
// NOTE : you need to change the values according to each API
class InternalCodeStatus{
  static const int success = 0;
  static const int failure = 1;

}


