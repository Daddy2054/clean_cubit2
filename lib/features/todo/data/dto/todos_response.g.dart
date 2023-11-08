// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ToDosResponseImpl _$$ToDosResponseImplFromJson(Map<String, dynamic> json) =>
    _$ToDosResponseImpl(
      currentPage: json['current_page'] as int? ?? 0,
      data: (json['data'] as List<dynamic>?)
              ?.map(
                  (e) => ToDosResponseItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastPage: json['last_page'] as int? ?? 0,
      perPage: json['per_page'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
    );

Map<String, dynamic> _$$ToDosResponseImplToJson(_$ToDosResponseImpl instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'last_page': instance.lastPage,
      'per_page': instance.perPage,
      'total': instance.total,
    };

_$ToDosResponseItemImpl _$$ToDosResponseItemImplFromJson(
        Map<String, dynamic> json) =>
    _$ToDosResponseItemImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      note: json['note'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$ToDosResponseItemImplToJson(
        _$ToDosResponseItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'body': instance.body,
      'note': instance.note,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
