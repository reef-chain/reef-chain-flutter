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
}