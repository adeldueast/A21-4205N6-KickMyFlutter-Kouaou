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
    ..deadLine = _fromJson(json['deadLine'] as String);
}

Map<String, dynamic> _$AddTaskRequestToJson(AddTaskRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'deadLine': _toJson(instance.deadLine),
    };

HomeItemResponse _$HomeItemResponseFromJson(Map<String, dynamic> json) {
  return HomeItemResponse(
    json['id'] as int?,
    json['name'] as String?,
    json['percentageDone'] as int?,
    json['percentageTimeSpent'] as int?,
    _fromJson(json['deadline'] as String),
  );
}

Map<String, dynamic> _$HomeItemResponseToJson(HomeItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'percentageDone': instance.percentageDone,
      'percentageTimeSpent': instance.percentageTimeSpent,
      'deadline': _toJson(instance.deadline),
    };

TaskDetailResponse _$TaskDetailResponseFromJson(Map<String, dynamic> json) {
  return TaskDetailResponse(
    json['id'] as int?,
    json['name'] as String?,
    _fromJson(json['deadLine'] as String),
    json['percentageDone'] as int?,
    json['percentageTimeSpent'] as int?,
  );
}

Map<String, dynamic> _$TaskDetailResponseToJson(TaskDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'deadLine': _toJson(instance.deadLine),
      'percentageDone': instance.percentageDone,
      'percentageTimeSpent': instance.percentageTimeSpent,
    };
