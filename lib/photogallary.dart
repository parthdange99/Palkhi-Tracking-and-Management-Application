import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:video_player/video_player.dart';

class MediaPage extends StatefulWidget {
  @override
  _MediaPageState createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  List<Map<String, String>> photos = [];
  List<Map<String, String>> videos = [];
  bool isLoading = true;
  bool hasError = false;
  @override
  void initState() {
    super.initState();
    fetchMedia();
  }

  Future<void> fetchMedia() async {
    final url = "http://192.168.55.96:3307/media/list"; // Replace with your backend API
    try {
      final response = await http.get(Uri.parse(url));
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      if (response.statusCode ==  200 &&
          response.headers['content-type']?.contains('application/json') == true) {
        final data = json.decode(response.body);
        final mediaList = List<Map<String, dynamic>>.from(data["data"] ?? []);
        setState(() {

          photos = mediaList
              .where((media) => media["type"] == "photo")
              .map((photo) => {
            "url": photo["url"]?.toString() ?? "",
            "description": photo["description"]?.toString() ?? "No description",

          })
              .toList();
          videos = mediaList
              .where((media) => media["type"] == "video")
              .map((video) => {
            "url": video["url"]?.toString() ?? "",
            "description": video["description"]?.toString() ?? "No description",
          })
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception("Failed to fetch valid JSON data from API");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching media: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dindi Media"),
        backgroundColor: Colors.orange,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
          ? Center(child: Text("Failed to load media. Please try again later."))
          : CustomScrollView(
        slivers: [
          // Photos Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Photos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          photos.isNotEmpty
              ? SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Adjust columns based on your design
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) => buildPhotoCard(index),
              childCount: photos.length,
            ),
          )
              : SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("No photos available."),
              ),
            ),
          ),
          // Videos Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Videos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          videos.isNotEmpty
              ? SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => buildVideoCard(index),
              childCount: videos.length,
            ),
          )
              : SliverToBoxAdapter(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("No videos available."),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPhotoCard(int index) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              photos[index]["url"] ?? "",
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Icon(Icons.error)); // Error icon for failed loads
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              photos[index]["description"]!,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildVideoCard(int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          VideoPlayerWidget(videoUrl: videos[index]["url"]!),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              videos[index]["description"]!,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        if (mounted) setState(() {});
      }).catchError((error) {
        print("Error initializing video: $error");
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Center(child: CircularProgressIndicator());
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
