import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tut_app/application/di.dart';
import 'package:tut_app/domain/entities/entities.dart';
import 'package:tut_app/presentation/common/state_renderer/state_rendrer_impl.dart';
import 'package:tut_app/presentation/main/home/view_model/home_view_model.dart';
import 'package:tut_app/presentation/resources/color_maneger.dart';
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
    return StreamBuilder<HomeViewObject>(
      stream: _viewModel.outputHomeData,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getBannerWidget(snapshot.data?.banners),
            _getSections(title: StringManager.services),
            _getServicesWidget(snapshot.data?.services),
            _getSections(title: StringManager.stores),
            _getStoresWidget(snapshot.data?.stores),
          ],
        );
      },
    );
  }

  Widget _getBannerWidget(List<BannerAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
        items: banners
            .map((banners) => SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: AppSize.s1_5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppPadding.p12),
                      side: BorderSide(color: ColorManager.primary),
                    ),
                    child: ClipRRect(
                      child: Image.network(banners.image, fit: BoxFit.cover),
                    ),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
            height: AppSize.s190,
            autoPlay: true,
            enlargeCenterPage: true,
            enableInfiniteScroll: true),
      );
    } else {
      return Container();
    }
  }

  Widget _getSections({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppPadding.p2,
        right: AppPadding.p12,
        left: AppPadding.p12,
        top: AppPadding.p12,
      ),
      child: Text(title, style: Theme.of(context).textTheme.labelSmall),
    );
  }

  Widget _getServicesWidget(List<Service>? service) {
    if (service != null) {
      return SizedBox(
        height: AppSize.s170,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p8, horizontal: AppPadding.p8),
          children: service
              .map((service) => Card(
                    elevation: AppSize.s4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        side: BorderSide(
                            color: ColorManager.primary, width: AppSize.s1)),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          child: Image.network(
                            service.image,
                            fit: BoxFit.cover,
                            width: AppSize.s120,
                            height: AppSize.s120,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: AppPadding.p8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                service.title,
                                style: Theme.of(context).textTheme.caption,
                                textAlign: TextAlign.center,
                              ),
                            ))
                      ],
                    ),
                  ))
              .toList(),
        ),
      );
    } else {
      return Container();
    }
  }

  // Widget _getStoresWidget(List<Store>? stores) {
  //   return Padding(
  //     padding: const EdgeInsets.only(
  //         top: AppPadding.p12, left: AppPadding.p12, right: AppPadding.p12),
  //     child: Flex(
  //       direction: Axis.vertical,
  //       children: [
  //         GridView.count(
  //           crossAxisCount: AppSize.s2,
  //           crossAxisSpacing: AppSize.s8,
  //           mainAxisSpacing: AppSize.s8,
  //           physics: const ScrollPhysics(),
  //           shrinkWrap: true,
  //           children: List.generate(stores!.length, (index) {
  //             return Card(
  //               elevation: AppSize.s4,
  //               child: Image.network(stores[index].image, fit: BoxFit.cover),
  //             );
  //           }),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _getStoresWidget(List<Store>? stores) {
    if (stores != null) {
      return Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: AppSize.s2,
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(stores.length, (index) {
                return InkWell(
                  onTap: () {
                    // navigate to store details screen
                    //Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                  },
                  child: Card(
                    elevation: AppSize.s4,
                    child: Image.network(
                      stores[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
