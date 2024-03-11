import 'package:hive_flutter/hive_flutter.dart';

import '../../feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class ServiceHiveUtils {
  static final ServiceHiveUtils _walletHiveUtils = ServiceHiveUtils._internal();

  factory ServiceHiveUtils() {
    return _walletHiveUtils;
  }

  ServiceHiveUtils._internal();

  static const String _serviceListing = "serviceListing";
  static const String _serviceDetails = "serviceDetails";

  static init() async {
    print("Hive Initialized");
    await Hive.initFlutter();
  }

  static Future<List<CategoryList>> getUtilitiesServices(
      {required String slug}) async {
    try {
      final _utilitiesHive = await Hive.openBox(_serviceListing);
      final _data = _utilitiesHive.get(slug);
      final _items = List.from(_data ?? []);
      await _utilitiesHive.close();
      return _items
          .map((e) => CategoryList.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      return [];
    }
  }

  static Future<void> setUtilitiesServices(
      {required List<CategoryList> item, required String slug}) async {
    final _utilitiesHive = await Hive.openBox(_serviceListing);
    await _utilitiesHive.put(slug, item.map((e) => e.toJson()).toList());
    await _utilitiesHive.close();
  }

  static Future<CategoryList?> getUtilityService({required String slug}) async {
    try {
      final _utilitiesHive = await Hive.openBox(_serviceDetails);
      final _data = _utilitiesHive.get(slug);
      Map<String, dynamic> _item = Map.from(_data ?? {});
      await _utilitiesHive.close();
      return CategoryList.fromJson(_item);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<void> setService(
      {required CategoryList item, required String slug}) async {
    final _utilitiesHive = await Hive.openBox(_serviceDetails);
    await _utilitiesHive.put(slug, item.toJson());
    await _utilitiesHive.close();
  }

  static close() async {
    await Hive.close();
  }
}
