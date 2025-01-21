import 'package:reef_chain_flutter/reef_state/network/network.dart';
import '../js_api_service.dart';

class NetworkApi {
  final JsApiService _jsApi;

  NetworkApi(this._jsApi);

  Future<void> setNetwork(String network) async {
      await _jsApi.jsCallVoidReturn('window.utils.setSelectedNetwork("$network")');
  }

  Stream get selectedNetwork$ =>_jsApi
        .jsObservable('window.reefState.selectedNetwork\$');

}
