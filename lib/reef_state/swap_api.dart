import 'dart:convert';

import 'package:reef_chain_flutter/reef_state/token/token_with_amount.dart';

import '../js_api_service.dart';

class SwapApi {
  final JsApiService _jsApi;

  SwapApi(this._jsApi);

  Future<dynamic> swapTokens(String signerAddress,dynamic mappedToken1,dynamic mappedToken2,dynamic settings)async{
    return _jsApi.jsObservable(
        'window.swap.execute("$signerAddress", ${jsonEncode(mappedToken1)}, ${jsonEncode(mappedToken2)}, ${jsonEncode(settings.toJson())})');
  }

  Future<dynamic> getPoolReserves(
      String token1Address, String token2Address) async {
    return _jsApi
        .jsPromise('window.swap.getPoolReserves("$token1Address", "$token2Address")');
  }

  dynamic getSwapAmount(String tokenAmount, bool buy,
      dynamic token1Reserve, dynamic token2Reserve) {
    return _jsApi.jsCall(
        'window.swap.getSwapAmount($tokenAmount, $buy, ${jsonEncode(token1Reserve.toJsonSkinny())}, ${jsonEncode(token2Reserve.toJsonSkinny())})');
  }
  
}