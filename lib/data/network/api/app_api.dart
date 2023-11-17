import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:tut_app/data/responses/login_response/responses.dart';
import '../../../application/costants.dart';
import '../../responses/forget_password_response/forget_password_response.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient{

 factory AppServiceClient(Dio dio , {String baseUrl}) = _AppServiceClient;

  @POST("/customer/login")
 Future<AuthenticationResponse>login(
     @Field("email") String email ,
     @Field("password") String password
     );

  
  @POST("/customer/forgetPassowrd")
 Future<ForgetPasswordResponse>reset(
     @Field("email") String email
     );

}