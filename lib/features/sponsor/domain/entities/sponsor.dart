class Sponsor {
  final String id;
  final String name;
  final String email;
  final String? logoUrl;
  final String status;
  final DateTime createdAt;

  Sponsor({
    required this.id,
    required this.name,
    required this.email,
    this.logoUrl,
    required this.status,
    required this.createdAt,
  });

  factory Sponsor.fromJson(Map<String, dynamic> json) {
    return Sponsor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      logoUrl: json['logo_url'],
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
      'status': status,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
