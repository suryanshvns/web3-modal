import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:web3_modal_integration/apis/graphql_mutation_api.dart';
import 'package:web3_modal_integration/apis/graphql_reponse.dart';
import 'package:web3_modal_integration/apis/graphql_request.dart';
import 'package:web3_modal_integration/graphql_queries_api.dart';
import 'package:web3_modal_integration/shared_preference/shared_preference_db.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late W3MService _w3mService;

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  void _onPersonalSign() async {
    try {
      await _w3mService.launchConnectedWallet();
      var hash = await _w3mService.web3App?.request(
        topic: _w3mService.session!.topic ?? "",
        chainId: 'eip155:1',
        request: SessionRequestParams(
          method: 'personal_sign',
          params: ['GM from W3M flutter!!', _w3mService.session!.address],
        ),
      );

      // After successfully signing, retrieve challenge ids
      await _getChallengeIds();

      // After retrieving challenge ids, generate access token
      await _generateAccessToken();
    } catch (e) {
      print("Error: $e");
    }
  }

  void _initializeService() async {
    _w3mService = W3MService(
      projectId: "28f8679078313fbf8bd20452df74df4e",
      logLevel: LogLevel.error,
      metadata: const PairingMetadata(
        name: "W3M Flutter",
        description: "W3M Flutter test app",
        url: 'https://www.walletconnect.com/',
        icons: ['https://web3modal.com/images/rpc-illustration.png'],
        redirect: Redirect(
          native: 'w3m://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await _w3mService.init();
  }

  Future<void> _getChallengeIds() async {
    try {
      GraphQlResponse getLensData =
          await GraphqlRequest.get(GraphqlQueriesApi.getLensId, {
        "request": {
          "where": {"ownedBy": PrefsDb.getWalletId}
        }
      });

      if (getLensData.isSuccess &&
          getLensData.data['profiles']['items'].isNotEmpty) {
        PrefsDb.saveProfileId(getLensData.data['profiles']['items'][0]['id']);
      }

      GraphQlResponse challengeResponse =
          await GraphqlRequest.get(GraphqlQueriesApi.getChallengeId, {
        "request": {
          "for": PrefsDb.getProfileId,
          "signedBy": PrefsDb.getWalletId
        }
      });

      if (challengeResponse.isSuccess) {
        var id = challengeResponse.data['challenge']['id'];
        var msg = challengeResponse.data['challenge']['text'];
        PrefsDb.saveSignedMsg(msg);
        PrefsDb.saveSignedId(id);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _generateAccessToken() async {
    try {
      // log(PrefsDb.getSignatureId!);
      GraphQlResponse accessTokenRes =
          await GraphqlRequest.save(GraphqlMutationsApi.getAccessToken, {
        "request": {
          "id": PrefsDb.getSignedId,
          "signature": PrefsDb.getSignatureId!
              .substring(1, PrefsDb.getSignatureId!.length - 1)
        }
      });

      if (accessTokenRes.isSuccess) {
        var accessToken = accessTokenRes.data['authenticate']['accessToken'];
        PrefsDb.saveToken(accessToken);
      } else {
        // Get.offAll(() => MyHomePage());
      }
    } catch (e) {
      // Get.offAll(() => MyHomePage());
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        W3MConnectWalletButton(service: _w3mService),
        W3MNetworkSelectButton(service: _w3mService),
        W3MAccountButton(service: _w3mService),
        ElevatedButton(
            onPressed: _onPersonalSign, child: const Text("Personal Sign"))
      ],
    );
  }
}

// Your PrefsDb class implementation

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Web3Modal Example')),
      body: HomePage(),
    ),
  ));
}
