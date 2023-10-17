import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/api/requests.dart';
import 'package:tut_app/data/network/failure/failure.dart';
import 'package:tut_app/domain/entities/entities.dart';
import 'package:tut_app/domain/repo/repo.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository _repository;

  LoginUseCase(this._repository);
  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    return await _repository.login(LoginRequest(input.email, input.password));
  }
}

class LoginUseCaseInput {
  String email;
  String password;
  LoginUseCaseInput(this.password, this.email);
}
