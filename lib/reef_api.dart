import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:reef_chain_flutter/network/network.dart';
import 'package:reef_chain_flutter/reef_state/account/account.dart';
import 'package:reef_chain_flutter/reef_state/account_api.dart';
import 'package:reef_chain_flutter/reef_state/firebase_api.dart';
import 'package:reef_chain_flutter/reef_state/metadata_api.dart';
import 'package:reef_chain_flutter/reef_state/network_api.dart';
import 'package:reef_chain_flutter/reef_state/pools_api.dart';
import 'package:reef_chain_flutter/reef_state/signing_api.dart';
import 'package:reef_chain_flutter/reef_state/stealthex_api.dart';
import 'package:reef_chain_flutter/reef_state/swap_api.dart';
import 'package:reef_chain_flutter/reef_state/transfer_api.dart';

import '../reef_state/tokens_api.dart';

import 'js_api_service.dart';
import 'network/ws-conn-state.dart';

class ReefChainApi {
  late JsApiService _jsApi;
  late ReefStateApi _reefStateApi;
  final ready = Completer<void>();


  ReefChainApi() {
    _jsApi = JsApiService.reefAppJsApi();
    _jsApi.jsApiReady.future.then((_)=>this.ready.complete());
    if (_jsApi.jsApiReady.isCompleted) {
      this.ready.complete();
    }
    _reefStateApi = ReefStateApi(_jsApi);
    _initReefObservables(_jsApi);
  }

  ReefStateApi get reefState {
    return _reefStateApi;
  }

  Stream<bool?> getIndexerConnected()=> _jsApi.jsObservable('window.utils.indexerConnState\$').map((event)=>event==true);

  Stream<WsConnState?> getProviderConnLogs()=> _jsApi.jsObservable('window.utils.providerConnState\$').map((event) => WsConnState.fromJson(event));

  Future<void> reconnectProvider() async {
    _jsApi.jsCallVoidReturn('window.utils.reconnectProvider()');
  }

  _initReefObservables(JsApiService reefAppJsApiService) async {
    reefAppJsApiService.jsMessageUnknownSubj.listen((JsApiMessage value) {
      print('REEF jsMSG not handled id=${value.streamId}');
    });
  }
}

class ReefStateApi {
  final JsApiService jsApi;
  bool _inited = false;
  late final TokensApi tokenApi;
  late final AccountApi accountApi;
  late final NetworkApi networkApi;
  late final StealthexApi stealthexApi;
  late final PoolsApi poolsApi;
  late final TransferApi transferApi;
  late final SwapApi swapApi;
  late final SigningApi signingApi;
  late final FirebaseApi firebaseApi;
  late final MetadataApi metadataApi;

  ReefStateApi(this.jsApi) {
    tokenApi = TokensApi(jsApi);
    accountApi = AccountApi(jsApi);
    networkApi = NetworkApi(jsApi);
    stealthexApi = StealthexApi(jsApi);
    poolsApi = PoolsApi(jsApi);
    transferApi = TransferApi(jsApi);
    signingApi = SigningApi(jsApi);
    swapApi = SwapApi(jsApi);
    firebaseApi = FirebaseApi(jsApi);
    metadataApi = MetadataApi(jsApi);
  }

  init(ReefNetowrk network, List<ReefAccount> accounts) async {
    if (_inited == true) {
      return;
    }
    _inited = true;
    await jsApi.jsPromise(
        'window.jsApi.initReefState("${network}", ${jsonEncode(
            accounts)})');
  }
}
