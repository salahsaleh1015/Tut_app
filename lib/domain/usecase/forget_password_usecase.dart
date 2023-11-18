import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/api/requests.dart';
import 'package:tut_app/data/network/failure/failure.dart';
import 'package:tut_app/domain/repo/repo.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

import '../entities/entities.dart';

class ForgetPasswordUseCase
    implements BaseUseCase<ResetUseCaseInput, ForgetPassword> {
  final Repository _repository;

  ForgetPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, ForgetPassword>> execute(
      ResetUseCaseInput input) async {
    return await _repository.reset(ResetRequest(input.message));
  }
}

class ResetUseCaseInput {
  String message;
  ResetUseCaseInput(this.message);
}
