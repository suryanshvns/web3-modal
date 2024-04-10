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

class SignedDetails {
  String id;
  String msg;

  SignedDetails({required this.id, required this.msg});
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late W3MService _w3mService;
  String accessToken = 'N/A';
  String refreshToken = 'N/A';

  @override
  void initState() {
    super.initState();
    _initializeService();
  }

  void _onPersonalSign() async {
    try {
      var walletId = _w3mService.session!.address;
      PrefsDb.saveWalletId(walletId);

      var challangeData = await generateChallenge(walletId);

      await _w3mService.launchConnectedWallet();
      var hash = await _w3mService.web3App?.request(
        topic: _w3mService.session!.topic ?? "",
        chainId: 'eip155:1',
        request: SessionRequestParams(
          method: 'personal_sign',
          params: [challangeData.msg, _w3mService.session!.address],
        ),
      );
      PrefsDb.saveSignatureId(hash);
      // After successfully signing, retrieve challenge ids

      // After retrieving challenge ids, generate access token
      await _generateAccessToken(hash, challangeData);
    } catch (e) {
      print("Error: $e");
    }
  }

  void _initializeService() async {
    _w3mService = W3MService(
      projectId: "78e820bd1788f5fe3e557a83a68f8c35",
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

  Future generateChallenge(walletId) async {
    try {
      GraphQlResponse getLensData =
          await GraphqlRequest.get(GraphqlQueriesApi.getLensId, {
        "request": {
          "where": {"ownedBy": walletId ?? PrefsDb.getWalletId!}
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
        return SignedDetails(id: id, msg: msg);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future _generateAccessToken(hash, challangeData) async {
    try {
      // log(PrefsDb.getSignatureId!);
      GraphQlResponse accessTokenRes =
          await GraphqlRequest.save(GraphqlMutationsApi.getAccessToken, {
        "request": {"id": challangeData.id, "signature": hash}
      });

      if (accessTokenRes.isSuccess) {
        var jwtToken = accessTokenRes.data['authenticate']['accessToken'];
        var jwtRefreshToken =
            accessTokenRes.data['authenticate']['refreshToken'];
        PrefsDb.saveToken(jwtToken);
        setState(() {
          accessToken = jwtToken;
          refreshToken = jwtRefreshToken; // Increment the counter by 1
        });
        return jwtToken;
      }
      return '';
    } catch (e) {
      // Get.offAll(() => MyHomePage());
      print(e.toString());
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var addressString =
        _w3mService.session?.address.toString() ?? 'Default Address';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(addressString),
        W3MConnectWalletButton(service: _w3mService),
        W3MNetworkSelectButton(service: _w3mService),
        W3MAccountButton(service: _w3mService),
        ElevatedButton(
            onPressed: _onPersonalSign, child: const Text("Personal Sign")),
        Text("JWT token:-    $accessToken"),
        Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 8.16))),
        ),
        Text("JWT RefreshToken:-  $refreshToken"),
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
