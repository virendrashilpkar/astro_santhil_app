import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

class AuthorizationPage extends StatefulWidget {
  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  String authorizationCode = ''; // This will hold the authorization code
  final String clientId = '335e8e892d4f455d845720fd06d90846';
  final String redirectUri = 'https://shaadiapp-ac9ac.firebaseapp.com/__/auth/handler';
  final String clientSecret = '7e0d105f5caf4f578f6431fc6836f545';
  final String scopes = 'user-read-private user-read-email playlist-read-private user-library-read user-follow-read';
  String accessToken = '';
  String username = '';
  String userid = '';
  List<String> playlists = [];
  List<String> artistNames = [];




  Future<void> exchangeAuthorizationCodeForToken(String url) async {

    final code = Uri.parse(url).queryParameters['code'];
    final tokenUrl = 'https://accounts.spotify.com/api/token';

    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {
        'Authorization': 'Basic ${base64.encode(utf8.encode('$clientId:$clientSecret'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      accessToken = responseData['access_token'];
      fetchUserProfile();
    } else {
      throw Exception('Failed to exchange authorization code for access token');
    }
  }

  Future<void> fetchUserProfile() async {
    final userUrl = 'https://api.spotify.com/v1/me';

    final response = await http.get(
      Uri.parse(userUrl),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      username = userData['display_name'];
      userid = userData['id'];
      getFollowedArtists();
      getUserPlaylists();
      // Navigator.pop(context, username);
    } else {
      getUserPlaylists();
      // throw Exception('Failed to retrieve user profile from Spotify.');
    }
  }



  Future<void> getUserPlaylists() async {
    final playlistsUrl = 'https://api.spotify.com/v1/me/playlists';

    final response = await http.get(
      Uri.parse(playlistsUrl),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode == 200) {
      final playlistsData = json.decode(response.body);

      if (playlistsData.containsKey('items') || playlistsData['items'].isBlank) {

        playlists = (playlistsData['items'] as List<dynamic>)
            .map<String>((playlist) => playlist['name'] as String)
            .toList();
        String playlistid=playlistsData['items'][0]["id"];
        getPlaylistTracks(playlistid);
      }

    } else {
      var josn={
        "user_id":"$userid",
        "username":"$username",
        "playlist":playlists,
        "artistNames":artistNames,
      };
      Navigator.pop(context, josn);
      // throw Exception('Failed to retrieve playlists from Spotify.');
    }
  }


  Future<void> getFollowedArtists() async {
    final artistsUrl = 'https://api.spotify.com/v1/me/following?type=artist';

    final response = await http.get(
      Uri.parse(artistsUrl),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.containsKey('artists') ||  responseData['artists']['items'].isBlank) {
        final artistsData = responseData['artists']['items'] as List<dynamic>;
        final artists = artistsData.take(5);
        artistNames =
            artists.map<String>((artist) => artist['name'] as String)
                .toList();
      }
    } else {
      throw Exception('Failed to fetch followed artists');
    }
  }


  Future<void> getPlaylistTracks(String playlistId) async {
    final playlistUrl = 'https://api.spotify.com/v1/playlists/$playlistId/tracks';

    final response = await http.get(
      Uri.parse(playlistUrl),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData.containsKey('items') ||  responseData['items'].isBlank) {
        final tracks = List<Map<String, dynamic>>.from(responseData['items']);
        final limitedTracks = tracks.take(5);
        playlists = limitedTracks.map<String>((
            track) => track['track']['name'] as String).toList();
      }
      var josn={
        "user_id":"$userid",
        "username":"$username",
        "playlist":playlists,
        "artistNames":artistNames,
      };
      Navigator.pop(context, josn);
    } else {
      var josn={
        "user_id":"$userid",
        "username":"$username",
        "playlist":playlists,
        "artistNames":artistNames,
      };
      Navigator.pop(context, josn);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spotify Connect'),
      ),
      body: Center(
        child: WebViewWidget(controller: controller)
      ),
    );
  }


  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    // Initialize the URL redirection handler
    // You can add this in your initState or wherever you handle URL redirection
    final authUrl = 'https://accounts.spotify.com/authorize'
        '?client_id=$clientId'
        '&redirect_uri=$redirectUri'
        '&response_type=code'
        '&scope=$scopes';
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
            if (request.url.startsWith(redirectUri)) {
              exchangeAuthorizationCodeForToken(request.url);
              return NavigationDecision.prevent;  // Prevent loading the URL
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(authUrl));
  }


}
