import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tut_app/application/di.dart';
import 'package:tut_app/presentation/common/state_renderer/state_rendrer_impl.dart';
import 'package:tut_app/presentation/login/view_model/login_view_model.dart';
import 'package:tut_app/presentation/resources/color_maneger.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/values_maneger.dart';

import '../../../application/app_prfs.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

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

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _appPreferences.setUserLoggedIn();
          Navigator.pushReplacementNamed(context, Routes.mainRoute);
        });
      }
    });
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.login();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.p100,
          left: AppPadding.p14,
          right: AppPadding.p14,
        ),
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
                      return SizedBox(
                        width: double.infinity,
                        height: AppPadding.p40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.login();
                                  }
                                : null,
                            child: const Text(StringManager.login)),
                      );
                    }),
                const SizedBox(
                  height: AppSize.s30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      },
                      child: Text(StringManager.forgetPassword,
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      },
                      child: Text(StringManager.registerText,
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.titleMedium),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
