import 'package:flutter/material.dart';
import '../../data/models/update_model.dart';
import '../../../../core/services/navigation_service.dart';

class UpdateCard extends StatelessWidget {
  final EventUpdate update;

  const UpdateCard({
    super.key,
    required this.update,
  });

  Widget _buildPreview(BuildContext context) {
    switch (update.type) {
      case 'image':
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            update.contentUrl,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Center(
              child: Icon(Icons.error_outline),
            ),
          ),
        );
      case 'video':
        return Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                update.contentUrl + '/thumbnail',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(
                  child: Icon(Icons.error_outline),
                ),
              ),
            ),
            const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.black54,
              child: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
            ),
          ],
        );
      default:
        return const SizedBox(height: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: InkWell(
        onTap: () => NavigationService.navigateToUpdates(
          context,
          update.category,
          update.type,
          update.id,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    update.type == 'image'
                        ? Icons.image
                        : update.type == 'video'
                            ? Icons.video_library
                            : Icons.article,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    update.category,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(update.createdAt),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildPreview(context),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
