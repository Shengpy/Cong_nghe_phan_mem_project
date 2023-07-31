import 'package:flutter/material.dart';
import 'package:testhello/Account.dart';
import 'package:testhello/database.dart';

Account acc = new Account();
String username = acc.getUsername();
void main () {
  runApp(CreateProfile());
}

class CreateProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: enter_Profile(),
    );
  }
}

class enter_Profile extends StatefulWidget {
  @override
  _enter_ProfileState createState() => _enter_ProfileState();
}

class _enter_ProfileState extends State<enter_Profile> {
  String name = '';
  DateTime birthday = DateTime.now();
  String address = '';
  String phoneNumber = '';
  String education = '';
  String sexualOrentation = '';
  String describe = '';
  String gender = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("create a profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Full Name'),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              ListTile(
                title: Text('Date of Birth'),
                subtitle: Text('${birthday.toLocal()}'.split(' ')[0]),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: birthday,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null && pickedDate != birthday) {
                    setState(() {
                      birthday = pickedDate;
                    });
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'address'),
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'phone number'),
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'education'),
                onChanged: (value) {
                  setState(() {
                    education = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'sexual Orientation'),
                onChanged: (value) {
                  setState(() {
                    sexualOrentation = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'describe'),
                onChanged: (value) {
                  setState(() {
                    describe = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'gender'),
                onChanged: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  //check the validity
                  //if yes, store to db
                  Person p = Person();
                  p.set(name, birthday, address, phoneNumber, education, sexualOrentation, describe, gender);
                  MongoDatabase.updateInfo(username,p);
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
