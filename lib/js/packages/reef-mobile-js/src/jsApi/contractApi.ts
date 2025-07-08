import { getAccountSigner, ReefAccount, reefState } from '@reef-chain/util-lib';
import { map, switchMap, take, catchError } from "rxjs/operators";
import { firstValueFrom, combineLatest } from "rxjs";
import { stringToHex } from "@polkadot/util";
import type { SignerPayloadJSON } from "@polkadot/types/types";
import type { HexString } from '@polkadot/util/types';
import Signer from "reef-mobile-js/src/jsApi/background/Signer";
import { findAccount } from './signApi';
import { ethers } from 'ethers';

export const initApi = (signingKey: Signer) => {
    (window as any).contractApi = {
        execute: async (signerAddress: string, contractAddress: string, abi: any, methodName: string,args: any[] = []) => {
            try {
                const [accounts, provider] = await firstValueFrom(
                    combineLatest([reefState.accounts$, reefState.selectedProvider$]).pipe(take(1))
                );

                const signer: ReefAccount | undefined = findAccount(accounts, signerAddress);

                if (!signer) {
                    throw new Error('Signer not found addr=' + signerAddress);
                }

                const evmSigner = await getAccountSigner(signer.address, provider, signingKey);
                
                const contract = new ethers.Contract(contractAddress,abi,evmSigner);

                const result = await contract[methodName]([...args]);

                return result.toString();
            } catch (e) {
                return { error: e.message };
            }
        },
    }
}
