
import 'package:reef_chain_flutter/js_api_service.dart';
import 'package:reef_chain_flutter/reef_state/token/token_with_amount.dart';

class TransferApi {
  final JsApiService _jsApi;

  TransferApi(this._jsApi);

  Stream<dynamic> transferTokensStream(
      String fromAddress, String toAddress, dynamic token) {
    return _jsApi.jsObservable(
        'window.transfer.sendObs("$fromAddress", "$toAddress", "${token.amount.toString()}", ${token.decimals}, "${token.address}")');
  }

  Future<dynamic> transferTokens(
      String fromAddress, String toAddress, dynamic token) async {
    return _jsApi.jsPromise(
        'window.transfer.sendPromise("$fromAddress", "$toAddress", "${token.amount.toString()}", ${token.decimals}, "${token.address}")');
  }

}
