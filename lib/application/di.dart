import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/application/app_prfs.dart';
import 'package:tut_app/data/data_source/remote_data_source.dart';
import 'package:tut_app/data/network/api/app_api.dart';
import 'package:tut_app/data/network/api/dio_factory.dart';
import 'package:tut_app/data/repo_impl/repo_impl.dart';
import 'package:tut_app/domain/repo/repo.dart';
import 'package:tut_app/domain/usecase/forget_password_usecase.dart';
import 'package:tut_app/domain/usecase/home_usecase.dart';
import 'package:tut_app/domain/usecase/login_usecase.dart';
import 'package:tut_app/domain/usecase/register_usecase.dart';
import 'package:tut_app/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';
import 'package:tut_app/presentation/main/home/view_model/home_view_model.dart';
import 'package:tut_app/presentation/register/view_model/register_view_model.dart';

import '../data/network/internet_info.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // all generic di implemented Here,

  // instance from shared prefs
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  // instance from app prefs
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //Internet Info
  instance.registerLazySingleton<InternetInfo>(
      () => InternetInfoImpl(InternetConnectionChecker()));

  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  // app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));

  //repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(() => RegisterViewModel(instance()));
    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initForgetPasswordModule(){
  if(!GetIt.I.isRegistered<ForgetPasswordUseCase>()){
    instance.registerFactory<ForgetPasswordUseCase>(() => ForgetPasswordUseCase(instance()));
    instance.registerFactory<ForgetPasswordViewModel>(() => ForgetPasswordViewModel(instance()));
  }
}

  initHomeModule() {
    if (!GetIt.I.isRegistered<HomeUseCase>()) {
      instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
      instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
    }
  }
