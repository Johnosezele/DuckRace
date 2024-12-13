class SupabaseException implements Exception {
  final String message;
  final dynamic error;

  SupabaseException({required this.message, this.error});

  @override
  String toString() => 'SupabaseException: $message${error != null ? ' ($error)' : ''}';
}
