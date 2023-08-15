import 'package:flutter_application_1/class/database.dart';

import 'package:firebase_core/firebase_core.dart';
import '/pages/login/login.dart';
import '/pages/myprofile.dart';
// import 'pages/login/verification.dart';
import 'package:flutter/material.dart';
import '/pages/home.dart';
import '/pages/tabs.dart';
import '/pages/profile.dart';
import '/pages/likes.dart';
import '/pages/inbox.dart';
import '/pages/notification.dart';
import '/pages/Filter.dart';
// import '/pages/Setting.dart';
import '/pages/EditProfile.dart';

// import '/pages/chat.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.transparent, // navigation bar color
  //   statusBarColor: Colors.black, // status bar color
  // ));
  await Firebase.initializeApp();

  await MongoDatabase.connect();

  // SharedPreferences prefs =await SharedPreferences.getInstance();
  // String username=prefs.getString(MyAccount.username)??'';
  String username='';
  runApp(DateApp(username:username));
}
class DateApp extends StatelessWidget {
  final String username;
  const DateApp({super.key,required this.username});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   fontFamily: "regular",
      //   primaryColor: style.appColor,
      //   iconTheme: const IconThemeData(color: Colors.black87),
      // ),
          theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(32, 63, 129, 1.0),
        ),
      ),
      initialRoute: username.isNotEmpty ?TabsExample.id:Login.id,
      // initialRoute:  Verification.id,
      // initialRoute:  FriendProfile.id,
      debugShowCheckedModeBanner: false,
      routes: {
        Login.id: (context) => const Login(),
        Home.id: (context) => const Home(),
        TabsExample.id: (context) => const TabsExample(),
        Profile.id: (context) => const Profile(),
        Inbox.id: (context) => const Inbox(),
        Likes.id: (context) => const Likes(),
        Notifications.id: (context) => const Notifications(),
        Filter.id: (context) => const Filter(),
        // Setting.id: (context) => const Setting(),
        EditProfile.id: (context) => const EditProfile(),
        // Chat.id: (context) => const Chat(),
        // FriendProfile.id: (context) => const FriendProfile(personInfo: MongoDatabase.myAcc.info),
        // Verification.id: (context) => const Verification(),
        MyProfile.id: (context) => const MyProfile(),
      },
    );
  }
}
