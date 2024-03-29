
import 'package:flutter/material.dart';
import '../../components/styles.dart' as style;
import 'resetpassword.dart';

class Verification extends StatefulWidget {
  static const String id = 'Verification';

  final String email;
  const Verification({super.key,required this.email});

  @override
  VerificationState createState() => VerificationState();
}

class VerificationState extends State<Verification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.chevron_left,
              size: 30,
            ),
          ),
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black87),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(),
                child: Text(
                  'Verification Code',
                  style: TextStyle(
                      fontFamily: "bold", color: style.appColor, fontSize: 20),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: "Please enter 4-digit code sent to ",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "medium",
                            color: Colors.black54)),
                    TextSpan(
                        text: widget.email,
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "medium",
                            color: style.appColor)),
                  ]),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(48),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(first: true, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: false),
                        _textFieldOTP(first: false, last: true),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPassword(email:widget.email)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: style.appColor,
                    // onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text("Continue",),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Resend Code',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: style.appColor)),
              ),
            ],
          ),
        ));
  }

  Widget _textFieldOTP({required bool first, last}) {
    return SizedBox(
      height: 70,
      width: 60,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontFamily: "bold"),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: const InputDecoration(
            counter: Offstage(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: Colors.black12),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 2, color: style.appColor),
            ),
          ),
        ),
      ),
    );
  }
}
