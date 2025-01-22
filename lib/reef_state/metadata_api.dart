
import 'package:reef_chain_flutter/js_api_service.dart';
import 'package:reef_chain_flutter/reef_state/token/token_with_amount.dart';

class MetadataApi {
  final JsApiService _jsApi;

  MetadataApi(this._jsApi);

  Future<dynamic> getMetadata() =>
      _jsApi.jsPromise('window.metadata.getMetadata();');

  Future<dynamic> getJsVersions() => _jsApi.jsCall('window.getReefJsVer();');

  Future<dynamic> isJsConn() => _jsApi.jsCall('window.isJsConn();');

}
