import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:testappio/testappio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final testappio = TestAppio();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    if (Platform.isIOS) {
      // Initial setup for iOS
      //Get App Token from portal.testapp.io -> App -> Integrations -> Sessions (SDK)
      testappio.setup('<APP_TOKEN>', TestAppioEnvironment.dev);
    }

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TestApp.io SDK example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  testappio.user.identify("U123",
                      name: "Jane Doe", // optional
                      email: "jane.doe@example.com", // optional
                      imageUrl: "https://url/to/sample-image.png", // optional
                      traits: {
                        // optional
                        "vip": true,
                        "level": 13,
                        "theme": "dark"
                      });
                },
                child: const Text('Identify User'),
              ),
              ElevatedButton(
                onPressed: () async {
                  testappio.log.event("Item Purchased", {
                    //optional params
                    "id": 1,
                    "item": "Laptop",
                    "opt_for_sms": true
                  });
                },
                child: const Text('Log Event'),
              ),
              ElevatedButton(
                onPressed: () async {
                  testappio.log.error("Error event", {"code": 500});
                },
                child: const Text('Log Error'),
              ),
              ElevatedButton(
                onPressed: () async {
                  testappio.log.screen("Screen event", {"name": "HomeScreen"});
                },
                child: const Text('Log Screen'),
              ),
              ElevatedButton(
                onPressed: () async {
                  testappio.bar.show();
                },
                child: const Text('Show Bar'),
              ),
              ElevatedButton(
                onPressed: () async {
                  testappio.bar.hide();
                },
                child: const Text('Hide Bar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
