import 'package:flutter/material.dart';
import 'package:tut_app/application/di.dart';
import 'package:tut_app/presentation/common/state_renderer/state_rendrer_impl.dart';
import 'package:tut_app/presentation/main/home/view_model/home_view_model.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';
import 'package:tut_app/presentation/resources/values_maneger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () {
                _viewModel.start();
              }) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSections(title: StringManager.services),
        _getServices(),
        _getSections(title: StringManager.stores),
        _getStores(),
      ],
    );
  }

  Widget _getBannersCarousel() {
    return const Center();
  }

  Widget _getSections({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppPadding.p2,
        right: AppPadding.p12,
        left: AppPadding.p12,
        top: AppPadding.p12,
      ),
      child: Text(title),
    );
  }

  Widget _getServices() {
    return const Center();
  }

  Widget _getStores() {
    return const Center();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
