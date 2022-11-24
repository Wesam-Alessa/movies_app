import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewWidget extends StatefulWidget {
  final String url;
  const WebViewWidget({Key? key, required this.url}) : super(key: key);

  @override
  WebViewWidgetState createState() => WebViewWidgetState();
}

class WebViewWidgetState extends State<WebViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  if (!await launchUrl(
                    Uri.parse(
                        'https://keen.egybest.online/movie/${widget.url}'),
                    mode: LaunchMode.externalApplication,
                  )) {
                    throw 'Could not launch ${Uri.parse('https://keen.egybest.online/movie/${widget.url}')}';
                  }
                },
                child: const Text('Click to open on website'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
