class SponsorResponse {
  final String id;
  final String status;
  final DateTime createdAt;

  SponsorResponse({
    required this.id,
    required this.status,
    required this.createdAt,
  });

  factory SponsorResponse.fromJson(Map<String, dynamic> json) {
    return SponsorResponse(
      id: json['id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
