import 'dart:math';
import 'package:flutter/material.dart';
import 'package:danceframe_et/widgets/DanceframeAppBar.dart';
import 'package:danceframe_et/widgets/DanceframeFormContainerPhoto.dart';
import 'package:danceframe_et/widgets/linear_percent_indicator.dart';
import 'package:danceframe_et/widgets/DanceFramePageSelector.dart';
import 'package:danceframe_et/model/Heat.dart';
import 'package:danceframe_et/widgets/CritiqueForm1.dart';
import 'critique_sheet_2.dart' as crit2;
import 'package:danceframe_et/widgets/Painter.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';
import 'package:danceframe_et/widgets/DanceFrameFooter.dart';
import 'package:danceframe_et/util/LoadContent.dart';
import 'package:danceframe_et/widgets/LoadingIndicator.dart';
import 'package:danceframe_et/util/Preferences.dart';
import 'package:danceframe_et/util/LoadContent.dart';
import 'package:auto_size_text/auto_size_text.dart';

var judge;
var heats;
var idx;

class critique_sheet_1 extends StatefulWidget {
  @override
  _critique_sheet_1State createState() => new _critique_sheet_1State();
}

class _critique_sheet_1State extends State<critique_sheet_1> {

  final pageSelectorKey = new GlobalKey<PageSelectorState>();
  var _random;
  HeatInfo heat_info;
  bool _isLoading = false;
  var fileTech, fileMusic, fileFeedback, filePres, filePartner;

  PainterController techniqueP_1;
  PainterController feedbackP_1;
  PainterController musicalityP_1;
  PainterController presentationP_1;
  PainterController partneringP_1;

  PainterController techniqueP_2;
  PainterController feedbackP_2;
  PainterController musicalityP_2;
  PainterController presentationP_2;
  PainterController partneringP_2;

  bool isC1Submitted = false;
  bool isC2Submitted = false;

  @override
  void initState() {
    print("key---" +pageSelectorKey.toString());
    super.initState();
    _random = new Random();

    if(idx == null) {
      Preferences.getSharedValue("idx").then((val){
        if(val != null) {
          idx = int.parse(val);
        }
        else {
          idx = 0;
        }

        loadHeatInfo();
      });
    } else {
      loadHeatInfo();
    }

    techniqueP_1 = _newController();
    musicalityP_1 = _newController();
    feedbackP_1 = _newController();
    presentationP_1 = _newController();
    partneringP_1 = _newController();

    techniqueP_2 = _newController();
    musicalityP_2 = _newController();
    feedbackP_2 = _newController();
    presentationP_2 = _newController();
    partneringP_2 = _newController();
  }

  int next(int min, int max) => min + _random.nextInt(max - min);

  loadHeatInfo() {
    if(heats != null) {
      print("idx: $idx HEATS[idx]: ${heats[idx].toMap()}");
      /*HeatDao.getHeatInfoById(heats[idx].id.toString()).then((val){
        setState(() {
          print("val = ${val.toMap()}");
          print("assignedcouple length: ${val.assignedCouple.length}");
          heat_info = val;
        });
      });*/
      //heat_info = heats[idx];
      heat_info = null;
    }

    print("PeopleID: ${judge.id}");
    LoadContent.loadHeatInfoById(heats[idx].id, judge.id, context).then((_heatInfo){
      setState(() {
        if(_heatInfo != null) {
          heat_info = _heatInfo;
        } else {
          heat_info = null;
        }
      });
    });
  }

  PainterController _newController() {
    PainterController controller = new PainterController();

    controller.thickness = 2.0;

    controller.backgroundColor = Colors.white;
    return controller;
  }

  String generateFilename(coupleName, componentTitle) {
    String filename = "${judge.first_name}_${judge.last_name}_heat${heat_info.heat_number}_couple${coupleName}";
    return "${filename}_${componentTitle}";
  }

  Future finishImages(assignedCouple ,entryId, PainterController tech,
      PainterController music,
  PainterController feedback,
      PainterController pres,
  PainterController partner,
      tech_f, music_f, feedback_f, pres_f, partner_f) async {
    print("ENTRY ID[${entryId}]");
    if(tech_f == null) {
      tech_f = generateFilename(assignedCouple, "technique");
    }
    await tech.finish(tech_f);
    fileTech = await tech.getImageFile(tech_f);
    if(music_f == null) {
      music_f = generateFilename(assignedCouple, "musicality");
    }
    await music.finish(music_f);
    fileMusic = await music.getImageFile(music_f);
    if(feedback_f == null) {
      feedback_f = generateFilename(assignedCouple, "feedback");
    }
    await feedback.finish(feedback_f);
    fileFeedback = await feedback.getImageFile(feedback_f);
    if(pres_f == null) {
      pres_f = generateFilename(assignedCouple, "presentation");
    }
    await pres.finish(pres_f);
    filePres = await pres.getImageFile(pres_f);
    if(partner_f == null) {
      partner_f = generateFilename(assignedCouple, "partnering");
    }
    await partner.finish(partner_f);
    filePartner = await partner.getImageFile(partner_f);
  }

