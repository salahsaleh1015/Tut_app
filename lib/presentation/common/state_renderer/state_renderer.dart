import 'package:flutter/material.dart';

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

 Widget _getStateWidget(){
    switch(stateRendererType){
      case StateRendererType.popupLoadingState :
        break;
      case StateRendererType.popupErrorState :
        break;
      case StateRendererType.fullScreenLoadingState :
        break;
      case StateRendererType.fullScreenErrorState :
        break;
      case StateRendererType.fullScreenEmptyState :
        break;
      case StateRendererType.contentState :
        break;
    }
 }

Widget  _getItemColumn(List<Widget> children){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );

  }
}
