import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../application/costants.dart';
import '../../responses/forget_password_response/forget_password_response.dart';
import '../../responses/response/responses.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customer/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);

  @POST("/customer/forgetPassowrd")
  Future<ForgetPasswordResponse> reset(@Field("email") String email);

  @POST("/customer/register")
  Future<AuthenticationResponse> register(
    @Field("user_name") String userName,
    @Field("country_code") String countryCode,
    @Field("phone_number") String phoneNumber,
    @Field("email") String email,
    @Field("password") String password,
    @Field("profile_picture") String profilePicture,
  );

  @GET("/home")
  Future<HomeResponse> getHomeData();

}
