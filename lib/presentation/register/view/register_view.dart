import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tut_app/application/costants.dart';
import 'package:tut_app/application/di.dart';
import 'package:tut_app/presentation/register/view_model/register_view_model.dart';
import 'package:tut_app/presentation/resources/color_maneger.dart';
import 'package:tut_app/presentation/resources/values_maneger.dart';

import '../../../application/app_prfs.dart';
import '../../common/state_renderer/state_rendrer_impl.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/string_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _imagePicker = instance<ImagePicker>();
  final TextEditingController _userNameTextEditingController =
      TextEditingController();
  final TextEditingController _phoneNumberTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  _bind() {
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });
    _phoneNumberTextEditingController.addListener(() {
      _viewModel.setPhoneNumber(_phoneNumberTextEditingController.text);
    });

    _emailTextEditingController.addListener(() {
      _viewModel.setEmail(_emailTextEditingController.text);
    });

    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });

    _viewModel.isUserRegisteredSuccessfullyStreamController.stream
        .listen((isRegistered) {
      if (isRegistered) {
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
    _viewModel.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        iconTheme: IconThemeData(color: ColorManager.black, size: AppSize.s16),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.register();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.p40,
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
                  height: AppSize.s18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s30),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorUserName,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameTextEditingController,
                          decoration: InputDecoration(
                              hintText: StringManager.userName,
                              labelText: StringManager.userName,
                              errorText: snapshot.data),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSize.s30),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CountryCodePicker(
                              onChanged: (country) {
                                _viewModel.setCountryCode(
                                    country.dialCode ?? Constants.token);
                              },
                              initialSelection: '+20',
                              favorite: const ['+39', 'FR', "+966"],
                              // optional. Shows only country name and flag
                              showCountryOnly: true,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: true,
                              // optional. aligns the flag and the Text left
                              hideMainText: true,
                            )),
                        Expanded(
                          flex: 4,
                          child: StreamBuilder<String?>(
                              stream: _viewModel.outputErrorPhoneNumber,
                              builder: (context, snapshot) {
                                return TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _phoneNumberTextEditingController,
                                  decoration: InputDecoration(
                                      hintText: StringManager.phoneNumber,
                                      labelText: StringManager.phoneNumber,
                                      errorText: snapshot.data),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s30),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorEmail,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailTextEditingController,
                          decoration: InputDecoration(
                              hintText: StringManager.email,
                              labelText: StringManager.email,
                              errorText: snapshot.data),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s30),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorPassword,
                      builder: (context, snapshot) {
                        return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordTextEditingController,
                          decoration: InputDecoration(
                              hintText: StringManager.password,
                              labelText: StringManager.password,
                              errorText: snapshot.data),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s30),
                  child: Container(
                    height: AppSize.s40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppPadding.p8),
                        border: Border.all(color: ColorManager.grey)),
                    child: GestureDetector(
                      child: _getMediaWidget(),
                      onTap: () {
                        _showPicker(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSize.s30),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputAreAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppPadding.p40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.register();
                                    }
                                  : null,
                              child: const Text(StringManager.register)),
                        );
                      }),
                ),
                const SizedBox(
                  height: AppSize.s40,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: Text(StringManager.alreadyHaveAnAccount,
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _getMediaWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.s8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Flexible(child: Text(StringManager.profilePicture)),
          Flexible(
              child: StreamBuilder<File>(
            stream: _viewModel.outputProfilePicture,
            builder: (context, snapshot) {
              return _imagePicketByUser(snapshot.data);
            },
          )),
          Flexible(child: SvgPicture.asset(ImageAssets.photoCameraIc)),
        ],
      ),
    );
  }

  Widget _imagePicketByUser(File? image) {
    if (image != null && image.path.isNotEmpty) {
      return Image.file(image);
    } else {
      return Container();
    }
  }

  _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera),
                title: const Text(StringManager.photoGallery),
                onTap: () {
                  _imageFromGallery();
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward),
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text(StringManager.photoCamera),
                onTap: () {
                  _imageFromCamera();
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  _imageFromGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfilePicture(File(image?.path ?? ""));
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
