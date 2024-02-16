import 'package:tut_app/data/network/api/requests.dart';
import 'package:dartz/dartz.dart';
import 'package:tut_app/domain/entities/entities.dart';

import '../../data/network/failure/failure.dart';
abstract class Repository{

Future< Either<Failure,Authentication>> login(LoginRequest loginRequest);

Future< Either<Failure,Authentication>> register(RegisterRequest registerRequest);

Future<Either<Failure,ForgetPassword>> reset(ResetRequest resetRequest);

Future<Either<Failure,HomeObject>> getHomeData();

Future<Either<Failure,HomeDetails>> getHomeDetailsData();

}