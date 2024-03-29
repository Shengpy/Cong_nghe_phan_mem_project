
import 'package:flutter_application_1/class/database.dart';

import '../class/Account.dart';
import '/pages/friend_profile.dart';
import 'package:flutter/material.dart';
import '../components/styles.dart' as style;

var height = AppBar().preferredSize.height;

class Likes extends StatefulWidget {
  static const String id = 'likes';
  
  
  const Likes({Key? key}) : super(key: key);

  @override
  LikesState createState() => LikesState();
}

class LikesState extends State<Likes> {
  int tabID = 1;
  List<Account> favoritesUsers = [];

  @override
  void initState() {
    super.initState();
    getFavoriteUsers();
  }

  void getFavoriteUsers(){
    List<Account> accounts=MongoDatabase.accounts;
    for (var i = 0; i < accounts.length; i++){
      if(MongoDatabase.myAcc.info.myFavorites.contains(accounts[i].username)){
        favoritesUsers.add(accounts[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Likes',
          style: TextStyle(color: style.appColor, fontFamily: "semi-bold"),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: List.generate(favoritesUsers.length, (index) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: bottomBorder(),
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FriendProfile(personInfo: favoritesUsers[index])));
                      },
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 25,
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: ClipOval(child: Image.asset(favoritesUsers[index].info.image)),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.only(left: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(favoritesUsers[index].info.name,
                                    style: const TextStyle(
                                        fontFamily: "semi-bold", fontSize: 16)),
                                const Padding(
                                  padding: EdgeInsets.only(top: 3),
                                  child: Text('Click to see more info',
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12)),
                                ),
                              ],
                            ),
                          )),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text('1d',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  bottomBorder() {
    return const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey)));
  }
}
