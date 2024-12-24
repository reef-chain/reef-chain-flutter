import '../js_api_service.dart';

class AccountApi {
  final JsApiService _jsApi;

  AccountApi(this._jsApi);

  Future<void> setSelectedAddress(String address) =>  _jsApi.jsCallVoidReturn('window.reefState.setSelectedAddress("$address")');

}