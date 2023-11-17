class LoginRequest{
  String email;
  String password;
  LoginRequest(this.email, this.password);


}

class ResetRequest{
  String email;

  ResetRequest(this.email);
}