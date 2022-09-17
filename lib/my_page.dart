import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('önplan mesajı');
      print('Mesaj içerik: ${message.data}');
      // log("onMessage: $message");
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: Duration(seconds:20 ),
        content: AwesomeSnackbarContent(title: message.notification!.title.toString(),
        message: message.notification!.body.toString(), contentType: ContentType.failure),
       
      );
       ScaffoldMessenger.of(context).showSnackBar(snackBar);
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: 'url',
      ),
    );
  }
}
