import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/screens/change_device_mode.dart';
import 'package:danceframe_et/model/config/TimeOutConfig.dart';
import 'package:danceframe_et/widgets/LoadingIndicator.dart';
import 'package:danceframe_et/util/LoadContent.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'package:danceframe_et/util/Preferences.dart';

class Global3ControlPanel extends StatefulWidget {
  @override
  _Global3ControlPanelState createState() => new _Global3ControlPanelState();
}

class _Global3ControlPanelState extends State<Global3ControlPanel> {

  TextEditingController emceeTxtController        = new TextEditingController();
  TextEditingController chairmanTxtController     = new TextEditingController();
  TextEditingController deckCaptainTxtController  = new TextEditingController();
  TextEditingController judgeTxtController        = new TextEditingController();
  TextEditingController registrarTxtController    = new TextEditingController();
  TextEditingController scrutineerTxtController   = new TextEditingController();
  TextEditingController photosTxtController       = new TextEditingController();
  TextEditingController hmuTxtController          = new TextEditingController();
  TextEditingController adminTxtController        = new TextEditingController();

  Map<String,TextEditingController> _global3TextControllers = {};

  var stringListReturnedFromApiCall = ["first", "second", "third", "fourth", "..."];
  Map<String,TextEditingController> textEditingControllers = {};
  var textFields = <TextField>[];

