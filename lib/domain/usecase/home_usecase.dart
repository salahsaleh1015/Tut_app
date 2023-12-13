import 'package:dartz/dartz.dart';
import 'package:tut_app/domain/entities/entities.dart';
import 'package:tut_app/domain/repo/repo.dart';
import 'package:tut_app/domain/usecase/base_usecase.dart';

import '../../data/network/failure/failure.dart';

class HomeUseCase implements BaseUseCase<void, HomeObject> {
  final Repository _repository;

  HomeUseCase(this._repository);
  @override

  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHomeData();
  }
}


