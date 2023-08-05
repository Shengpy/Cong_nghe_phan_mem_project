
import 'package:like_button/like_button.dart';
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
  late List<Widget> cards;
  List<Account> accounts=MongoDatabase.accounts;
  List<Account> filteredaccounts=[];
  Account a=Account();
  Account b=Account();
  Account acc=MongoDatabase.myAcc;
  late SharedPreferences prefs;
  @override
  void initState() {
    a.info.updateImage("assets/images/user1.jpg");
    a.info.updateGender("Woman");
    a.info.setAge(27);
    a.info.setName('Tai');
    accounts.add(a);
    b.info.updateImage("assets/images/user2.jpg");
    b.info.updateGender("Men");
    b.info.setAge(47);
    b.info.setName('Vinh');
    accounts.add(b);
    super.initState();
    generateCards(accounts);
    filteredaccounts=accounts;
  }

  void filter(FilterElement value) {
    filteredaccounts=[];
    if (value.gender=='Men' || value.gender=='Woman'){
      for (var i = 0; i < accounts.length; i++){
        if(accounts[i].info.gender==value.gender && accounts[i].info.age<=value.ageMax && accounts[i].info.age>= value.ageMin){
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
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
        //----------------------------reload
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
                  onPressed: () async{
                    await MongoDatabase.loadData();
                    await MongoDatabase.loadMyAcc();
                  },
                  icon: const Icon(
                    Icons.replay_circle_filled_outlined,
                    size:30
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
                  icon: const Icon(
                    Icons.logout_rounded,
                    size:30,
                  ),
                ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              child: Column(
                children: [
                  //------------------------------------------------------T card
                  TCard(
                    cards: cards,
                    controller: _controller,
                    onForward: (index, info) async{
                      String favorite=MongoDatabase.accounts[_index].username;
                      //--------------like
                      if (info.direction == SwipDirection.Right) {
                        if(!MongoDatabase.myAcc.info.myFavorites.contains(favorite)){
                          MongoDatabase.myAcc.info.myFavorites.add(favorite);
                        }
                      }
                      //-------------don't like
                      else{
                        if(MongoDatabase.myAcc.info.myFavorites.contains(favorite)){
                          MongoDatabase.myAcc.info.myFavorites.remove(favorite);
                        }                  
                      }
                      await MongoDatabase.updateInfo(MongoDatabase.myAcc.username, MongoDatabase.myAcc.info);
                      // print('forward');
                      setState(() {_index = index;});
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
                  //--------------------------------------------------------info
                  _index!=MongoDatabase.accounts.length?
                  Container(
                    height: 60,
                    width:350,
                    margin:const EdgeInsets.symmetric(vertical:0),
                    decoration: const BoxDecoration(
                      color:Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                       BoxShadow(
                         color:Colors.black38,
                         offset:Offset(2,3), 
                         blurRadius: 3,
                       )
                      ]
                    ),
                    padding: const EdgeInsets.only(top:5,left:16),
                    alignment: Alignment.topLeft,
                    child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Name: ${MongoDatabase.accounts[_index].info.name}',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          )),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Age: ${MongoDatabase.accounts[_index].info.age}',textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),                        
                          ),),
                    ],
                  ))
                  :
                  Container(
                    height: 50,
                    width:350,
                    margin:const EdgeInsets.symmetric(vertical:0),
                    // padding: const EdgeInsets.symmetric(vertical:5,horizontal: 5),
                    decoration: const BoxDecoration(
                      color:Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                       BoxShadow(
                         color:Colors.black38,
                         offset:Offset(2,3), 
                         blurRadius: 3,
                       )
                      ]
                    ),
                  ),
                ],
              ),
            ),
            //-----------------------------------------------------------
            const SizedBox(height: 20),
                Container(
                    margin: const EdgeInsets.symmetric(vertical:0),
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
                                    builder: (context) => Chat(chattingPerson:MongoDatabase.accounts[_index])));
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
                            // _controller.forward(direction:SwipDirection.Right);
                          },
                          backgroundColor: Colors.white,
                          heroTag: 'like',
                          child: LikeButton(
                            onTap:(bool isLiked)async{
                            _controller.forward(direction:SwipDirection.Right);                   
                            return !MongoDatabase.myAcc.info.myFavorites.contains(MongoDatabase.accounts[_index].username);
                            },
                            isLiked: _index!=MongoDatabase.accounts.length?
                            MongoDatabase.myAcc.info.myFavorites.contains(MongoDatabase.accounts[_index].username)
                            :false,
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
