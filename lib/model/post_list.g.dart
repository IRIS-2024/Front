// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostList _$PostListFromJson(Map<String, dynamic> json) => PostList(
      pid: json['pid'] as int,
      imgUrl: json['imgUrl'] as String,
      name: json['name'] as String,
      age: json['age'] as String,
      address: json['address'] as String,
      disappearedAt: json['disappearedAt'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      bookmarked: json['bookmarked'] as bool,
    );

Map<String, dynamic> _$PostListToJson(PostList instance) => <String, dynamic>{
      'pid': instance.pid,
      'imgUrl': instance.imgUrl,
      'name': instance.name,
      'age': instance.age,
      'address': instance.address,
      'disappearedAt': instance.disappearedAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'bookmarked': instance.bookmarked,
    };
