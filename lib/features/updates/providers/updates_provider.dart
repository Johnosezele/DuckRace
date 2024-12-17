import 'package:duckrace/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/firebase/messaging_service.dart';
import '../../../services/supabase/supabase_service.dart';
import '../data/models/update_model.dart';

class UpdatesState {
  final bool isLoading;
  final List<EventUpdate> updates;
  final String? error;

  const UpdatesState({
    this.isLoading = false,
    this.updates = const [],
    this.error,
  });

  UpdatesState copyWith({
    bool? isLoading,
    List<EventUpdate>? updates,
    String? error,
  }) {
    return UpdatesState(
      isLoading: isLoading ?? this.isLoading,
      updates: updates ?? this.updates,
      error: error ?? this.error,
    );
  }
}

final updatesProvider = StateNotifierProvider<UpdatesNotifier, UpdatesState>((ref) {
  return UpdatesNotifier(
    ref.read(supabaseServiceProvider),
    ref.read(messagingServiceProvider),
  );
});

final updateDetailProvider = FutureProvider.family<EventUpdate?, String>((ref, updateId) async {
  return ref.read(updatesProvider.notifier).fetchUpdateDetail(updateId);
});

class UpdatesNotifier extends StateNotifier<UpdatesState> {
  final SupabaseService _supabaseService;
  final MessagingService _messagingService;

  UpdatesNotifier(this._supabaseService, this._messagingService) 
      : super(const UpdatesState());

  Future<void> fetchUpdates(String category) async {
    state = state.copyWith(isLoading: true);
    try {
      final updates = await _supabaseService.getUpdates(category);
      state = state.copyWith(
        isLoading: false,
        updates: updates,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<EventUpdate?> fetchUpdateDetail(String updateId) async {
    try {
      final update = await _supabaseService.getUpdateById(updateId);
      return update;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      return null;
    }
  }

  void subscribeToUpdates() {
    _messagingService.notificationStream.listen((message) {
      final category = message.data['category'] as String?;
      if (category != null) {
        fetchUpdates(category);
      }
    });
  }
}
