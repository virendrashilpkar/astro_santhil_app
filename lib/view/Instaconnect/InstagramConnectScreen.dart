import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class InstagramConnectScreen extends StatefulWidget {
  @override
  _InstagramConnectScreenState createState() => _InstagramConnectScreenState();
}

class _InstagramConnectScreenState extends State<InstagramConnectScreen> {
  // final redirectUri = "https://www.instagram.com/"; // Set your redirect URI here
  final redirectUri = "https://shaadiapp-ac9ac.firebaseapp.com/__/auth/handler"; // Set your redirect URI here
  final client_id = "650490860384715"; // Set your redirect URI here
  final client_secret_id = "b5d64762a90f17afd9712d88869c2f59"; // Set your redirect URI here
  final authUrl = "https://api.instagram.com/oauth/authorize" +
      "?client_id=650490860384715" +
      "&redirect_uri=https://shaadiapp-ac9ac.firebaseapp.com/__/auth/handler" +
      "&response_type=code" +
      "&scope=user_profile,user_media";

  late WebViewController controller;
  bool isload=false;
  @override
  void initState() {
     controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            print(">>>><<<<${request.url}");
            if (request.url.startsWith(redirectUri)) {
              _handleAuthCode(request.url);
              return NavigationDecision.prevent;  // Prevent loading the URL
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(authUrl));  }


  @override
  void dispose() {
    controller.clearLocalStorage();
    controller.clearCache();
    // Call the superclass's dispose() method
    super.dispose();

    // Perform any additional cleanup or resource release specific to your widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Instagram Connect"),
      ),
      body: Center(
        child: isload==false ? ElevatedButton(
          onPressed: () {
            setState(() {
              isload=true;
            });
            // _startInstagramLogin();
          },
          child: Text("Connect to Instagram"),
        ):WebViewWidget(controller: controller),
      ),
    );
  }

  void _startInstagramLogin() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewWidget(controller: controller)
      ),
    );
  }


  void _handleAuthCode(String url) async {

    // Parse the authorization code from the URL
    print(">>>>>${url}");
    final code = Uri.parse(url).queryParameters['code'];

    // Exchange the authorization code for an access token
    final tokenUrl = "https://api.instagram.com/oauth/access_token";
    try {
      final object = {
        "client_id": "${client_id}",
        // Replace with your client ID
        "client_secret": "${client_secret_id}",
        // Replace with your client secret
        "code": code,
        "grant_type": "authorization_code",
        "redirect_uri": redirectUri,
      };
      print(">>>>>${tokenUrl}");
      print(">>>>>${object}");
      final response = await http.post(Uri.parse(tokenUrl), body: object);
      print(">>>>>${response.request}");
      if (response.statusCode == 200) {
        final accessToken = response.body; // Extract access token from response
        final userData = json.decode(response.body);

        final mediaUrl = "https://graph.instagram.com/me/media" +
            "?fields=id,caption,media_url,thumbnail_url,media_type" +
            "&access_token=${userData['$accessToken']}" +
            "&limit=6"; // Limit to 6 photos

        final mediaResponse = await http.get(Uri.parse(mediaUrl));

        if (mediaResponse.statusCode == 200) {
          final mediaData = json.decode(mediaResponse.body);
          final List<dynamic> mediaList = mediaData['data'];

          // Now you have the user's 6 most recent photos, you can display them in your app's UI
          for (var media in mediaList) {
            final mediaType = media['media_type'];
            final mediaUrl = mediaType == 'IMAGE' ? media['media_url'] : media['thumbnail_url'];
            final caption = media['caption'];
            // Display the media and caption in your UI
          }
        } else {
          // Handle error
        }
      } else {
        // Handle error
      }
    }catch(error){
      print('Error: $error');
    }


  }


}


