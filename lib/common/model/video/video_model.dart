class VideoModel {
  final int id;
  final String? video;
  final String? photo;
  final String type;
  final String title;
  final String status;
  final DateTime createdAt;

  VideoModel({
    required this.id,
    required this.status,
    this.video,
    required this.type,
    required this.photo,
    required this.title,
    required this.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      photo: json['photo'],
      video: json['video'],
      type: json['type'],
      title: json['title'],
      status: json['status'],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }
}

enum VideoProgress { processing, completed, failed }
