import 'package:flutter/material.dart';
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/values_maneger.dart';

import '../../resources/assets_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = LoginViewModel(_loginUseCase);
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _bind() {
    _viewModel.start();

    _passwordController.addListener(() {
      _viewModel.setPassword(_passwordController.text);
    });

    _userNameController.addListener(() {
      _viewModel.setUserName(_userNameController.text);
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  Widget _getContentWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Image(image: AssetImage(ImageAssets.splashLogo)),
              const SizedBox(
                height: AppSize.s30,
              ),
              StreamBuilder<bool>(
                  stream: _viewModel.outIsUserName,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: _userNameController,
                      decoration: InputDecoration(
                        hintText: StringManager.userName,
                        labelText: StringManager.userName,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : StringManager.userNameError,
                      ),
                    );
                  }),
              const SizedBox(
                height: AppSize.s30,
              ),
              StreamBuilder<bool>(
                  stream: _viewModel.outIsPassword,
                  builder: (context, snapshot) {
                    return TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: StringManager.password,
                        labelText: StringManager.password,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : StringManager.passwordError,
                      ),
                    );
                  }),
              const SizedBox(
                height: AppSize.s30,
              ),
              StreamBuilder<bool>(
                  stream: _viewModel.outIsPassword,
                  builder: (context, snapshot) {
                    return ElevatedButton(onPressed: (){
                      _viewModel.login();
                    }, child: const Text(StringManager.login)) ;
                  })
            ],
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
