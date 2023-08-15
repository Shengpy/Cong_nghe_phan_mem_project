
import 'package:flutter/material.dart';
import 'package:flutter_application_1/class/Account.dart';
import '../components/styles.dart' as style;


class FriendProfile extends StatefulWidget {
  static const String id = 'FriendProfile';

  final Account personInfo;

  const FriendProfile({super.key,required this.personInfo});

  @override
  FriendProfileState createState() => FriendProfileState();
}

class FriendProfileState extends State<FriendProfile> {
  List<String> images = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
  ];
  // double deviceWidth;
  int tabID = 1;
  bool val1 = true;
  bool val2 = true;

  @override
  Widget build(BuildContext context) {
    // deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCarousel(),
          _hotelDesc(),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 600,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.personInfo.info.image),
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  icon: const Icon(Icons.chevron_left, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.favorite_border,
                          color: Colors.white),
                      onPressed: () {}),
                  IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {}),
                ],
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _hotelDesc() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.personInfo.info.name,
                        style: const TextStyle(fontSize: 22, fontFamily: "bold"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(widget.personInfo.info.address,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontFamily: "medium")),
                      ),
                    ],
                  )),
              Column(
                children: <Widget>[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: buildIconButton(),
                    child: Text('${widget.personInfo.info.age} years',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "semi-bold",
                          fontSize: 12,
                        )),
                  ),
        
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children:[
          const Icon(Icons.school, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.personInfo.info.job,
              style: const TextStyle(
                  fontSize: 16, color: Colors.grey, fontFamily: "medium"),
            ),
          )
            ],
          ),
          const SizedBox(height: 16),
          const InkWell(
            child: Text(
              'About',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const SizedBox(height: 5),
         Text(
              widget.personInfo.info.describe,
              style: const TextStyle(
                  fontSize: 14, color: Colors.grey, fontFamily: "medium")),
          Container(
            margin: const EdgeInsets.only(top: 20),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Gender',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Text(
                        widget.personInfo.info.gender,
                        style: const TextStyle(
                          color: style.appColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildIconButton() {
    return const BoxDecoration(
        color: style.appColor,
        borderRadius: BorderRadius.all(Radius.circular(30)));
  }
}

class Item {
  const Item(this.name, this.icn);
  final IconData icn;
  final String name;
}
