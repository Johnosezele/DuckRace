import 'package:duckrace/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/supabase/supabase_service.dart';
import '../data/models/sponsor_data.dart';

enum SubmissionStatus { initial, loading, success, error }

class SponsorState {
  final bool isLoading;
  final SubmissionStatus status;
  final String? error;

  const SponsorState({
    this.isLoading = false,
    this.status = SubmissionStatus.initial,
    this.error,
  });

  SponsorState copyWith({
    bool? isLoading,
    SubmissionStatus? status,
    String? error,
  }) {
    return SponsorState(
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

final sponsorProvider = StateNotifierProvider<SponsorNotifier, SponsorState>((ref) {
  return SponsorNotifier(ref.read(supabaseServiceProvider));
});

class SponsorNotifier extends StateNotifier<SponsorState> {
  final SupabaseService _supabaseService;

  SponsorNotifier(this._supabaseService) : super(const SponsorState());

  Future<void> registerSponsor(SponsorData data) async {
    state = state.copyWith(isLoading: true);
    try {
      await _supabaseService.registerSponsor(data);
      state = state.copyWith(
        isLoading: false,
        status: SubmissionStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        status: SubmissionStatus.error,
        error: e.toString(),
      );
    }
  }
}
