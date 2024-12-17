import 'package:duckrace/core/services/navigation_service.dart';
import 'package:duckrace/core/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../providers/updates_provider.dart';
import '../widgets/category_selector.dart';
import '../widgets/update_card.dart';
import '../../../../core/widgets/bottom_nav_bar.dart';

class UpdatesScreen extends ConsumerStatefulWidget {
  const UpdatesScreen({super.key});

  @override
  ConsumerState<UpdatesScreen> createState() => _UpdatesScreenState();
}

class _UpdatesScreenState extends ConsumerState<UpdatesScreen> {
  late final NotificationService _notificationService;

  void _handleNavigation(int index) {
    debugPrint('UpdatesScreen: Handling navigation for index $index');
    NavigationService.handleBottomNavigation(context, index);
  }

  @override
  void initState() {
    super.initState();
    _notificationService = NotificationService();
    _notificationService.initialize();
    
    Future.microtask(() {
      final category = ref.read(selectedCategoryProvider);
      ref.read(updatesProvider.notifier).fetchUpdates(category.name);
      ref.read(updatesProvider.notifier).subscribeToUpdates();
      
      // Setup notification handling
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (message.notification != null) {
          // Show local notification
          _notificationService.showNotification(
            id: DateTime.now().millisecondsSinceEpoch,
            title: message.notification!.title ?? '',
            body: message.notification!.body ?? '',
            payload: message.data['updateId'],
          );
        }
      });

      // Handle notification tap
      _notificationService.onNotificationTap.listen((String? updateId) {
        if (updateId != null) {
          ref.read(updatesProvider.notifier).fetchUpdateDetail(updateId).then(
            (update) {
              if (update != null) {
                NavigationService.navigateToEventUpdate(context, update);
              }
            },
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _notificationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(updatesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    ref.listen(selectedCategoryProvider, (previous, next) {
      if (previous != next) {
        ref.read(updatesProvider.notifier).fetchUpdates(next.name);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Updates'),
      ),
      bottomNavigationBar: BottomNavBar(
        onIndexChanged: _handleNavigation,
      ),
      body: Column(
        children: [
          const CategorySelector(),
          const SizedBox(height: 8),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await ref
                    .read(updatesProvider.notifier)
                    .fetchUpdates(selectedCategory.name);
              },
              child: state.isLoading && state.updates.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : state.error != null && state.updates.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 48,
                                color: Colors.red,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                state.error!,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(updatesProvider.notifier)
                                      .fetchUpdates(selectedCategory.name);
                                },
                                child: const Text('Try Again'),
                              ),
                            ],
                          ),
                        )
                      : state.updates.isEmpty
                          ? Center(
                              child: Text(
                                'No updates available for ${selectedCategory.label}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              itemCount: state.updates.length,
                              itemBuilder: (context, index) {
                                return UpdateCard(
                                  update: state.updates[index],
                                );
                              },
                            ),
            ),
          ),
        ],
      ),
    );
  }
}
