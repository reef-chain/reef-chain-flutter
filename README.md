## Features

Exposed Dart Classes for easy flutter integration with Reef chain

## Getting started

Add dependency to pubscpek.yaml, copy lib/js/packages/reef-mobile-js/dist/index.js to your app under same path and add this .js file to assets in pubspeck.yaml

## Usage

```dart

import 'package:reef_chain_flutter/reef_chain_flutter.dart';

final JsApiService reefJsApiService = JsApiService.reefAppJsApi(onErrorCb: (){
  debugPrint('JS CONNECTION ERROR');
});

widget.reefJsApiService.jsCall("window.isJsConn()").then((v)=>debugPrint(v.toString()));
widget.reefJsApiService.jsPromise("window.futureFn(\"fltrrr\")").then((v)=>debugPrint(v.toString()));
widget.reefJsApiService.jsObservable("window.testObs()").listen((v)=>debugPrint(v.toString()));
```