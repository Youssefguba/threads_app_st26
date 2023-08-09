class SinglePostModel {
  final String? username;
  final String? userPhoto;
  final String? content;
  final String? timestamp;
  final String? id;

  SinglePostModel({
    this.username,
    this.userPhoto,
    this.content,
    this.id,
    this.timestamp,
  });

  factory SinglePostModel.fromJson(Map<String, dynamic> json) {
    return SinglePostModel(
      username: json['name'],
      id: json['id'],
      userPhoto: json['photo'],
      content: json['content'],
      timestamp: json['timestamp'],
    );
  }
}
