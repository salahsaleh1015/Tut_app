import 'package:flutter/material.dart';
import 'package:tut_app/presentation/forget_password/view_model/forget_password_view_model.dart';
import 'package:tut_app/presentation/resources/color_maneger.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';

import '../../../application/di.dart';
import '../../resources/assets_manager.dart';
import '../../resources/values_maneger.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final ForgetPasswordViewModel _viewModel = instance<ForgetPasswordViewModel>();
  final TextEditingController _userNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  _bind(){
    _viewModel.start();
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
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: _getContentWidget(),
    );
  }

  Widget _getContentWidget() {
    return Padding(
        padding:  const EdgeInsets.only(
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
                    stream: _viewModel.isOutUserName,
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
                    stream: _viewModel.isOutUserName,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppPadding.p40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                              _viewModel.reset();
                            }
                                : null,
                            child: const Text(StringManager.login)),
                      );
                    }),
                const SizedBox(
                  height: AppSize.s30,
                ),

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
