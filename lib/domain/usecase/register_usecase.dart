import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/api/requests.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

import '../../data/network/failure/failure.dart';
import '../entities/entities.dart';
import '../repo/repo.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
      input.userName,
      input.countryCode,
      input.phoneNumber,
      input.email,
      input.password,
      input.profilePicture,
    ));
  }
}

class RegisterUseCaseInput {
  String userName;
  String countryCode;
  String phoneNumber;
  String email;
  String password;
  String profilePicture;

  RegisterUseCaseInput(this.userName, this.countryCode, this.phoneNumber,
      this.email, this.password, this.profilePicture);
}
