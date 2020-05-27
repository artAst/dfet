import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/widgets/DanceFrameFooter.dart';
import 'package:danceframe_et/util/ConfigUtil.dart';
import 'package:danceframe_et/model/Contact.dart';
import 'package:danceframe_et/dao/ContactDao.dart';
import 'package:danceframe_et/model/config/EventConfig.dart';

class contact_us extends StatefulWidget {
  @override
  _contact_usState createState() => new _contact_usState();
}

class _contact_usState extends State<contact_us> {
  final _formKey = new GlobalKey<FormState>();
  TextEditingController fullNameCtrl = new TextEditingController();
  TextEditingController phoneCtrl = new TextEditingController();
  TextEditingController bestCtrl = new TextEditingController();
  TextEditingController eventWebCtrl = new TextEditingController();
  List<String> contact_email = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ConfigUtil.getConfig("contact_email").then((confValue){
      if(confValue != null) {
        if(confValue.toString().contains(",")) {
          List<String> emailArr = confValue.toString().split(",");

        } else {
          contact_email.add(confValue);
        }
      }
    });
  }

  Future sendNowPressed() async {
    // save contact details and send to webservice
    FormState form = _formKey.currentState;
    if(!form.validate()) {
      // have validation errors
    } else {
      for(String s in contact_email) {
        Contact c = new Contact(
            to_email: s,
            full_name: fullNameCtrl.text,
            phone: phoneCtrl.text,
            best_email: bestCtrl.text,
            event_website: eventWebCtrl.text
        );
        var id = await ContactDao.saveContact(c);
        print("id: $id");
      }
      Navigator.pushNamed(context, "/contactUsEnd").then((val){
        print("popping from contact us");
        Navigator.maybePop(context);
      });
    }
  }

  String _validateEmpty(String value) {
    if(value == null || value.isEmpty) {
      return "Field required";
    }
    return null;
  }

  String _validateEmail(String value) {
    if(value == null || value.isEmpty) {
      return "Field required";
    }

    var email = value;
    bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

    if(!emailValid) {
      return "Invalid Email";
    }

    return null;
  }

    String _validateNumber(String value) {
    if(value == null || value.isEmpty) {
      return "Field required";
    }

    var number = value;
    bool numberValid = RegExp(r"^[0-9]*$").hasMatch(number);

    if(!numberValid) {
      return "Invalid Number";
    }

    return null;
  }


  String _validateWebUrl(String value) {
    if(value == null || value.isEmpty) {
      return "Field required";
    }

    bool match = Uri.parse(value).isAbsolute;

    if(!match) {
      return "Event Website URL invalid";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double _width = mediaQuery.size.width;
    double widthPadding = _width / 4;
    double widthPadding2 = _width / 10;

    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 150.0,
          mode: "TITLE",
          bg: true,
        ),
        body: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [new Color(0xFFD6DFDE), Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.01, 0.5]
              )
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                // PUT YOUR CONTENTS HERE in Child property
                child: SingleChildScrollView( //scroll needs so when keyboard pops the textfelds adjust
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      new Container(
                        padding: EdgeInsets.only(bottom: 20.0, left: widthPadding2, right: widthPadding2),
                        child: new RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .body1
                                    .copyWith(fontSize:24.0),
                                children: [
                                  TextSpan(
                                      text: 'Competition system at the ',
                                      style: TextStyle(
                                        // fontWeight: FontWeight.w700,
                                      )
                                  ),
                                  TextSpan(
                                      text: EventConfig.eventName == null ? 'World of Dance Celebration \n': EventConfig.eventName + '\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700
                                      )
                                  ),
                                  TextSpan(
                                      text: 'provided by '
                                  ),
                                  TextSpan(
                                      text: 'DanceFrame.\n\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700
                                      )
                                  ),
                                  TextSpan(
                                      text: 'To find how we can help you work your next event, please provide your contact information and we can discuss how to make your event even awesomer.'
                                  )
                                ]
                            )
                        )
                      ),
                      new Form(
                        key: _formKey,
                        child: new Container(
                            padding: EdgeInsets.only(
                                left: widthPadding, right: widthPadding, top: 10.0),
                            child: new Column(
                                children: <Widget>[
                                  new Container(
                                    child: new TextFormField(
                                      controller: fullNameCtrl,
                                      decoration: new InputDecoration(
                                          labelText: "First Name & Last Name",
                                          labelStyle: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                                          border: OutlineInputBorder()
                                      ),
                                      style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                                      validator: _validateEmpty,
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  new Container(
                                    child: new TextFormField(
                                      controller: phoneCtrl,
                                      decoration: new InputDecoration(
                                        labelText: "Telephone",
                                        labelStyle: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                                        border: OutlineInputBorder(),
                                      ),
                                      style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                                      validator: _validateNumber, 
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  new Container(
                                    child: new TextFormField(
                                      controller: bestCtrl,
                                      decoration: new InputDecoration(
                                          labelText: "Best Email",
                                          labelStyle: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                                          border: OutlineInputBorder()
                                      ),
                                      style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                                      validator: _validateEmail,
                                    ),
                                  ),
                                  SizedBox(height: 15.0),
                                  new Container(
                                    child: new TextFormField(
                                      controller: eventWebCtrl,
                                      decoration: new InputDecoration(
                                          labelText: "Event Website",
                                          labelStyle: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                                          border: OutlineInputBorder()
                                      ),
                                      style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, color: Colors.black),
                                      validator: _validateWebUrl,
                                    ),
                                  ),
                                  SizedBox(height: 50.0),
                                  new Container(
                                    child: new Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        new DanceFrameButton(
                                          text: "Do Nothing",
                                          onPressed: () {
                                            //Navigator.pushNamed(context, "/");
                                            Navigator.maybePop(context);
                                          },
                                        ),
                                        new DanceFrameButton(
                                          text: "Send Now",
                                          onPressed: sendNowPressed,
                                        )
                                      ],
                                    ),
                                  )

                                ]
                            )
                        ),

                      )
                    ],
                  ),
                ),
              ),
              new DanceFrameFooter(isContactPage: true,)
            ],
          ),
        )
    );
  }
}