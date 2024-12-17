class EventUpdate {
  final String id;
  final String category;
  final String type;
  final String contentUrl;
  final String? content;
  final String? description;
  final DateTime createdAt;

  EventUpdate({
    required this.id,
    required this.category,
    required this.type,
    required this.contentUrl,
    this.content,
    this.description,
    required this.createdAt,
  });

  factory EventUpdate.fromJson(Map<String, dynamic> json) => EventUpdate(
    id: json['id'],
    category: json['category'],
    type: json['type'],
    contentUrl: json['content_url'],
    content: json['content'],
    description: json['description'],
    createdAt: DateTime.parse(json['created_at']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'category': category,
    'type': type,
    'content_url': contentUrl,
    'content': content,
    'description': description,
    'created_at': createdAt.toIso8601String(),
  };
}
