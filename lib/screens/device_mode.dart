import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:danceframe_et/widgets/DanceFrameFooter.dart';
import 'package:danceframe_et/model/Person.dart';
import 'package:danceframe_et/model/Judge.dart';
import 'package:danceframe_et/enums/UserProfiles.dart';
import 'package:danceframe_et/dao/PersonDao.dart';
import 'package:danceframe_et/dao/HeatDao.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'critique_sheet_1.dart' as crit1;
import 'critique_sheet_2.dart' as crit2;

Person p;

class device_mode extends StatefulWidget {
  @override
  _device_modeState createState() => new _device_modeState();
}

class _device_modeState extends State<device_mode> {
  List<UserProfiles> user_profs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Preferences.setSharedValue("currentScreen", "deviceMode");

    if(p != null) {
      setState(() {
        user_profs = p.user_roles;
        print("P: ${p.toMap()}");
      });
    }
  }

  List<Widget> buildMenuButton(String img, Function p) {
    return <Widget>[
      new InkWell(
        onTap: p,
        child: Image.asset(img, height: 90.0),
      ),
      new Padding(padding: const EdgeInsets.only(top: 5.0))
    ];
  }

  void onTapHeatlistPanel() {
    Navigator.pushNamed(context, "/heatlistPanel");
  }

  void onTapJudge() {
    //Navigator.pushNamed(context, "/personaliseDevice");
    print("PERSON: ${p.toString()}");
    print("isNull: ${p.initials == null}");
    if(p.initials == null) {
      // setup initials
      Navigator.pushNamed(context, "/signingInitials");
    }
    else {
      /*PersonDao.getPersonByName("Sammy", "Field").then((judge){
        print("Judge: ${judge.toMap()}");
        HeatDao.getHeatsByJudge(judge.id).then((heats){
          print("heat length: ${heats.length}");
          for(var heat in heats) {
            print(heat.toMap());
          }
          if(heats != null) {
            var _heat = heats[0];
            Judge _temp = new Judge();
            _temp.initials = judge.initials;
            _temp.gender = judge.gender;
            _temp.last_name = judge.last_name;
            _temp.first_name = judge.first_name;
            if(_heat.critiqueSheetType != 1) {
              crit2.judge = _temp;
              crit2.heats = heats;
              Navigator.popAndPushNamed(context, "/critique2");
            } else {
              crit1.judge = _temp;
              crit1.heats = heats;
              Navigator.popAndPushNamed(context, "/critique1");
            }
          }
          else {
            // DONE screen
            ScreenUtil.showMainFrameDialog(context, "No Critique Sheets", "No Critique Sheets assigned for this Judge. Please inform event coordinator. Thanks");
          }
        });
      });*/
      HeatDao.getHeatsByJudge_pi(p.id).then((heats){
        print("heat length: ${heats?.length}");
        /*if(heats != null) {
          for (var heat in heats) {
            print(heat.toMap());
          }
        }*/
        // HeatInfo returned
        if(heats != null) {
          var _heat = heats.first;
          Judge _temp = new Judge();
          _temp.id = p.id;
          _temp.initials = p.initials;
          _temp.gender = p.gender;
          _temp.last_name = p.last_name;
          _temp.first_name = p.first_name;
          print("CRITIQUE TYPE: ${_heat.critiqueSheetType}");
          if(_heat.critiqueSheetType != 2) {
            crit2.judge = _temp;
            List _list = [];
            _list.addAll(heats);
            crit2.heats = _list;
            Navigator.popAndPushNamed(context, "/critique2");
          } else {
            crit1.judge = _temp;
            List _list = [];
            _list.addAll(heats);
            crit1.heats = _list;
            Navigator.popAndPushNamed(context, "/critique1");
          }
        }
        else {
          // DONE screen
          ScreenUtil.showMainFrameDialog(context, "No Critique Sheets", "No Critique Sheets assigned for this Judge. Please inform event coordinator. Thanks").then((val){
            Navigator.popUntil(context, ModalRoute.withName("/deviceMode"));
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];
    _children.add(new Padding(padding: const EdgeInsets.only(top: 20.0)));
    if(p.user_roles.contains(UserProfiles.EMCEE)) {
      _children.addAll(buildMenuButton("assets/images/Asset_10_4x.png", () => onTapHeatlistPanel()));
    }
    if(p.user_roles.contains(UserProfiles.CHAIRMAN_OF_JUDGES)) {
      _children.addAll(buildMenuButton("assets/images/Asset_9_4x.png", () => onTapHeatlistPanel()));
    }
    if(p.user_roles.contains(UserProfiles.DECK_CAPTAIN)) {
      _children.addAll(buildMenuButton("assets/images/Asset_8_4x.png", () => onTapHeatlistPanel()));
    }
    if(p.user_roles.contains(UserProfiles.JUDGE)) {
      _children.addAll(buildMenuButton("assets/images/Asset_7_4x.png", () => onTapJudge()));
    }
    if(p.user_roles.contains(UserProfiles.SCRUTINEER)) {
      _children.addAll(buildMenuButton("assets/images/Asset_5_4x.png", () => onTapHeatlistPanel()));
    }
    if(p.user_roles.contains(UserProfiles.REGISTRAR)) {
      _children.addAll(buildMenuButton("assets/images/Asset_6_4x.png", () => onTapHeatlistPanel()));
    }
    // //add roles 
    // List<UserProfiles> newUserRolesList;   
    // if(p.user_roles != null) 
    // {
    //   newUserRolesList = p.user_roles.toSet().toList(); // delete duplicates and assign to new list
    //   _children.add( //add to the children list
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         new Column( 
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: newUserRolesList != null 
    //             ? List.generate(newUserRolesList.length, (index){ 
    //               return  Padding(
    //               padding: EdgeInsets.symmetric(vertical: 20),
    //               child: Text(
    //                 newUserRolesList[index].toString().replaceAll("UserProfiles.", "").replaceAll("_", " "), 
    //                 style: TextStyle(
    //                   fontSize: 40.0, 
    //                   fontWeight: FontWeight.w600
    //                   )
    //                 )
    //               );
    //             }) 
    //             : [
    //               Container()
    //             ]  
    //         ),
    //       ],
    //     )
    //   );
    // } 
    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 150.0,
          mode: "TITLE",
          headerText: "SELECT ACTION MODE",
          bg: true,
        ),
        body: new Container(
          decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: [new Color(0xFFD6DFDE), Colors.white],
                  //colors: [Colors.red, Colors.blue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.01, 0.5]
              )
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Expanded(
                child: new SizedBox(
                  child: new Container(
                    //color: Colors.amber,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      /*children: <Widget>[
                        new Padding(padding: const EdgeInsets.only(top: 20.0)),
                        new InkWell(
                          onTap: () {},
                          child: Image.asset("assets/images/Asset_10_4x.png", height: 90.0),
                        ),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Image.asset("assets/images/Asset_9_4x.png", height: 90.0),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Image.asset("assets/images/Asset_8_4x.png", height: 90.0),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        new InkWell(
                          onTap: () => Navigator.pushNamed(context, "/personaliseDevice"),
                          child: Image.asset("assets/images/Asset_7_4x.png", height: 90.0)
                        ),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Image.asset("assets/images/Asset_6_4x.png", height: 90.0),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Image.asset("assets/images/Asset_5_4x.png", height: 90.0),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                        Image.asset("assets/images/Asset_4_4x.png", height: 90.0),
                        new Padding(padding: const EdgeInsets.only(top: 5.0)),
                                  Image.asset("assets/images/Asset_3_4x.png", height: 90.0),
                      ],*/
                      children: _children,
                    ),
                  ),
                ),
                //child: new Container(),
              ),
              new DanceFrameFooter()
            ],
          ),
        )
    );
  }
}