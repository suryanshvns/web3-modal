// import 'package:flutter/material.dart';
// import 'package:web3modal_flutter/web3modal_flutter.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late W3MService _w3mService;
//   @override
//   void initState() {
//     super.initState();
//     initializedState();
//   }

//   void initializedState() async {
//     W3MChainPresets.chains.putIfAbsent(_chainId, () => _sepoliaChain);
//     _w3mService = W3MService(
//       projectId: '28f8679078313fbf8bd20452df74df4e',
//       metadata: const PairingMetadata(
//         name: 'Web3Modal Flutter Example',
//         description: 'Web3Modal Flutter Example',
//         url: 'https://www.walletconnect.com/',
//         icons: ['https://walletconnect.com/walletconnect-logo.png'],
//         redirect: Redirect(
//           native: 'flutterdapp://',
//           universal: 'https://www.walletconnect.com',
//         ),
//       ),
//     );
//     await _w3mService.init();
//   }

//   void _onPersonalSign() async {
//     await _w3mService.launchConnectedWallet();
//     await _w3mService.request(
//       topic: _w3mService.session?.topic ?? '',
//       chainId: 'eip155:$_chainId', // Connected chain id
//       request: SessionRequestParams(
//         method: 'personal_sign',
//         params: ['Sign in', _w3mService.session!.address!],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         W3MConnectWalletButton(service: _w3mService),
//         const SizedBox(
//           height: 16,
//         ),
//         W3MNetworkSelectButton(service: _w3mService),
//         const SizedBox(
//           height: 16,
//         ),
//         W3MAccountButton(service: _w3mService),
//         const SizedBox(
//           height: 16,
//         ),
//         ElevatedButton(
//             onPressed: _onPersonalSign, child: const Text("Personal Sign"))
//       ],
//     );
//   }
// }

// const _chainId = "11155111";

// final _sepoliaChain = W3MChainInfo(
//   chainName: 'Sepolia',
//   namespace: 'eip155:$_chainId',
//   chainId: _chainId,
//   tokenName: 'ETH',
//   rpcUrl: 'https://rpc.sepolia.org/',
//   blockExplorer: W3MBlockExplorer(
//     name: 'Sepolia Explorer',
//     url: 'https://sepolia.etherscan.io/',
//   ),
// );

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
    await _w3mService.launchConnectedWallet();
    var hash = await _w3mService.web3App?.request(
      topic: _w3mService.session!.topic ?? "",
      chainId: 'eip155:1',
      request: SessionRequestParams(
        method: 'personal_sign',
        params: ['GM from W3M flutter!!', _w3mService.session!.address],
      ),
    );
    debugPrint(hash);
  }

  void _initializeService() async {
    W3MChainPresets.chains.putIfAbsent('11155111', () => _sepoliaChain);
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

  @override
  void dispose() {
    super.dispose();
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

const _chainId = "11155111";

final _sepoliaChain = W3MChainInfo(
  chainName: 'Ethereum Mainnet',
  namespace: 'eip155:1',
  chainId: 'eip155:1',
  tokenName: 'ETH',
  rpcUrl: 'https://rpc.sepolia.org/',
  blockExplorer: W3MBlockExplorer(
    name: 'Sepolia Explorer',
    url: 'https://sepolia.etherscan.io/',
  ),
);
