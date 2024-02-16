import 'package:tut_app/data/network/failure/error_handler.dart';
import 'package:tut_app/data/responses/response/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000; // 1 minute cache in millis
const CACHE_HOME_DETAILS_KEY = "CACHE_Home_DETAILS_KEY";
const CACHE_HOME_DETAILS_INTERVAL = 30 * 1000; // 30s in millis

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<HomeDetailsResponse> getHomeDetailsData();

  Future<void> saveHomeToCache(HomeResponse homeResponse);
  Future<void> saveHomeDetailsToCache(HomeDetailsResponse homeDetailsResponse);

  void clearCache();

  void removeFromCache(String key);


}

class LocalDataSourceImpl implements LocalDataSource {
  // run time cache
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_INTERVAL)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }


  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }

  @override
  Future<HomeDetailsResponse> getHomeDetailsData() async {
    CachedItem? cachedItem = cacheMap[CACHE_HOME_DETAILS_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_HOME_DETAILS_INTERVAL)) {
      // return the response from cache
      return cachedItem.data;
    } else {
      // return an error that cache is not there or its not valid
      throw ErrorHandler.handle(DataSource.cacheError);
    }
  }

  @override
  Future<void> saveHomeDetailsToCache(HomeDetailsResponse homeDetailsResponse) async {
    cacheMap[CACHE_HOME_DETAILS_KEY] = CachedItem(homeDetailsResponse);
  }
}

class CachedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;

    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    // expirationTimeInMillis -> 60 sec
    // currentTimeInMillis -> 1:00:00
    // cacheTime -> 12:59:30
    // valid -> till 1:00:30
    return isValid;
  }
}