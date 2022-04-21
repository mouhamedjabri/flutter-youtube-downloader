import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_youtube_downloader/flutter_youtube_downloader.dart';

import '../simpelData/tipslist.dart';
import 'drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _textFealdController = TextEditingController();
  String youTube_link = "";
  String? _extractedLink = 'Loading...';
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> extractYoutubeLink() async {
    String link;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      link = await FlutterYoutubeDownloader.extractYoutubeLink(youTube_link, 18);
    } on PlatformException {
      link = 'Failed to Extract YouTube Video Link.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _extractedLink = link;
    });
  }

  Future<void> downloadVideo() async {
    final result = await FlutterYoutubeDownloader.downloadVideo(
        youTube_link, "Youtube Downloader", 18);
    print(result.toString());
    print("Download");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textFealdController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          child: DrawerScreen(),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _key.currentState!.openDrawer(),
                        icon: Icon(LineIcons.bars),
                        iconSize: 45,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text(
                        "YouTube Downloader helps you save Youtube videos to your device.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: _textFealdController,
                      decoration: InputDecoration(
                        suffixIcon: _textFealdController.text.isEmpty
                            ? Container(
                          width: 0,
                        )
                            : IconButton(
                          icon: Icon(Icons.close,
                              size: 30, color: Colors.black),
                          onPressed: () {
                            _textFealdController.clear();
                          },
                        ),
                        hintText: 'Videow URL...',
                        enabled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () {
                        youTube_link = _textFealdController.text;
                        extractYoutubeLink();
                        downloadVideo();
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_circle_down,
                            size: 50,
                            color: Colors.white,
                          ),
                          Text(
                            "Download",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ListView.builder(
                padding: EdgeInsets.all(20),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) => ListTile(
                  title: Text(TipsList[index]["tips"].toString()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
