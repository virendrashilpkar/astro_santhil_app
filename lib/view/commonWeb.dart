import 'package:flutter/material.dart';
import 'package:shadiapp/CommonMethod/CommonColors.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class CommonWeb extends StatefulWidget {
  final String url;

  CommonWeb({required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<CommonWeb> {
  late WebViewController controller;
  bool _isLoading = true;


  @override
  void initState() {
    startweb();
  }

  void startweb(){
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print(">>>>${startweb}");
            setState(() {
              _isLoading=false;
            });
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('${widget.url}')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('${widget.url}'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.buttonorg,
        title: Text(''),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Stack(
              children: [
                WebViewWidget(controller: controller),
                if (_isLoading)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CommonColors.buttonorg,
        onPressed: () {
          _goBack();
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  // Navigate back within the WebView
  Future<void> _goBack() async {
    if (await controller.canGoBack()) {
      controller.goBack();
    } else {
      // If there is no history, exit the WebView page
      Navigator.pop(context);
    }
  }
}
