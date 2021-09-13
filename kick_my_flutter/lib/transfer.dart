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
  factory SignupRequest.fromJson(Map<String, dynamic> json) => _$SignupRequestFromJson(json);

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
  factory SignupResponse.fromJson(Map<String, dynamic> json) => _$SignupResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}


// TODO :  Signin  REQUEST / RESPONSE
@JsonSerializable()
class SigninRequest extends SignupRequest{

SigninRequest();
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SigninRequest.fromJson(Map<String, dynamic> json) => _$SigninRequestFromJson(json);

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
  factory SigninResponse.fromJson(Map<String, dynamic> json) => _$SigninResponseFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SigninResponseToJson(this);

}


@JsonSerializable()
class AddTaskRequest{

  AddTaskRequest();
  String? name;
  DateTime? deadline;


  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory AddTaskRequest.fromJson(Map<String, dynamic> json) => _$AddTaskRequestFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AddTaskRequestToJson(this);

}