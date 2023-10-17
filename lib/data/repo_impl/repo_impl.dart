import 'package:dartz/dartz.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/mappers/mappers.dart';
import 'package:tut_app/data/network/api/requests.dart';
import 'package:tut_app/data/network/failure/failure.dart';
import 'package:tut_app/data/network/internet_info.dart';
import 'package:tut_app/domain/entities/entities.dart';
import 'package:tut_app/domain/repo/repo.dart';

import '../network/failure/error_handler.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final InternetInfo _internetInfo;

  RepositoryImpl(this._remoteDataSource, this._internetInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _internetInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        // its connected to internet and safe call API
        if (response.status == InternalCodeStatus.success) {
          //success
          return Right(response.toDomain());
        } else {
          // business error
          return Left(Failure(InternalCodeStatus.failure,
              response.message ?? ResponseMassage.defaultError));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // internet connection error
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
