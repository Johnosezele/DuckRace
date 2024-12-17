import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/exceptions/supabase_exception.dart';
import '../../features/sponsor/data/models/sponsor_data.dart';
import '../../features/sponsor/data/models/sponsor_response.dart';
import '../../features/sponsor/domain/entities/sponsor.dart';
import '../../features/updates/data/models/update_model.dart';

class SupabaseService {
  final SupabaseClient _client;

  SupabaseService({SupabaseClient? client}) 
    : _client = client ?? Supabase.instance.client;

  Future<SponsorResponse> registerSponsor(SponsorData data) async {
    try {
      final response = await _client
        .from('sponsors')
        .insert(data.toJson())
        .select()
        .single();
      return SponsorResponse.fromJson(response);
    } catch (e) {
      throw SupabaseException(
        message: 'Failed to register sponsor',
        error: e,
      );
    }
  }

  Future<List<Sponsor>> getApprovedSponsors() async {
    try {
      final response = await _client
        .from('sponsors')
        .select()
        .eq('status', 'approved')
        .order('created_at', ascending: false);
      
      return (response as List)
        .map((e) => Sponsor.fromJson(e as Map<String, dynamic>))
        .toList();
    } catch (e) {
      throw SupabaseException(
        message: 'Failed to fetch sponsors',
        error: e,
      );
    }
  }

  Future<List<EventUpdate>> getUpdates(String category) async {
    try {
      final response = await _client
        .from('updates')
        .select()
        .eq('category', category)
        .order('created_at', ascending: false);
      
      return (response as List)
        .map((e) => EventUpdate.fromJson(e as Map<String, dynamic>))
        .toList();
    } catch (e) {
      throw SupabaseException(
        message: 'Failed to fetch updates',
        error: e,
      );
    }
  }

  Future<void> updateSponsorStatus(String id, String status) async {
    try {
      await _client
        .from('sponsors')
        .update({'status': status})
        .eq('id', id);
    } catch (e) {
      throw SupabaseException(
        message: 'Failed to update sponsor status',
        error: e,
      );
    }
  }

  Future<EventUpdate> getUpdateById(String updateId) async {
    try {
      final response = await _client
        .from('updates')
        .select()
        .eq('id', updateId)
        .single();
      
      return EventUpdate.fromJson(response);
    } catch (e) {
      throw SupabaseException(
        message: 'Failed to fetch update details',
        error: e,
      );
    }
  }

  Stream<List<Sponsor>> subscribeToPendingSponsors() {
    return _client
      .from('sponsors')
      .stream(primaryKey: ['id'])
      .eq('status', 'pending')
      .order('created_at')
      .map((events) => events
        .map((event) => Sponsor.fromJson(event))
        .toList());
  }
}
