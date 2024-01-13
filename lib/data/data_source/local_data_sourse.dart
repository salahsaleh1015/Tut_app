import 'package:tut_app/data/responses/response/responses.dart';

const cacheHomeKey = "Cache_Home_Key";

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

  Future<void> saveHomeToCache(HomeResponse homeResponse);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CachedItem(homeResponse);
  }

  @override
  Future<HomeResponse> getHomeData() {
    // TODO: implement getHomeData
    throw UnimplementedError();
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}
