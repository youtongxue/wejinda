import 'package:wejinda/business/user/repository/dao/account_dao.dart';
import 'package:wejinda/enumm/storage_key_enum.dart';

abstract class AccountDataService {
  // 存储账号
  void saveAccount(AccountStorageKeyEnum accountStorageKeyEnum, String username,
      String password);

  // 读取账号
  AccountDAO getAccount(AccountStorageKeyEnum accountStorageKeyEnum);

  // 删除账号
  void delAccount(
    AccountStorageKeyEnum accountStorageKeyEnum,
  );
}
