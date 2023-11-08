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
  Function retryLaterFunction;
  StateRenderer(
      {required this.stateRendererType,
      this.title = '',
      this.message = StringManager.loading,
      required this.retryLaterFunction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(),
        ]);
      case StateRendererType.popupErrorState:
        return _getPopUpDialog(context, [
          _getAnimatedImage(),
          _getMessage(message),
          _getRetryButton(StringManager.ok, context),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemColumn([_getAnimatedImage(), _getMessage(message)]);

      case StateRendererType.fullScreenErrorState:
        return _getItemColumn([
          _getAnimatedImage(),
          _getMessage(message),
          _getRetryButton(StringManager.tryAgain, context),
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemColumn([
          _getAnimatedImage(),
          _getMessage(message),
        ]);
      case StateRendererType.contentState:
        return Container();

      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s16),
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
              )
            ]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage() {
    return Center(
      child: SizedBox(
        height: AppSize.s100,
        width: AppSize.s100,
        child: Container(),
      ),
    );
  }

  Widget _getMessage(String massage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Text(
          massage,
          style: getRegularTextStyle(
            color: ColorManager.black,
            fontSize: FontSize.s18,
          ),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.fullScreenLoadingState) {
                  retryLaterFunction.call();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                buttonTitle,
              )),
        ),
      ),
    );
  }
}
