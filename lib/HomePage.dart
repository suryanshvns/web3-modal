import 'package:flutter/material.dart';
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
    initializedState();
  }

  void initializedState() async {
    W3MChainPresets.chains.putIfAbsent(_chainId, () => _sepoliaChain);
    _w3mService = W3MService(
      projectId: '28f8679078313fbf8bd20452df74df4e',
      metadata: const PairingMetadata(
        name: 'Web3Modal Flutter Example',
        description: 'Web3Modal Flutter Example',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'flutterdapp://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
    await _w3mService.init();
  }

  void _onPersonalSign() async {
    await _w3mService.launchConnectedWallet();
    final result = await _w3mService.request(
      topic: _w3mService.session?.topic ?? '',
      chainId: 'eip155:$_chainId', // Connected chain id
      request: SessionRequestParams(
        method: 'personal_sign',
        params: ['Sign this', _w3mService.session!.address!],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        W3MConnectWalletButton(service: _w3mService),
        const SizedBox(
          height: 16,
        ),
        W3MNetworkSelectButton(service: _w3mService),
        const SizedBox(
          height: 16,
        ),
        W3MAccountButton(service: _w3mService),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
            onPressed: _onPersonalSign, child: const Text("Personal Sign"))
      ],
    );
  }
}

const _chainId = "11155111";

final _sepoliaChain = W3MChainInfo(
  chainName: 'Sepolia',
  namespace: 'eip155:$_chainId',
  chainId: _chainId,
  tokenName: 'ETH',
  rpcUrl: 'https://rpc.sepolia.org/',
  blockExplorer: W3MBlockExplorer(
    name: 'Sepolia Explorer',
    url: 'https://sepolia.etherscan.io/',
  ),
);
