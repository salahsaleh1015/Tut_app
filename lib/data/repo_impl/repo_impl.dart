import 'package:dartz/dartz.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/mappers/mappers.dart';
import 'package:tut_app/data/network/api/requests.dart';
import 'package:tut_app/data/network/failure/failure.dart';
import 'package:tut_app/data/network/internet_info.dart';
import 'package:tut_app/domain/entities/entities.dart';
import 'package:tut_app/domain/repo/repo.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final InternetInfo _internetInfo;

  RepositoryImpl(this._remoteDataSource, this._internetInfo);

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _internetInfo.isConnected) {
      final response = await _remoteDataSource.login(loginRequest);
      // its connected to internet and safe call API
      if (response.status == 0) {
        //success
        return Right(response.toDomain());
      } else {
       // business error
      return  Left(Failure(409 , response.message??"business error message"));
      }
    } else {
      // internet connection error
     return  Left(Failure(501,"please check your internet connection"));
    }
  }
}
