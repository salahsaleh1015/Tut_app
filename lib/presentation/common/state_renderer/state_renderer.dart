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
    return const Placeholder();
  }
}
