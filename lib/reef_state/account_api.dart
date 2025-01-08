import 'dart:async';
import 'dart:convert';

import '../js_api_service.dart';

class AccountApi {
  final JsApiService _jsApi;

  AccountApi(this._jsApi){
    _initWasm(_jsApi);
  }

  Future<void> setSelectedAddress(String address) =>  _jsApi.jsCallVoidReturn('window.reefState.setSelectedAddress("$address")');

  Future<String> generateAccount() async {
    return await _jsApi.jsPromise('window.keyring.generate()');
  }

    Future<dynamic> restoreJson(
      Map<String, dynamic> file, String password) async {
    return await _jsApi.jsPromise(
        'window.keyring.restoreJson(${jsonEncode(file)},"$password")');
  }

Future<String> formatBalance(
      String value, double price) async {
        try {   
    return await _jsApi.jsPromise(
        'window.keyring.formatBalance("$value",$price)');
        } catch (e) {
          print('window.keyring.formatBalance ERR=$e');
          return "";
        }
  }

  Future<dynamic> listenBindActivity(String address) async {
  StreamController<dynamic> controller = StreamController<dynamic>();

  StreamSubscription<dynamic> subscription;
  subscription = _jsApi.jsObservable('window.account.listenBindActivity("$address")')
    .listen((event) {
      controller.add(event);
      controller.close();
    });

  return controller.stream.first;
}


  Future<dynamic> exportAccountQr(String address, String password) async {
    return await _jsApi
        .jsPromise('window.keyring.exportAccountQr("$address","$password")');
  }

    Future<dynamic> changeAccountPassword(
      String address, String newPass, String oldPass) async {
    return await _jsApi.jsPromise(
        'window.keyring.changeAccountPassword("$address","$newPass","$oldPass")');
  }

    Future<dynamic> accountsCreateSuri(String mnemonic, String password) async {
    return await _jsApi.jsPromise(
        'window.keyring.accountsCreateSuri("$mnemonic","$password")');
  }

  Future<bool> checkMnemonicValid(String mnemonic) async {
    var isValid = await _jsApi
        .jsPromise('window.keyring.checkMnemonicValid("$mnemonic")');
    return isValid == 'true';
  }

   Future<dynamic> resolveEvmAddress(String nativeAddress) async {
    return await _jsApi
        .jsPromise('window.account.resolveEvmAddress("$nativeAddress")');
  }

  Future<String> accountFromMnemonic(String mnemonic) async {
    return await _jsApi
        .jsPromise('window.keyring.accountFromMnemonic("$mnemonic")');
  }


  Future<dynamic> bindEvmAccount(String address) async {
    return _jsApi.jsPromise('window.account.claimEvmAccount("$address")');
  }

  Future<bool> isValidEvmAddress(String address) async {
    return await _jsApi
            .jsCall<bool>('window.account.isValidEvmAddress("$address")');
  }

  Future<bool> isValidSubstrateAddress(String address) async {
    return await _jsApi.jsCall<bool>(
            'window.account.isValidSubstrateAddress("$address")');
  }

  Future<String?> resolveToNativeAddress(String evmAddress) async {
    return await _jsApi
        .jsPromise('window.account.resolveFromEvmAddress("$evmAddress")');
  }

  Future<String> sanitizeEvmAddress(String evmAddress) async{
    return await _jsApi.jsPromise('window.utils.sanitizeInput("$evmAddress")');
  }

  Future<bool> isEvmAddressExist(String address) async {
    var res = await this.resolveToNativeAddress(address);
    return res != null;
  }

  void _initWasm(JsApiService _jsApi) async {
    await _jsApi.jsPromise('window.keyring.initWasm()');
  }


  Future<dynamic> toReefEVMAddressWithNotificationString(String evmAddress) async {
    return await _jsApi.jsCall(
        'window.account.toReefEVMAddressWithNotification("$evmAddress")');
  }

  toReefEVMAddressNoNotificationString(String evmAddress) async {
    return await _jsApi
        .jsCall('window.account.toReefEVMAddressNoNotification("$evmAddress")');
  }

}