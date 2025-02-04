
import 'dart:typed_data';

import 'package:app/web3dart/credentials.dart';
import 'package:app/web3dart/crypto.dart';
import 'package:app/web3dart/web3dart.dart';

import '../utils/user_op.dart';

class TransactionInfo {
  String? from;
  String? to;
  String? data;
  TransactionInfo([this.from, this.to, this.data]);
}

const zero = '0x0000000000000000000000000000000000000000';

class UserOperation {
  EthereumAddress sender = EthereumAddress.fromHex(zero);
  BigInt nonce = BigInt.from(0);
  Uint8List initCode = Uint8List(0);
  Uint8List callData = Uint8List(0);
  BigInt callGas = BigInt.from(0);
  BigInt verificationGas = BigInt.from(0);
  BigInt preVerificationGas = BigInt.from(21000);
  BigInt maxFeePerGas = BigInt.from(0);
  BigInt maxPriorityFeePerGas = BigInt.from(0);
  EthereumAddress paymaster = EthereumAddress.fromHex(zero);
  Uint8List paymasterData = Uint8List(0);
  Uint8List signature = Uint8List(0);

  UserOperation clone() {
    UserOperation clone = UserOperation();
    clone.sender = sender;
    clone.nonce = nonce;
    clone.initCode = initCode;
    clone.callData = callData;
    clone.callGas = callGas;
    clone.verificationGas = verificationGas;
    clone.preVerificationGas = preVerificationGas;
    clone.maxFeePerGas = maxFeePerGas;
    clone.maxPriorityFeePerGas = maxPriorityFeePerGas;
    clone.paymaster = paymaster;
    clone.paymasterData = paymasterData;
    clone.signature = signature;
    return clone;
  }

  List<dynamic> toTuple() {
    return [sender,nonce,initCode,callData,callGas,
      verificationGas,preVerificationGas,maxFeePerGas,maxPriorityFeePerGas,
      paymaster,paymasterData,signature];
  }

  @override
  String toString() {
    return '''{
    sender: $sender,
    nonce: $nonce,
    iniCode: ${bytesToHex(initCode, include0x: true)},
    callData: ${bytesToHex(callData, include0x: true)},
    verificationGas: $verificationGas,
    preVerificationGas: $preVerificationGas,
    maxFeePerGas: $maxFeePerGas,
    maxPriorityFeePerGas: $maxPriorityFeePerGas,
    paymaster: $paymaster,
    paymasterData: ${bytesToHex(paymasterData, include0x: true)},
    signature: ${bytesToHex(signature, include0x: true)}
    }''';
  }

  Future<bool> estimateGas(Web3Client web3, EthereumAddress entryPointAddress) async {
    try {
      verificationGas = BigInt.from(150000);
      if (initCode.isNotEmpty) {
        verificationGas += BigInt.from(3200 + 200 * initCode.length);
      }
      callGas = await web3.estimateGas(sender: entryPointAddress, to: sender, data: callData);
      print('estimateGas: $callGas');
      return true;
    } catch (e) {
      return false;
    }
  }

  Uint8List requestId(EthereumAddress entryPointAddress, BigInt chainId) {
    return getRequestId(this, entryPointAddress, chainId);
  }

  void signWithSignature(EthereumAddress signAddress, Uint8List signature) {
    this.signature = signUserOpWithPersonalSign(signAddress, signature);
  }
}