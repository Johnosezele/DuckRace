class SponsorData {
  final String name;
  final String email;
  final String? logoUrl;

  SponsorData({
    required this.name,
    required this.email,
    this.logoUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'logo_url': logoUrl,
      'status': 'pending',
    };
  }
}
