import 'package:flutter/material.dart';
import '../provider/provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MetamaskProvider()..init(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text('Home'),
          ),
          body: Container(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: Consumer<MetamaskProvider>(
                builder: (context, provider, child) {
                  late final String text;
                  if (provider.isConnected && provider.isInOperatingChain) {
                    text = 'Connected';
                  } else if (provider.isConnected &&
                      !provider.isInOperatingChain) {
                    text =
                        'Wrong chain. connect to ${MetamaskProvider.operatingChain}';
                  } else if (provider.isEnabled) {
                    return Column(
                      children: [
                        Text(
                          "Pay with crypto",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                                //side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          child: Text("CONNECT YOUR WALLET"),
                          onPressed: () =>
                              context.read<MetamaskProvider>().connect(),
                        ),
                      ],
                    );
                  } else {
                    text = 'use a web3 browser';
                  }

                  return Text(text);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
