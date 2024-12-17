import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../data/models/update_model.dart';

class EventUpdateTextView extends StatelessWidget {
  final EventUpdate update;

  const EventUpdateTextView({
    super.key,
    required this.update, required String id, required String category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(update.category),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              update.contentUrl ?? 'No content available',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Posted on ${update.createdAt.toString()}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class EventUpdateImageView extends StatelessWidget {
  final EventUpdate update;

  const EventUpdateImageView({
    super.key,
    required this.update, required String id, required String category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(update.category),
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              child: Image.network(
                update.contentUrl,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(Icons.error_outline),
                ),
              ),
            ),
          ),
          if (update.description != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(update.description!),
            ),
        ],
      ),
    );
  }
}

class EventUpdateVideoView extends StatefulWidget {
  final EventUpdate update;

  const EventUpdateVideoView({
    super.key,
    required this.update, required String id, required String category,
  });

  @override
  State<EventUpdateVideoView> createState() => _EventUpdateVideoViewState();
}

class _EventUpdateVideoViewState extends State<EventUpdateVideoView> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.update.contentUrl),
    );
    try {
      await _controller.initialize();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.update.category),
      ),
      body: Column(
        children: [
          if (_isInitialized) ...[
            AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
            VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              padding: const EdgeInsets.all(16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                ),
              ],
            ),
          ] else
            const Center(
              child: CircularProgressIndicator(),
            ),
          if (widget.update.description != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(widget.update.description!),
            ),
        ],
      ),
    );
  }
}
