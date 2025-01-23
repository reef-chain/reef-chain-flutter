import polyfill from './polyfill';
import {FlutterJS} from "flutter-js-bridge/src/FlutterJS";
import {reefState, tokenUtil} from "@reef-chain/util-lib";
import {version} from "../../../../js/node_modules/@reef-chain/util-lib/package.json";
import {initFlutterApi} from "./jsApi/initFlutterApi";
import Keyring from "./jsApi/keyring";
import Signer from "./jsApi/signing/signer";
import Firebase from "./jsApi/firebaseApi";
import Stealthex from './jsApi/stealthexApi';
import {interval, map} from "rxjs";

polyfill;
window['flutterJS'] = new FlutterJS(initFlutterApi);
window['reefState'] = reefState;
window['tokenUtil'] = tokenUtil;
window['keyring'] = Keyring;
window['signer'] = Signer;
window['firebase'] = Firebase;
window['stealthex'] = Stealthex;
window['getReefJsVer'] = ()=>({reefAppJs:'0.0.1', utilLib:version});
window['isJsConn'] = ()=>{return true};

window['testObs'] = ()=> interval(1000).pipe(
        map((value) => {
            return {value, msg: 'hey flutter'}
        })
    );
window['futureFn'] = (val: string) => Promise.resolve('From js Promise =' + val);
