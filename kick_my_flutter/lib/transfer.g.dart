// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequest _$SignupRequestFromJson(Map<String, dynamic> json) {
  return SignupRequest()
    ..username = json['username'] as String
    ..password = json['password'] as String;
}

Map<String, dynamic> _$SignupRequestToJson(SignupRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) {
  return SignupResponse()..username = json['username'] as String;
}

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

SigninRequest _$SigninRequestFromJson(Map<String, dynamic> json) {
  return SigninRequest()
    ..username = json['username'] as String
    ..password = json['password'] as String;
}

Map<String, dynamic> _$SigninRequestToJson(SigninRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

SigninResponse _$SigninResponseFromJson(Map<String, dynamic> json) {
  return SigninResponse()..username = json['username'] as String;
}

Map<String, dynamic> _$SigninResponseToJson(SigninResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
    };

AddTaskRequest _$AddTaskRequestFromJson(Map<String, dynamic> json) {
  return AddTaskRequest()
    ..name = json['name'] as String
    ..deadline = DateTime.parse(json['deadline'] as String);
}

Map<String, dynamic> _$AddTaskRequestToJson(AddTaskRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deadline': instance.deadline.toIso8601String(),
    };

HomeItemResponse _$HomeItemResponseFromJson(Map<String, dynamic> json) {
  return HomeItemResponse()
    ..id = json['id'] as int?
    ..name = json['name'] as String?
    ..percentageDone = json['percentageDone'] as int?
    ..percentageTimeSpent = json['percentageTimeSpent'] as int?
    ..deadline = json['deadline'] == null
        ? null
        : DateTime.parse(json['deadline'] as String);
}

Map<String, dynamic> _$HomeItemResponseToJson(HomeItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'percentageDone': instance.percentageDone,
      'percentageTimeSpent': instance.percentageTimeSpent,
      'deadline': instance.deadline?.toIso8601String(),
    };
