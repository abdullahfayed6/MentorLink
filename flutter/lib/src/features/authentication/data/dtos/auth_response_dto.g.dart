// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseDtoImpl _$$AuthResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AuthResponseDtoImpl(
  success: json['success'] as bool?,
  message: json['message'] as String?,
  token: json['token'] == null
      ? null
      : TokenDto.fromJson(json['token'] as Map<String, dynamic>),
  user: json['user'] == null
      ? null
      : UserDto.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$AuthResponseDtoImplToJson(
  _$AuthResponseDtoImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'message': instance.message,
  'token': instance.token,
  'user': instance.user,
};
