// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      username: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
    )..info = Person.fromJson(json['info'] as Map<String, dynamic>);

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'info': instance.info.toJson(),
    };

Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      name: json['name'] as String? ?? '',
      age: json['age'] as int? ?? 0,
      email: json['email'] as String? ?? '',
    )
      ..gentle = json['gentle'] as String
      ..address = json['address'] as String
      ..phoneNumber = json['phoneNumber'] as String
      ..education = json['education'] as String
      ..sexualOrentation = json['sexualOrentation'] as String
      ..describe = json['describe'] as String
      ..image = json['image'] as String;

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'gentle': instance.gentle,
      'email': instance.email,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'education': instance.education,
      'sexualOrentation': instance.sexualOrentation,
      'describe': instance.describe,
      'image': instance.image,
    };
