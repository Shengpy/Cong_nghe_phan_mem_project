// ignore_for_file: constant_identifier_names
  
import 'dart:developer';

import 'package:flutter_application_1/class/Account.dart';
import 'package:mongo_dart/mongo_dart.dart';

const MONGO_URL="mongodb+srv://kysheng12345:Sheng12345@cluster0.to3nj7r.mongodb.net/?retryWrites=true&w=majority";
const COLLECTION_NAME="user";
class MongoDatabase{
  static dynamic db;
  static dynamic collection;
  static List<Account> accounts=[];
  
  static connect() async{
    db= await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    collection = db.collection(COLLECTION_NAME);
    collection.find().forEach((user)=>print(user));
    loadData();
  }

  static insert(Account user) async {
    await collection.insertMany([user.toJson()]);
    loadData();
  }

  static loadData() async {
    accounts=[];
    await collection.find().forEach((user)=>
    accounts.add(Account.fromJson(user))
    );
  }

  static Account searchData(String a){
    accounts=[];
    collection.find().forEach((user)=>accounts.add(Account.fromJson(user)));
    // print(Type(collection.find(where.eq("username", a)).toList()))
    return accounts[0]; 
  }

  static updateInfo(String username,String field,String result) async {
    collection.updateOne(where.eq('username', username), modify.set(field, result));
  }

  // static delete(Account user) async {
  //   await userCollection.remove(where.id(user.id));
  // }
}