

import 'package:dartz/dartz.dart';
import 'package:tut_app/data/network/failure/failure.dart';
import 'package:tut_app/domain/entities/entities.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

import '../repo/repo.dart';

class HomeDetailsUseCase implements BaseUseCase<void, HomeDetails> {
  final Repository _repository;

  HomeDetailsUseCase(this._repository);
  @override

  Future<Either<Failure, HomeDetails>> execute(void input) async {
    return await _repository.getHomeDetailsData();
  }
}

