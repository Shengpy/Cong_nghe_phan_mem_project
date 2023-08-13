
import 'package:flutter/material.dart';
import 'package:flutter_application_1/class/database.dart';
import 'package:intl/intl.dart';
import '../class/Account.dart';
import '../components/styles.dart' as style;

class Notification{
  String content;
  String date;
  String sender;

  Notification({this.content='',this.date='',this.sender=''});
}
class Notifications extends StatefulWidget {
  static const String id = 'Notifications';

  const Notifications({Key? key}) : super(key: key);

  @override
  NotificationsState createState() => NotificationsState();
}
DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
class NotificationsState extends State<Notifications>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    getNotification();
  }
  final List<Notification> _elements = [
    // Notification(content:'Khang want to add friend',date:formattedDate),
    // Notification(content:'You are stupid',date:formattedDate),
    // Notification(content:'You are hacked by Sheng',date:formattedDate),
  ];
  void getNotification(){
    List<Account> listAcc=[];
    for (var i = 0; i < MongoDatabase.accounts.length; i++){
      if(MongoDatabase.myAcc.info.likedMe.contains(MongoDatabase.accounts[i].username)){
        listAcc.add(MongoDatabase.accounts[i]);
      }
    }
    for (var i = 0; i < listAcc.length; i++){
      _elements.add(Notification(content:'${listAcc[i].info.name} Like you',date:formattedDate));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(color: style.appColor, fontFamily: "semi-bold"),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    return SingleChildScrollView(
      child: ListView(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        children: _elements.map((e) {
          return _buildChatModule(context,e);
        }).toList(),
      ),
    );
  }

  Widget _buildChatModule(context,Notification content) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              decoration: buildIconButton(),
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(content.content,
                      style: const TextStyle(fontFamily: "semi-bold", fontSize: 16)),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(content.date,
                        style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  textButton() {
    return const TextStyle(
        color: Colors.white, fontFamily: 'semi-bold', fontSize: 12);
  }

  buildIconButton() {
    return const BoxDecoration(
        color: style.appColor,
        borderRadius: BorderRadius.all(Radius.circular(100)));
  }
}