  Future saveAndSubmit(entryId) async {
    if(fileTech != null && fileMusic != null && fileFeedback != null && filePres != null && filePartner != null) {
      // send to HTTP
      var imgTech = await LoadContent.uploadImg(context, fileTech);
      var imgMusic = await LoadContent.uploadImg(context, fileMusic);
      var imgFeed = await LoadContent.uploadImg(context, fileFeedback);
      var imgPres = await LoadContent.uploadImg(context, filePres);
      var imgPartner = await LoadContent.uploadImg(context, filePartner);

      LoadContent.sendCritique(context, {
        "entryId": entryId,
        "peopleId": judge.id,
        "heatId": heat_info.id,
        "technique": int.parse(imgTech),
        "music": int.parse(imgMusic),
        "partnering": int.parse(imgPartner),
        "presentation": int.parse(imgPres),
        "feeback": int.parse(imgFeed),
        "initial": 7,
        "done": "true"
      });
    }
    else {
      print("Tech: $fileTech");
      print("Music: $fileMusic");
      print("Feed: $fileFeedback");
      print("Pres: $filePres");
      print("Partner: $filePartner");
      ScreenUtil.showMainFrameDialog(context, "Processing", "An error occurred during the process. Please press Done again.");
    }
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new DanceframeAppBar(
          height: 100.0,
          mode: "TITLE",
          bg: true,
          hasBorder: false,
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
                child: new DanceframeFormContainer(
                    alignment: Alignment.topLeft,
                    flex: 2.5,
                    background: Colors.white,
                    headingText: "Judge : ${(judge != null) ? "${judge.first_name.toUpperCase()} ${judge.last_name.toUpperCase()}" : ""} ",
                    child: (heat_info == null) ? Container(child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[CircularProgressIndicator(), Container(padding: EdgeInsets.only(left: 10.0), child: Text("LOADING..."))]))) : new Container(
                      margin: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20.0, top: 10.0),
                      //color: Colors.amber,
                      child: new Column(
                        children: <Widget>[
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: 600.0,
                                  child: new AutoSizeText("${heat_info?.heat_number}: ${heat_info?.heat_title}", style: new TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w700
                                ), maxLines: 1, textAlign: TextAlign.left),
                              ),
                              Container(
                                  child: new Padding(
                                    padding: EdgeInsets.only(top: 15.0, bottom: 10.0, left: 0.0),
                                    child: new LinearPercentIndicator(
                                      width: 350.0,
                                      animation: true,
                                      lineHeight: 12.0,
                                      animationDuration: 2500,
                                      percent: 1,
                                      linearStrokeCap: LinearStrokeCap.roundAll,
                                      progressColor: Colors.lightGreenAccent,
                                    )
                                ),
                              ),
                            ],
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 0.0, bottom: 5.0),
                            child: new Divider(
                              color: Colors.grey,
                            ),
                          ),
                          new Row(
                            children: <Widget>[
                              new Text("For this you have been assigned ${(heat_info?.assignedCouple.length < 2) ? "1": "2"} Critique Sheets", style: new TextStyle(
                                fontSize: 24.0,
                              )),
                            ],
                          ),
                          new Padding(padding: EdgeInsets.only(top: 20.0)),
                          new Expanded(
                              child: new PageSelector(
                                key: pageSelectorKey,
                                pageWidgets: [
                                  new PageSelectData(
                                      tabName: 'Couple ${(heat_info.assignedCouple[0].indexOf("-") <= 0) ? heat_info.assignedCouple[0] : heat_info.assignedCouple[0].substring(0, heat_info.assignedCouple[0].indexOf("-"))}',
                                      description: '${(heat_info.danceSubheatLevels != null && heat_info.danceSubheatLevels[0] != null) ? heat_info.danceSubheatLevels[0] : ""}',
                                      demoWidget: new CritiqueForm1(
                                        rng: next(0, 4),
                                        isSubmitted: isC1Submitted,
                                        heat_info: heat_info,
                                        judge: judge,
                                        coupleName: "${heat_info.assignedCouple[0]}",
                                        categoryType: '${(heat_info.danceSubheatLevels != null && heat_info.danceSubheatLevels[0] != null) ? heat_info.danceSubheatLevels[0] : ""}',
                                        donePressed: (tech_f, music_f, feedback_f, pres_f, partner_f, rng){
                                        
                                          finishImages(heat_info.assignedCouple[0], heat_info.entries[0], techniqueP_1,
                                              musicalityP_1, feedbackP_1, presentationP_1, partneringP_1,
                                              tech_f, music_f, feedback_f, pres_f, partner_f).then((val){

                                            // save images and submit critique
                                            MainFrameLoadingIndicator.showLoading(context);
                                            saveAndSubmit(heat_info.entries[0]).then((val){
                                              MainFrameLoadingIndicator.hideLoading(context);
                                              print('tete');
                                              if(heat_info?.assignedCouple.length < 2) {
                                                isC2Submitted = true;
                                              }

                                              if(isC2Submitted && !isC1Submitted) {
                                                if(heat_info.assignedCouple.length < 2){

                                                }    
                                            
                                                  // proceed to next heat
                                                if (heats != null &&
                                                    (idx + 1) < heats.length) {
                                                  idx += 1;
                                                  Preferences.setSharedValue("idx", idx.toString());
                                                  var _heat = heats[idx];
                                                  if (_heat.critiqueSheetType !=
                                                      2) {
                                                    crit2.judge = judge;
                                                    crit2.idx = idx;
                                                    crit2.heats = heats;
                                                    Navigator.popAndPushNamed(
                                                        context, "/critique2");
                                                  } else {
                                                    Navigator.popAndPushNamed(
                                                        context, "/critique1");
                                                  }
                                                }
                                                else {
                                                  // DONE screen
                                                  //ScreenUtil.showMainFrameDialog(context, "Critique Form Done", "Please inform event coordinator. Thanks");
                                                  Navigator.pushNamed(
                                                      context, "/critiqueDone");
                                                } 
                                              } else { 
                                                // go to next critique sheet
                                                pageSelectorKey.currentState.handleArrowButtonPress(1);
                                                setState(() {
                                                  isC1Submitted = true;
                                                });
                                              }
                                            });
                                          });
                                        },
                                        techniqueP: techniqueP_1,
                                        feedbackP: feedbackP_1,
                                        musicalityP: musicalityP_1,
                                        partneringP: partneringP_1,
                                        presentationP: presentationP_1,
                                        ),
                                      loadMoreCallback: (){}
                                  ),
                                  (heat_info.assignedCouple.length < 2) ? new PageSelectData(
                                    tabName: "[Empty]",
                                    description: '',
                                    demoWidget: Container(),
                                    loadMoreCallback: (){}
                                  )
                                    : new PageSelectData(
                                      tabName: 'Couple ${(heat_info.assignedCouple[1].indexOf("-") <= 0) ? heat_info.assignedCouple[1] : heat_info.assignedCouple[1].substring(0, heat_info.assignedCouple[1].indexOf("-"))}',
                                      description: '${(heat_info.danceSubheatLevels != null && heat_info.danceSubheatLevels.length > 1) ? heat_info.danceSubheatLevels[1] : ""}',
                                      //demoWidget: _buildTabContents("576", _techniquePainter2, _musicalityPainter2, _partneringPainter2, _presentationPainter2, _feedbackPainter2),
                                      demoWidget: new CritiqueForm1(
                                        rng: next(0, 4),
                                        isSubmitted: isC2Submitted,
                                        heat_info: heat_info,
                                        judge: judge,
                                        coupleName: "${heat_info.assignedCouple[1]}",
                                        categoryType: '${(heat_info.danceSubheatLevels != null && heat_info.danceSubheatLevels.length > 1) ? heat_info.danceSubheatLevels[1] : ""}',
                                        donePressed: (tech_f, music_f, feedback_f, pres_f, partner_f, rng){
                                          finishImages(heat_info.assignedCouple[1], heat_info.entries[1], techniqueP_2,
                                          musicalityP_2, feedbackP_2, presentationP_2, partneringP_2,
                                          tech_f, music_f, feedback_f, pres_f, partner_f).then((val){

                                            // save images and submit critique
                                            MainFrameLoadingIndicator.showLoading(context);
                                            saveAndSubmit(heat_info.entries[1]).then((val){
                                              MainFrameLoadingIndicator.hideLoading(context);
                                              if(!isC2Submitted && isC1Submitted) {
                                                // proceed to next heat
                                                if (heats != null &&
                                                    (idx + 1) < heats.length) {
                                                  idx += 1;
                                                  Preferences.setSharedValue("idx", idx.toString());
                                                  var _heat = heats[idx];
                                                  if (_heat.critiqueSheetType !=
                                                      2) {
                                                    crit2.judge = judge;
                                                    crit2.idx = idx;
                                                    crit2.heats = heats;
                                                    Navigator.popAndPushNamed(
                                                        context, "/critique2");
                                                  } else {
                                                    Navigator.popAndPushNamed(
                                                        context, "/critique1");
                                                  }
                                                }
                                                else {
                                                  // DONE screen
                                                  //ScreenUtil.showMainFrameDialog(context, "Critique Form Done", "Please inform event coordinator. Thanks");
                                                  Navigator.pushNamed(
                                                      context, "/critiqueDone");
                                                }
                                              } else {
                                                setState(() {
                                                  isC2Submitted = true;
                                                });
                                              }
                                            });
                                          });
                                        },
                                        techniqueP: techniqueP_2,
                                        musicalityP: musicalityP_2,
                                        presentationP: presentationP_2,
                                        partneringP: partneringP_2,
                                        feedbackP: feedbackP_2,
                                      ),
                                      loadMoreCallback: (){}
                                  )
                                ],
                              )
                          )
                        ],
                      ),
                    )
                ),
              ),
              new DanceFrameFooter()
            ],
          ),
        )
    );
  }
}