  List<Map<String,dynamic>> profileTypes = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addprofileList();
    _checkGlobal3isSaved();
  }

  void addprofileList(){

    //profiles list
    //types = name
    //enabled = for checkbox value
    //val = for value of each profile type

    profileTypes.addAll(
        [
          {
            "jobType" : "Emcee",
            "enabled" : true ,
            "timeoutVal" : "",
            "controller" : emceeTxtController
          },
          {
            "jobType" :
            "Chairman of Judges",
            "enabled" : true ,
            "timeoutVal" : "",
            "controller" : chairmanTxtController
          },
          {
            "jobType" : "Deck Captain",
            "enabled" : true ,
            "timeoutVal" : "",
            "controller" : deckCaptainTxtController
          },
          {
            "jobType" : "Judge",
            "enabled" : true ,
            "timeoutVal" : "",
            "controller" : judgeTxtController
          },
          {
            "jobType" : "Registrar",
            "enabled" : true ,
            "timeoutVal" : "",
            "controller" : registrarTxtController
          },
          {
            "jobType" : "Scrutineer",
            "enabled" : true ,
            "timeoutVal" : "",
            "controller" : scrutineerTxtController
          },
          {
            "jobType" : "Photos/Videos",
            "enabled" : true ,
            "timeoutVal" : "",
            "controller" : photosTxtController
          },
          {
            "jobType" : "Hair/Make Up",
            "enabled" : true ,
            "timeoutVal" : "",
            "controller" : hmuTxtController
          },
          {
            "jobType" : "Administrator",
            "enabled" : true ,
            "timeoutVal" : "",
            "controller" : adminTxtController
          },
        ]
    );
    print(profileTypes[0]["controller"]);
    print("_____________________");
  }

  _checkGlobal3isSaved() async{
    for (var i = 0; i < profileTypes.length; i++) {
      print("----------------------------------------");
      String savedTypes = await Preferences.getSharedValue(profileTypes[i]['jobType']);
      if(savedTypes != null){
        var arr = savedTypes.split(",");
        var enabled = arr[0].split(":")[1];
        var timeOutVal = arr[1].split(":")[1];
        profileTypes[i]['timeoutVal'] = timeOutVal;
        // setState(() {
        //   _global3TextControllers[profileTypes[i]["jobType"]].text = profileTypes[i]['timeoutVal'];
        // });
        TextEditingController profileController = profileTypes[i]['controller'];
        profileController.text = timeOutVal;
        if(enabled == "true")
          profileTypes[i]['enabled'] = true;
        else
          profileTypes[i]['enabled'] = false;
      }
    }
  }

  _saveGlobal3(){
    //saved all values in the map
    bool saveGlobal3 = false;
    TimeOutConfig().list.clear();
    setState(() {
      for (var i = 0; i < profileTypes.length; i++) {
        if(profileTypes[i]["timeoutVal"] == ""){
          ScreenUtil.showMainFrameDialog(
// context, "Invalid", "Please Fill in " + profileTypes[i]['jobType'] + " Field");
              context, "Invalid", "Please Fill up all the missing Field/s.");
          saveGlobal3 = false;
          break;
        }
        else{
          saveGlobal3 = true;
        }
      }
    });
    if(saveGlobal3){

      MainFrameLoadingIndicator.showLoading(context);
      for (var i = 0; i < profileTypes.length; i++) {
        //local save
        Preferences.setSharedValue(profileTypes[i]['jobType'], "enabled:" + profileTypes[i]['enabled'].toString() + ",timeoutVal:" + profileTypes[i]['timeoutVal']);

        //store and save using api
        TimeOutConfig().getJobType(profileTypes[i]['jobType']);
        TimeOutConfig().getTimeOutValue(profileTypes[i]['timeoutVal']);
        TimeOutConfig().getEnabled(profileTypes[i]['enabled']);
        //append every values to the timeout list
        TimeOutConfig().list.add(
            {
              "jobType": TimeOutConfig().jobType,
              "timeoutVal": TimeOutConfig().timeOutVal,
              "enabled": TimeOutConfig().enabled,
            }
        );
      }
      // Save
      LoadContent.saveTimeoutConfig(context).then((val){
        //check if the future bool returns true - success
        if(val) {
          ScreenUtil.showMainFrameDialog(context, "Save Success", "Timeout info saved. Press OK.").then((val){
            Navigator.maybePop(context);
            setState(() {
              _checkGlobal3isSaved();
            });
          });
        }
        else{
          ScreenUtil.showMainFrameDialog(context, "Save Failed", "Empty RPI IP'S").then((val){
            Navigator.maybePop(context);
          });
        }
      });
    }
  }

  _discardGlobal3() async {
    MainFrameLoadingIndicator.showLoading(context);
    setState(() {
      _checkGlobal3isSaved();
      Future.delayed(Duration(seconds: 1), (){
        ScreenUtil.showMainFrameDialog(context, "Changes Discarded", "").then((value) {
          MainFrameLoadingIndicator.hideLoading(context);
        });
      });
    });
  }

  @override
  void dispose() {
    //dispose all global 3 text controller
    for (var i = 0; i < profileTypes.length; i++) {
      TextEditingController  textEditingController  = profileTypes[i]["controller"];
      textEditingController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    stringListReturnedFromApiCall.forEach((str) {
      var textEditingController = new TextEditingController(text: str);
      textEditingControllers.putIfAbsent(str, ()=>textEditingController);
      return textFields.add( TextField(controller: textEditingController));
    });

    List<TableRow> tableRows = [];

    tableRows.addAll(
      [TableRow(
        children: [
          SizedBox(),
          Container(
              child: Text("Enabled", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))
          ),
          Container(
              child: Text("Screen Timeout", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))
          ),
        ]
      ),
      TableRow(
          children: [
            Padding(padding: EdgeInsets.only(top: 20.0)),
            SizedBox(),
            SizedBox()
          ]
      )]
    );

    int alternate = 0;
    profileTypes.forEach((element) {
      //element.forEach((key, value) {
        Color containerColor = Color(0xffE9F1F4);
        if(alternate != 0) {
          containerColor = Colors.white;
          alternate = 0;
        }
        else {
          containerColor = Color(0xffE9F1F4);
          alternate = 1;
        }
        tableRows.add(
          TableRow(
            decoration: BoxDecoration(
              color: containerColor
            ),
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 15.0),
                constraints: BoxConstraints(
                  minHeight: 80.0
                ),
                child: Text(element["jobType"].toString(), style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w600))
              ),
              InkWell(
                onTap: (){
                  setState(() {
                    element["enabled"] = element["enabled"] == true ? false : true; //change enable value of checkbox
                  });
                },
                child: Container(
                    width: 120.0,
                    child: Icon(
                        element["enabled"] == true //change icon value of checkbox
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        size: 28.0
                    )
                ),
              ),
              Container(
                //color: Colors.blue,
                width: 200.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 70.0,
                      child: TextFormField(
                        controller: element["controller"],
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                          labelStyle: TextStyle(fontSize: 28.0, color: Color(0xff5b5b5b), fontWeight: FontWeight.w600),
                          border: OutlineInputBorder(),
                        ),
                        inputFormatters: [
                          WhitelistingTextInputFormatter(new RegExp(r'[0-9]'))
                        ],
                        onChanged: (val){
                          setState(() {
                            element["timeoutVal"] = val;
                          });
                        },
                        style: TextStyle(fontSize: 26.0),
                      )
                    ),
                    Padding(padding: EdgeInsets.only(left: 5.0), child: Text("min", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600)))
                  ],
                )
              ),
            ]
          )
        );
      //});
    });

    return Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(child: Text("PROFILE TYPES", style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700))),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: FractionColumnWidth(0.6),
                  1: FractionColumnWidth(0.15),
                  2: FractionColumnWidth(0.25),
                },
                children: tableRows,
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              change_device_mode.isEditMode == false
                  ? Container()
                  : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new DanceFrameButton(
                    text: "EXIT",
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  new DanceFrameButton(
                    text: "DISCARD",
                    onPressed: (){
                      _discardGlobal3();
                    },
                  ),
                  Padding(padding: EdgeInsets.only(left: 10.0)),
                  new DanceFrameButton(
                    text: "SAVE",
                    onPressed: (){
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _saveGlobal3();
                    },
                  ),
                ],
              )
            ]
        )
    );
  }
}