import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../data/models/update_model.dart';
import '../../providers/updates_provider.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';
import '../../../../core/services/navigation_service.dart';

class UpdateDetailScreen extends ConsumerStatefulWidget {
  final String updateId;

  const UpdateDetailScreen({
    super.key,
    required this.updateId,
  });

  @override
  ConsumerState<UpdateDetailScreen> createState() => _UpdateDetailScreenState();
}

class _UpdateDetailScreenState extends ConsumerState<UpdateDetailScreen> {
  VideoPlayerController? _videoController;

  void _handleNavigation(int index) {
    debugPrint('UpdateDetailScreen: Handling navigation for index $index');
    NavigationService.handleBottomNavigation(context, index);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(updatesProvider.notifier).fetchUpdateDetail(widget.updateId);
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo(String url) async {
    _videoController = VideoPlayerController.networkUrl(Uri.parse(url));
    await _videoController!.initialize();
    setState(() {});
  }

  Widget _buildContent(EventUpdate update) {
    switch (update.type) {
      case 'image':
        return InteractiveViewer(
          child: Image.network(
            update.contentUrl,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Center(
              child: Icon(Icons.error_outline),
            ),
          ),
        );
      case 'video':
        if (_videoController == null) {
          _initializeVideo(update.contentUrl);
          return const Center(child: CircularProgressIndicator());
        }
        if (!_videoController!.value.isInitialized) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            ),
            IconButton(
              icon: Icon(
                _videoController!.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
              onPressed: () {
                setState(() {
                  _videoController!.value.isPlaying
                      ? _videoController!.pause()
                      : _videoController!.play();
                });
              },
            ),
          ],
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(update.content ?? 'No content available'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final updateAsync = ref.watch(updateDetailProvider(widget.updateId));

    return WillPopScope(
      onWillPop: () async {
        return true; 
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Update Details'),
        ),
        bottomNavigationBar: BottomNavBar(
          onIndexChanged: _handleNavigation,
        ),
        body: updateAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(updatesProvider.notifier)
                        .fetchUpdateDetail(widget.updateId);
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          ),
          data: (update) {
            if (update == null) {
              return const Center(
                child: Text('Update not found'),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContent(update),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          update.category,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Posted on ${update.createdAt.toString()}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        if (update.description != null) ...[
                          const SizedBox(height: 16),
                          Text(update.description!),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
