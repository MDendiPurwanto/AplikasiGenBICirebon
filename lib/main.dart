import 'package:Satu_GenBI/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/src/widgets/will_pop_scope.dart';
import 'package:flutter/src/material/dialog.dart';
import 'package:flutter/src/material/progress_indicator.dart';

void main() {
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Set this to false
      home :Splashscreen(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebViewController _webViewController;
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          return false;
        } else {
          return await _showExitConfirmationDialog();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: WebView(
            initialUrl: "https://genbicirebon.com/",
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController controller) {
              _webViewController = controller;
            },
            onPageStarted: (String url) {
              setState(() {
                _isLoading = true;
              });
            },
            onPageFinished: (String url) {
              setState(() {
                _isLoading = false;
              });
              if (_isLoading)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(
                    minHeight: 2.0,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  )
                );
            },
          ),
        ),
      ),
    );
  }
  _showExitConfirmationDialog() async {
    return showDialog(context: context, builder: (context) => AlertDialog(
      title: Text('Keluar dari Aplikasi?'),
        content: Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text('Tidak'),
          ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('yakin'),
              ),
            ],
          ),
    );
  }
}



