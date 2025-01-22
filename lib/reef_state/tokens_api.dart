import '../js_api_service.dart';
import 'status_data_object.dart';
import 'token/token_with_amount.dart';
import 'package:flutter/foundation.dart';

class TokensApi {
  JsApiService _jsApi;

  TokensApi(JsApiService this._jsApi);

  Stream<StatusDataObject<List<StatusDataObject<TokenWithAmount>>>> get tokens {
    return _jsApi
        .jsObservable('window.reefState.selectedTokenPrices_status\$')
        .map((tokens) {
      ParseListFn<StatusDataObject<TokenWithAmount>> parsableListFn =
      getParsableListFn(TokenWithAmount.fromJson);
      var tokensListFdm = StatusDataObject.fromJsonList(tokens, parsableListFn);

      if (kDebugMode) {
        try {
          print('GOT TOKENS ${tokensListFdm.data.length}');
        } catch (e) {
          print('Error getting tokens');
        }
      }
      return tokensListFdm;
    });

  }

   Future<dynamic> getNftInfo(String nftId, String ownerAddress) async {
      return _jsApi.jsPromise('window.utils.getNftInfo("$nftId","$ownerAddress")');
    }

   Future<dynamic> reloadTokens() async {
     return _jsApi.jsCallVoidReturn('window.reefState.reloadTokens()');
    }

  Future<dynamic> findToken(String address) async {
    return _jsApi.jsPromise('window.utils.findToken("$address")');
  }

  Future<dynamic> getTxInfo(String timestamp) async {
    return _jsApi.jsPromise('window.utils.getTxInfo("$timestamp")');
  }

  Future<dynamic> getPools(dynamic offset) async {
    return _jsApi.jsPromise('window.utils.getPools(10,${offset},"","")');
  }

  Future<dynamic> getPoolPairs(String tokenAddress) async {
    return _jsApi.jsPromise('window.utils.getPoolPairs("${tokenAddress}")');
  }
  Future<dynamic> getTokenInfo(String tokenAddress) async {
    return _jsApi.jsPromise('window.utils.getTokenInfo("${tokenAddress}")');
  }

  Stream get selectedTransactionHistory$=> _jsApi
        .jsObservable('window.reefState.selectedTransactionHistory_status\$');

  Stream get reefPrice$=> _jsApi.jsObservable('window.tokenUtil.reefPrice\$');

  Stream get selectedNFTs_status$=> _jsApi
        .jsObservable('window.reefState.selectedNFTs_status\$');
  
  Stream get selectedTokenPrices_status$=> _jsApi
        .jsObservable('window.reefState.selectedTokenPrices_status\$');
  
}