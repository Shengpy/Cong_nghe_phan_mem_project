// ignore_for_file: constant_identifier_names

import 'dart:developer';

import 'package:flutter_application_1/class/Account.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../values/loginstatus.dart';

const MONGO_URL="mongodb+srv://kysheng12345:Sheng12345@cluster0.to3nj7r.mongodb.net/?retryWrites=true&w=majority";
const COLLECTION_NAME="user";
class MongoDatabase{
  static dynamic db;
  static dynamic collection;
  static Account myAcc=Account();
  static List<Account> accounts=[];
  static List<Account> chattingPersons=[];
  
  static connect() async{
    db= await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    collection = db.collection(COLLECTION_NAME);
    await loadData();
  }

  static insert(Account user) async {
    await collection.insertMany([user.toJson()]);
    await loadData();
  }

  static loadData() async {
    accounts=[];
    await collection.find().forEach((user)=>
    accounts.add(Account.fromJson(user))
    );
    await loadMyAcc();
    for (var i = 0; i < myAcc.info.chattingPersons.length; i++){
      var cursor = await collection.find(where.eq('username', myAcc.info.chattingPersons[i]));
      var documents = await cursor.toList();
      chattingPersons.add(Account.fromJson(documents[0]));
    }
  }

  static Account searchData(String a){
    accounts=[];
    collection.find().forEach((user)=>accounts.add(Account.fromJson(user)));
    // print(Type(collection.find(where.eq("username", a)).toList()))
    return accounts[0]; 
  }

  static updateInfo(String username,Person info) async {
    await collection.updateOne(where.eq('username', username), modify.set('info', info.toJson()));
  }

  static delete(String username) async {
    await collection.remove(where.eq('username',username));
  }

  static loadMyAcc() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString(MyAccount.username)??'';
    if(username!=''){
      var cursor = await collection.find(where.eq('username', username));
      var documents = await cursor.toList();
      try{
      myAcc=Account.fromJson(documents[0]);
      }catch (e){
       myAcc=Account();
      }
    }
  }  

}