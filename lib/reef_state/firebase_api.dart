
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:reef_chain_flutter/js_api_service.dart';
import 'package:reef_chain_flutter/reef_state/token/token_with_amount.dart';

class FirebaseApi {
  final JsApiService _jsApi;

  FirebaseApi(this._jsApi);

  Future<dynamic> logAnalytics(String eventName,dynamic _config) async {
    try {
      await _jsApi.jsCallVoidReturn(
        'window.firebase.logFirebaseAnalytic(${jsonEncode(_config)},"$eventName")');
    } catch (e) {
      debugPrint("unable to log to firebase");
    }
  }

}
