import 'package:clean_architecture/features/posts/domain/entities/posts_entity.dart';

//! this is model extends from entity and bad way
// class PostsModel extends PostsEntity {
//   const PostsModel({
//     required super.id,
//     required super.title,
//     required super.body,
//   });

//   factory PostsModel.fromJson(Map<String, dynamic> json) {
//     return PostsModel(
//       id: json['id'],
//       title: json['title'] as String,
//       body: json['body'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'body': body,
//     };
//   }
// }

//! remember this with Mapper and the best way
class PostsModel {
  final int? id;
  final String title;
  final String body;

  PostsModel({
    this.id,
    required this.title,
    required this.body,
  });

  PostsEntity toEntity() {
    return PostsEntity(
      id: id,
      title: title,
      body: body,
    );
  }

  factory PostsModel.fromEntity(PostsEntity entity) {
    return PostsModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
    );
  }

  Map<String, dynamic> mapToEntity() {
    return {
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  PostsModel copyWith({int? id, String? title, String? body}) {
    return PostsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
