import 'package:tut_app/data/network/failure/error_handler.dart';
import 'package:tut_app/data/responses/response/responses.dart';

const cacheHomeKey = "Cache_Home_Key";
const cacheHomeInterval = 60 * 1000;

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
    CachedItem? cachedItem = cacheMap[cacheHomeKey];

    if (cachedItem != null && cachedItem.isValid(cacheHomeInterval)) {
      return cachedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    int currentTimeInMilis = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTimeInMilis - cacheTime <= expirationTime;

    return isValid;
  }
}
