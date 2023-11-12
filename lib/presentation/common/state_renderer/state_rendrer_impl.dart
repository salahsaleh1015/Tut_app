import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/application/costants.dart';
import 'package:tut_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

//loading flow (popup - full screen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;

  LoadingState(
      {required this.stateRendererType, this.message = StringManager.loading});

  @override
  String getMessage() => message ?? StringManager.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//error flow (popup - full screen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state
class ContentState extends FlowState {
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

// empty state
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

extension FlowStateExtenstion on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryLaterFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popupLoadingState) {
            // represent popup
            showPopup(context, getStateRendererType(), getMessage());

            // represent content screen
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryLaterFunction: retryLaterFunction,
              message: getMessage(),
            );
          }
        }
      case ErrorState:
        {
          if (getStateRendererType() == StateRendererType.popupErrorState) {
            // represent popup
            showPopup(context, getStateRendererType(), getMessage());

            // represent content screen
            return contentScreenWidget;
          } else {
            return StateRenderer(
              stateRendererType: getStateRendererType(),
              retryLaterFunction: retryLaterFunction,
              message: getMessage(),
            );
          }
        }
      case ContentState:
        {
          return contentScreenWidget;
        }
      case EmptyState:
        {
          return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryLaterFunction: retryLaterFunction);
        }
      default:
        {
          return contentScreenWidget;
        }
    }
  }

  showPopup(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
          context: context,
          builder: (BuildContext context) => StateRenderer(
            retryLaterFunction: () {},
            stateRendererType: stateRendererType,
            message: message,
          ),
        ));
  }
}
