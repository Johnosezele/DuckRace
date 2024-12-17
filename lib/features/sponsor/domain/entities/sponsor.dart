class Sponsor {
  final String id;
  final String name;
  final String email;
  final String? logoUrl;
  final String? websiteUrl;
  final String? duckId;
  final String status;
  final DateTime createdAt;

  Sponsor({
    required this.id,
    required this.name,
    required this.email,
    this.logoUrl,
    this.websiteUrl,
    this.duckId,
    required this.status,
    required this.createdAt,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      logoUrl: json['logo_url'],
      websiteUrl: json['website_url'],
      duckId: json['duck_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'logo_url': logoUrl,
      'website_url': websiteUrl,
      'duck_id': duckId,
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
