import 'dart:convert';

import 'package:reef_chain_flutter/reef_state/token/token_with_amount.dart';
import 'package:rxdart/rxdart.dart';

import '../js_api_service.dart';

class SigningApi {
  
  final JsApiService _jsApi;

  SigningApi(this._jsApi);

  Future<dynamic> signRaw(String address, String message) =>
      _jsApi.jsPromise('window.signApi.signRawPromise(`$address`, `$message`);');

  Stream get jsTxSignatureConfirmationMessageSubj=> _jsApi.jsTxSignatureConfirmationMessageSubj;

  void confirmTxSignature(String reqId, String? mnemonic) {
    _jsApi.confirmTxSignature(reqId, mnemonic);
  }

  void rejectTxSignature(String signatureIdent) {
    _jsApi.rejectTxSignature(signatureIdent);
  }


  Future<dynamic> signPayload(String address, Map<String, dynamic> payload) =>
      _jsApi.jsPromise(
          'window.signApi.signPayloadPromise(`$address`, ${jsonEncode(payload)})');

  Future<dynamic> decodeMethod(String data, {dynamic types})=>types==null?_jsApi.jsPromise('window.utils.decodeMethod(`$data`)') : _jsApi.jsPromise('window.utils.decodeMethod(`$data`, ${jsonEncode(types)})');

  Future<dynamic> bytesString(String bytes) =>
      _jsApi.jsPromise('window.utils.bytesString("$bytes")');

  Future<dynamic> sendNFT(String unresolvedFrom, String nftContractAddress,
      String from, String to, int nftAmount, int nftId) async {
    return _jsApi.jsObservable(
        'window.transfer.sendNft("${unresolvedFrom}","${from}","${to}",${nftAmount},${nftId},"${nftContractAddress}")');
  }
}