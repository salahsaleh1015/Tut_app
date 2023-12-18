import 'package:flutter/material.dart';
import 'package:tut_app/application/di.dart';
import 'package:tut_app/presentation/main/home/view_model/home_view_model.dart';
import 'package:tut_app/presentation/resources/string_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


 final HomeViewModel _viewModel = instance<HomeViewModel>();

 _bind(){
   _viewModel.start();
 }

 @override
  void initState() {
   _bind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(StringManager.home),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
