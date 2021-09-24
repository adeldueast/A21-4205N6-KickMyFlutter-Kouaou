import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
part 'transfer.g.dart';

// TODO :  SignUP REQUEST returns a RESPONSE
@JsonSerializable()
class SignupRequest {
  SignupRequest();

  String username = "";
  String password = "";

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SignupRequest.fromJson(Map<String, dynamic> json) =>
      _$SignupRequestFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SignupRequestToJson(this);
}

@JsonSerializable()
class SignupResponse {
  SignupResponse();

  String username = "";

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}

// TODO :  Signin  REQUEST / RESPONSE
@JsonSerializable()
class SigninRequest extends SignupRequest {
  SigninRequest();

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SigninRequest.fromJson(Map<String, dynamic> json) =>
      _$SigninRequestFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SigninRequestToJson(this);
}

@JsonSerializable()
class SigninResponse {
  SigninResponse();

  String username = "";

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SigninResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SigninResponseToJson(this);
}

@JsonSerializable()
class AddTaskRequest {
  AddTaskRequest();

  String name = "";

  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime deadLine = DateTime.now();

  factory AddTaskRequest.fromJson(Map<String, dynamic> json) =>
      _$AddTaskRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);
}

@JsonSerializable()
class HomeItemResponse {
  HomeItemResponse(this.id,this.name,this.percentageDone,this.percentageTimeSpent,this.deadline);

  int id;
  String name;
  int percentageDone;
  int percentageTimeSpent;

  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime deadline ;

  factory HomeItemResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeItemResponseToJson(this);

  @override
  String toString() {
    return 'Task: {name: $name, pourcentageTask: $percentageDone pourcentage: $percentageTimeSpent dateLimite : $deadline';
  }
}

@JsonSerializable()
class TaskDetailResponse {
  TaskDetailResponse(this.id,this.name,this.deadLine,this.percentageDone,this.percentageTimeSpent);

  int id;
  String name;
  @JsonKey(fromJson: _fromJson, toJson: _toJson)
  DateTime deadLine;
  int percentageDone;
  int percentageTimeSpent;

  factory TaskDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskDetailResponseToJson(this);

  @override
  String toString() {
    return 'TaskDetail: {name: $name, pourcentageTaskDone: $percentageDone pourcentageDate: $percentageTimeSpent dateLimite : $deadLine';
  }
}

final _dateFormatter = DateFormat('MMM d, yyyy h:mm:ss a');

DateTime _fromJson(String date) => _dateFormatter.parse(date);

String _toJson(DateTime date) => _dateFormatter.format(date);
