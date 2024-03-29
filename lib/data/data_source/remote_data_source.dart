import 'package:tut_app/data/network/api/requests.dart';


import '../network/api/app_api.dart';
import '../responses/forget_password_response/forget_password_response.dart';
import '../responses/response/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);
  Future<AuthenticationResponse> register(RegisterRequest registerRequest);
  Future<ForgetPasswordResponse> reset(ResetRequest resetRequest);
  Future<HomeResponse> getHomeData();
  Future<HomeDetailsResponse> getHomeDetailsData();

}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgetPasswordResponse> reset(ResetRequest resetRequest) async {
    return await _appServiceClient.reset(resetRequest.email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.userName,
        registerRequest.countryCode,
        registerRequest.phoneNumber,
        registerRequest.email,
        registerRequest.password,
        //registerRequest.profilePicture
        ""
    );
  }

  @override
  Future<HomeResponse> getHomeData() async {
    return await _appServiceClient.getHomeData();
  }

  @override
  Future<HomeDetailsResponse> getHomeDetailsData()async {
    return await _appServiceClient.getHomeDetailsData();
  }
}
