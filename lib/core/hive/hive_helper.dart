import 'package:hive_flutter/adapters.dart';
import 'package:movies_application/core/hive/hive_keys.dart';
import 'package:movies_application/features/fury/domain/entities/account_details.dart';

class HiveHelper {
  static late Box<String> userId;
  static late Box<AccountDetails> accountDetailsBox;

  static Future<void> init({
    required String path,
  }) async {
    await Hive.initFlutter(path);

    //// Register Adapter

    //// Open Boxes
    userId = await Hive.openBox<String>(HiveKeys.userId);
    accountDetailsBox =
        await Hive.openBox<AccountDetails>(HiveKeys.accountDetails);
  }

  static Future<void> putInAccountDetails({
    required AccountDetails data,
  }) async{
    return await accountDetailsBox.put(HiveKeys.accountDetails, data);
  }


  static Future<void> putInBox({
    required Box box,
    required String key,
    required dynamic data,
  }) async {
    return await box.put(key, data);
  }

  static dynamic getBoxData({
    required Box box,
    required String key,
  }) {
    return box.get(key, defaultValue: '');
  }

  static void removeData({
    required Box box,
    required String key,
  }) {
    box.put(key, '');
  }
}
