import 'package:tut_app/data/network/api/requests.dart';
import 'package:tut_app/data/responses/login_response/responses.dart';

import '../network/api/app_api.dart';



abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }
}
