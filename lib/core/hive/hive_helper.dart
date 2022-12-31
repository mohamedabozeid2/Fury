import 'package:hive_flutter/adapters.dart';
import 'package:movies_application/core/hive/hive_keys.dart';
import 'package:movies_application/features/fury/domain/entities/account_details.dart';
import 'package:movies_application/features/fury/domain/entities/session_id.dart';

class HiveHelper {
  static late Box<SessionId> sessionId;
  static late Box<AccountDetails> accountDetailsBox;

  static Future<void> init({
    required String path,
  }) async {
    await Hive.initFlutter(path);

    //// Register Adapter

    Hive.registerAdapter(AccountDetailsAdapter());
    Hive.registerAdapter(SessionIdAdapter());

    //// Open Boxes
    sessionId = await Hive.openBox<SessionId>(HiveKeys.sessionId);
    accountDetailsBox =
        await Hive.openBox<AccountDetails>(HiveKeys.accountDetails);
  }

  static Future<void> putInAccountDetails({
    required AccountDetails data,
  }) async {
    return await accountDetailsBox.put(HiveKeys.accountDetails, data);
  }

  static AccountDetails? getAccountDetailsBox() {
    return accountDetailsBox.get(HiveKeys.accountDetails);
  }

  static void deleteAccountDetails() {
    accountDetailsBox.clear();
  }

  static Future<void> putInSessionId({
    required SessionId data,
  }) async {
    return await sessionId.put(HiveKeys.sessionId, data);
  }
  static SessionId? getSessionIdBox(){
    return sessionId.get(HiveKeys.sessionId);
  }
  static void deleteSessionId(){
    sessionId.clear();
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
