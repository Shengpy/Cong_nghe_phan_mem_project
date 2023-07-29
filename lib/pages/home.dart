
import 'package:shared_preferences/shared_preferences.dart';

import '../class/database.dart';
import '../values/loginstatus.dart';
import '/class/Account.dart';
import '/pages/login/login.dart';

import '/pages/chat.dart';
import '/pages/filter.dart';
import '/class/FilterSearch.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import '../components/styles.dart' as style;

List<String> images = [
  "assets/images/user1.jpg",
  "assets/images/user2.jpg",
  "assets/images/user3.jpg",
  "assets/images/user4.jpg",
  "assets/images/user5.jpg",
  "assets/images/user6.jpg",
  "assets/images/user7.jpg",
  "assets/images/user8.jpg",
  "assets/images/user9.jpg",
  "assets/images/user10.jpg",
  "assets/images/user11.jpg",
];

class Home extends StatefulWidget {
  static const String id = 'home';

  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final TCardController _controller = TCardController();

  // ignore: unused_field
  int _index = 0;
  late Account acc;
  late List<Widget> cards;
  List<Account> accounts=MongoDatabase.accounts;
  List<Account> filteredaccounts=[];
  Account a=Account();
  Account b=Account();
  late SharedPreferences prefs;
  @override
  void initState() {
    a.info.updateImage("assets/images/user1.jpg");
    a.info.updateGentle("Woman");
    a.info.setAge(27);
    a.info.setName('Tai');
    accounts.add(a);
    b.info.updateImage("assets/images/user2.jpg");
    b.info.updateGentle("Men");
    b.info.setAge(47);
    b.info.setName('Vinh');
    accounts.add(b);
    super.initState();
    // filter(FilterElement());
    generateCards(accounts);
    getMyAcc();
  }
  void getMyAcc()async{
    prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString(MyAccount.username);
    for (var i = 0; i < accounts.length; i++){
      if(username==accounts[i].username){
        acc=accounts[i];
      }
   }
  }
  void filter(FilterElement value) {
    filteredaccounts=[];
    if (value.gentle=='Men' || value.gentle=='Woman'){
      for (var i = 0; i < accounts.length; i++){
        if(accounts[i].info.gentle==value.gentle && accounts[i].info.age<=value.ageMax && accounts[i].info.age>= value.ageMin){
          filteredaccounts.add(accounts[i]);
        }
      }
    }
    else {
      for (var i = 0; i < accounts.length; i++){
        if(accounts[i].info.age<=value.ageMax && accounts[i].info.age>= value.ageMin){
          filteredaccounts.add(accounts[i]);
        }
      }
    }
    setState(() {
      generateCards(filteredaccounts);
      _controller.reset(cards:cards);
    });
  }
  void search(List<Account> listAcc,String findWord){
    List<Account> searchaccounts=[];
    for (var i = 0; i < listAcc.length; i++){
      if(listAcc[i].info.name.contains(findWord)){
        searchaccounts.add(listAcc[i]);
      }
    }
    setState(() {
      generateCards(searchaccounts);
      _controller.reset(cards:cards);
    });
  }
  void generateCards(List<Account> genAcc){
    if (genAcc.isEmpty){
      genAcc.add(Account());
    }
    cards = List.generate(
    genAcc.length,
    (int index) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 23.0,
              spreadRadius: -13.0,
              color: Colors.black54,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.asset(
            genAcc[index].info.image,
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.black12),
              borderRadius: BorderRadius.circular(30)),
          //--------------------------------search
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Search for match',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none),
              onChanged: (value) {
                  setState(() { 
                    search(filteredaccounts,value);
                  });
              },
            ),
            
          ),
        ),
        //----------------------------filter
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
              onPressed: () async{
                FilterElement receivedData = await Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const Filter()));
                filter(receivedData);
              },
              icon: const Icon(
                Icons.filter_alt_outlined,
                size: 30,
              ),
            ),
          ),
          //-----------------------------------log out
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
                  onPressed: () async{
                    prefs = await SharedPreferences.getInstance();
                    prefs.setString(MyAccount.username, "");
                    
                    if (!mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const Login();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.logout_rounded),
                ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TCard(
              cards: cards,
              controller: _controller,
              onForward: (index, info) {
                _index = index;
                setState(() {});
                if (info.direction == SwipDirection.Right) {
                  // acc.addPersons();
                  // ignore: avoid_print
                  print('like');
                }
                // print('forward');
              },
              onBack: (index, info) {
                _index = index;
                setState(() {});
                // print('back');
              },
              onEnd: () {
                // print('end');
              },
            ),
            const SizedBox(height: 20),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 48.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //----------------------------back button
                        FloatingActionButton(
                          onPressed: () {
                            _controller.back();
                          },
                          heroTag: 'back',
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.arrow_back_ios_new,
                              color: style.appColor, size: 30),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 40.0)),
                        //------------------------------cancel button
                        FloatingActionButton(
                          onPressed: () {
                            _controller.forward(direction:SwipDirection.Left);
                          },
                          heroTag: 'cancel',
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.close,
                              color: style.appColor, size: 30),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 40.0)),
                        //------------------------------message button
                        FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Chat()));
                          },
                          heroTag: 'message',
                          backgroundColor: Colors.white,
                          child: const Icon(Icons.message_outlined,
                              color: style.appColor, size: 30),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 40.0)),
                        //-----------------------------love button
                        FloatingActionButton(
                          onPressed: () {
                            _controller.forward(direction:SwipDirection.Right);
                          },
                          backgroundColor: Colors.white,
                          heroTag: 'like',
                          child: const Icon(Icons.favorite,
                              color: style.appColor, size: 30),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
