import 'package:reef_chain_flutter/reef_state/network/network.dart';
import '../js_api_service.dart';

class NetworkApi {
  final JsApiService _jsApi;

  NetworkApi(this._jsApi);

  Future<void> setNetwork(Network network) async {
    final networkName = network.name;
    if (networkName != null && networkName.isNotEmpty) {
      await _jsApi.jsCallVoidReturn('window.utils.setSelectedNetwork("$networkName")');
    } else {
      throw ArgumentError('Network name cannot be null or empty.');
    }
  }

  Stream<dynamic> selectedNetwork() {
    return _jsApi.jsObservable('window.reefState.selectedNetwork\$');
  }

}
