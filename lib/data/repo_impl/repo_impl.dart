import 'package:dartz/dartz.dart';
import 'package:tut_app/data/data_source/local_data_sourse.dart';
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
  final LocalDataSource _localDataSource;
  final InternetInfo _internetInfo;

  RepositoryImpl(this._remoteDataSource, this._internetInfo , this._localDataSource);

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
  @override
  Future<Either<Failure, Authentication>> register(RegisterRequest registerRequest) async{
    if (await _internetInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
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


  @override
  Future<Either<Failure, ForgetPassword>> reset(
      ResetRequest resetRequest) async {
    if (await _internetInfo.isConnected) {
      try {
        final response = await _remoteDataSource.reset(resetRequest);

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
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async {
    try {
      // get response from cache
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
    } catch (cacheError) {
      // cache is not existing or cache is not valid

      // its the time to get from API side
      if (await _internetInfo.isConnected) {
        // its connected to internet, its safe to call API
        try {
          final response = await _remoteDataSource.getHomeData();

          if (response.status == InternalCodeStatus.success) {
            // success
            // return either right
            // return data
            // save home response to cache

            // save response in cache (local data source)
            _localDataSource.saveHomeToCache(response);

            return Right(response.toDomain());
          } else {
            // failure --return business error
            // return either left
            return Left(Failure(InternalCodeStatus.failure,
                response.message ?? ResponseMassage.defaultError));
          }
        } catch (error) {
          return Left(ErrorHandler
              .handle(error)
              .failure);
        }
      } else {
        // return internet connection error
        // return either left
        return Left(DataSource.noInternetConnection.getFailure());
      }
    }
  }



  }




