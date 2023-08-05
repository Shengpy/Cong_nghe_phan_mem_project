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
      ..birthday = json['birthday'] as String
      ..gender = json['gender'] as String
      ..address = json['address'] as String
      ..phoneNumber = json['phoneNumber'] as String
      ..education = json['education'] as String
      ..sexualOrentation = json['sexualOrentation'] as String
      ..describe = json['describe'] as String
      ..image = json['image'] as String
      ..likedMe =
          (json['likedMe'] as List<dynamic>).map((e) => e as String).toList()
      ..myFavorites = (json['myFavorites'] as List<dynamic>)
          .map((e) => e as String)
          .toList()
      ..hobby =
          (json['hobby'] as List<dynamic>).map((e) => e as String).toList()
      ..chattingPersons = (json['chattingPersons'] as List<dynamic>)
          .map((e) => e as String)
          .toList();

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'email': instance.email,
      'address': instance.address,
      'phoneNumber': instance.phoneNumber,
      'education': instance.education,
      'sexualOrentation': instance.sexualOrentation,
      'describe': instance.describe,
      'image': instance.image,
      'likedMe': instance.likedMe,
      'myFavorites': instance.myFavorites,
      'hobby': instance.hobby,
      'chattingPersons': instance.chattingPersons,
    };
