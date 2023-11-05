import 'package:flutter/material.dart';
import 'package:tut_app/presentation/resources/color_maneger.dart';
import 'package:tut_app/presentation/resources/font_manager.dart';
import 'package:tut_app/presentation/resources/style_maneger.dart';
import 'package:tut_app/presentation/resources/values_maneger.dart';

import '../../resources/string_manager.dart';

enum StateRendererType {
  // popup
  popupLoadingState,
  popupErrorState,

  // full screen
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  // general
  contentState
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryLater;
  StateRenderer(
      {required this.stateRendererType,
      this.title = '',
      this.message = StringManager.loading,
      required this.retryLater});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget _getStateWidget() {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        break;
      case StateRendererType.popupErrorState:
        break;
      case StateRendererType.fullScreenLoadingState:
        return _getItemColumn([
          _getAnimatedImage(),
          _getMessage(message)
        ]);

      case StateRendererType.fullScreenErrorState:
        return _getItemColumn([
          _getAnimatedImage(),
          _getMessage(message),
          _getRetryButton(StringManager.tryAgain),
        ]);
      case StateRendererType.fullScreenEmptyState:
        break;
      case StateRendererType.contentState:
        break;
    }
  }

  Widget _getItemColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage() {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Container(),
    );
  }

  Widget _getMessage(String massage) {
    return Text(
      massage,
      style: getRegularTextStyle(
        color: ColorManager.black,
        fontSize: FontSize.s18,
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle) {
    return ElevatedButton(
        onPressed: () {},
        child: Text(
          buttonTitle,
        ));
  }
}
