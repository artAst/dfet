import 'package:flutter/material.dart';
import 'package:danceframe_et/util/LoadContent.dart';
import 'package:danceframe_et/model/JobPanel.dart';
import 'package:danceframe_et/widgets/CPCheckbox.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';
import 'package:danceframe_et/model/config/Global4Config.dart';
import 'package:danceframe_et/model/config/DeviceConfig.dart';
import 'package:danceframe_et/enums/AcessPermissions.dart';
import 'package:danceframe_et/enums/UserProfiles.dart';
import 'package:danceframe_et/websocket/DanceFrameCommunication.dart';

class Global4ControlPanel extends StatefulWidget {
  @override
  _Global4ControlPanelState createState() => new _Global4ControlPanelState();
}

class _Global4ControlPanelState extends State<Global4ControlPanel> {
  List<JobPanel> jPanels = [];
  List<JobPanel> defaultjPanels = [];

  // List<String> acm = [];
  // Map<String, List<String>> permissions = {};
  // List<TableRow> tableRowz;

  @override
  void initState() {
    super.initState();
    setState(() {
      jPanels = [];
      defaultjPanels = [];
      defaultjPanels = Global4Config.jobPanelCopy;
      jPanels = jobPanelCopy;
    });
    /*LoadContent.loadEventPermission(context).then((jobPanelList) {
      setState(() {
        jPanels = [];
        defaultjPanels = [];

        // for (var item in jobPanelList) {
        //   JobPanel tempJob = new JobPanel(id: item.id, description: item.description, judge: item.judge, scrutineer: item.scrutineer, emcee: item.emcee, chairman: item.chairman, deck: item.deck, registrar: item.registrar, musicDj: item.musicDj, photosVideo: item.photosVideo, hairMakeup: item.hairMakeup);
        // }
        defaultjPanels = jobPanelList;
        jPanels = jobPanelCopy;
        // defaultjPanels = jobPanelList;
        // jPanels.addAll(jobPanelList);
        print('Default Jpanel INIT: ${defaultjPanels[0].judge}');
      });

      // jPanels = jobPanelList;
      // print('test ');
      // for (var items in jPanels) {
      //   permissions.putIfAbsent(items.description, () {
      //     List<String> returnValues = [];

      //     if (items.judge) {
      //       returnValues.add('judge');
      //     }
      //     if (items.scrutiner) {
      //       returnValues.add('scrutiner');
      //     }
      //     if (items.emcee) {
      //       returnValues.add('emcee');
      //     }
      //     if (items.chairman) {
      //       returnValues.add('chairman');
      //     }
      //     if (items.deck) {
      //       returnValues.add('deck');
      //     }
      //     return returnValues;
      //   });
      // }
      // print(acm);
    });*/

    // print('Jpan $jPanels');
  }

  List<JobPanel> get jobPanelCopy {
    return defaultjPanels
        .map((e) => JobPanel(
            id: e.id,
            description: e.description,
            judge: e.judge,
            scrutineer: e.scrutineer,
            emcee: e.emcee,
            chairman: e.chairman,
            deck: e.deck,
            registrar: e.registrar,
            musicDj: e.musicDj,
            photosVideo: e.photosVideo,
            hairMakeup: e.hairMakeup))
        .toList();
  }

  List<JobPanel> get copyPanelList {
    return jPanels
        .map((e) => JobPanel(
        id: e.id,
        description: e.description,
        judge: e.judge,
        scrutineer: e.scrutineer,
        emcee: e.emcee,
        chairman: e.chairman,
        deck: e.deck,
        registrar: e.registrar,
        musicDj: e.musicDj,
        photosVideo: e.photosVideo,
        hairMakeup: e.hairMakeup))
        .toList();
  }

  void _sendMessage(JobPanel jp) {
    game.send(
        {
          "deviceId":DeviceConfig.deviceNum,
          "operation":"update-rolematrix",
          "broadcast":"all",
          "onDeckFloor": null,
          "scratch":null,
          "started":null,
          "roleMatrix": jp.toMap()
        }
    );
  }

  void saveButtonClick() {
    for (var item in jPanels) {
      //LoadContent.saveEventPermission(context, item);
      _sendMessage(item);
    }
    Global4Config.permissions = copyPanelList;
    Map<AccessPermissions, List<UserProfiles>> rolePermissions = {};
    for(var jp in Global4Config.permissions) {
      List<UserProfiles> _tempAccess = [];
      if(jp.judge) {
        _tempAccess.add(UserProfiles.JUDGE);
      }
      if(jp.scrutineer) {
        _tempAccess.add(UserProfiles.SCRUTINEER);
      }
      if(jp.emcee) {
        _tempAccess.add(UserProfiles.EMCEE);
      }
      if(jp.chairman) {
        _tempAccess.add(UserProfiles.CHAIRMAN_OF_JUDGES);
      }
      if(jp.deck) {
        _tempAccess.add(UserProfiles.DECK_CAPTAIN);
      }
      if(jp.registrar) {
        _tempAccess.add(UserProfiles.REGISTRAR);
      }
      if(jp.musicDj) {
        _tempAccess.add(UserProfiles.MUSIC_DJ);
      }
      if(jp.photosVideo) {
        _tempAccess.add(UserProfiles.PHOTOS_VIDEOS);
      }
      if(jp.hairMakeup) {
        _tempAccess.add(UserProfiles.HAIR_MAKEUP);
      }

      switch(jp.description.toString().toLowerCase()) {
        case "access to critique module":
          rolePermissions.putIfAbsent(AccessPermissions.CRITIQUE_MODULE, () => _tempAccess);
          break;
        case "access to heatlist module":
          rolePermissions.putIfAbsent(AccessPermissions.HEAT_LIST, () => _tempAccess);
          break;
        case "view all heats and participants":
          rolePermissions.putIfAbsent(AccessPermissions.VIEW_ALL_HEATS_PARTICIPANTS, () => _tempAccess);
          break;
        case "scratch competitors":
          rolePermissions.putIfAbsent(AccessPermissions.SCRATCH_COMPETITORS, () => _tempAccess);
          break;
        case "unscratch competitors":
          rolePermissions.putIfAbsent(AccessPermissions.UN_SCRATCH_COMPETITORS, () => _tempAccess);
          break;
        case "manage couple":
          rolePermissions.putIfAbsent(AccessPermissions.MANAGE_COUPLE, () => _tempAccess);
          break;
        case "add schedule judging panel":
          rolePermissions.putIfAbsent(AccessPermissions.SCHEDULE_JUDGING_PANEL, () => _tempAccess);
          break;
        case "mark couple check":
          rolePermissions.putIfAbsent(AccessPermissions.MARK_COUPLE, () => _tempAccess);
          break;
        case "statistics event monitoring test":
          rolePermissions.putIfAbsent(AccessPermissions.EVENT_MONITORING_STATISTICS, () => _tempAccess);
          break;
        default:
      }
    }
    Global4Config.rolePermissions = rolePermissions;
  }

  void discardButtonClick() {
    print('JPanels ${jPanels[0].judge}');
    print('Default Jpanel : ${defaultjPanels[0].judge}');
    setState(() {
      jPanels = [];
      jPanels = jobPanelCopy;
      // jPanels.addAll(defaultjPanels);
    });
  }

  // @override
  // Widget myText() {
  //   for (var i = 0; i <= jPanels.length; i++) {
  //     return Text('$i');
  //   }
  // }

  Color getColor(int selector) {
    if (selector % 2 == 0) {
      return Color(0xffE9F1F4);
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> _children = [];
    int counter = 0;
    List<JobPanel> _singleItemSelect = [];

    _children.add(
      TableRow(
        decoration: BoxDecoration(color: Colors.white),
        children: [
          TableCell(child: Text('')),
          TableCell(
            child: Center(
                child: Padding(
                  padding:
                  const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: Text('JUDGE',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900)),
                  ),
                )),
          ),
          TableCell(
              child: Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text('SCRUTNR',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w900)),
                    ),
                  ))),
          TableCell(
              child: Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text('MC',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w900)),
                    ),
                  ))),
          TableCell(
              child: Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text('CHAIRMAN',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w900)),
                    ),
                  ))),
          TableCell(
              child: Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text('DECK',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w900)),
                    ),
                  ))),
          TableCell(
              child: Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text('REGSTR',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w900)),
                    ),
                  ))),
          TableCell(
              child: Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text('MUSIC',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w900)),
                    ),
                  ))),
          TableCell(
              child: Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text('PHOTOS',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w900)),
                    ),
                  ))),
          TableCell(
              child: Center(
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Text('HAIR',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w900)),
                    ),
                  )))
        ]),
    );
    for(int x=0; x < jPanels.length; x++) {
      var item = jPanels[x];
      if(item.id == 1 || item.id == 2) {
        _singleItemSelect.add(item);
      }
      _children.add(
        TableRow(
          decoration: BoxDecoration(color: getColor(counter++)),
          children: [
            TableCell(
                child: Padding(
                  padding:
                  const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
                  child: Text(
                    "${item.description} [${item.id}]",
                    style: TextStyle(fontSize: 20.0),
                  ),
                )),
            TableCell(
                child: Checkbox(
                  value: item.judge,
                  onChanged: (val) {
                    setState(() {
                      if(item.id == 1 || item.id == 2) {
                        for(var singleItem in _singleItemSelect) {
                          singleItem.judge = false;
                        }
                      }
                      item.judge = val;
                    });
                  },
                )),
            TableCell(
                child: Checkbox(
                  value: item.scrutineer,
                  onChanged: (val) {
                    setState(() {
                      if(item.id == 1 || item.id == 2) {
                        for(var singleItem in _singleItemSelect) {
                          singleItem.scrutineer = false;
                        }
                      }
                      item.scrutineer = val;
                    });
                  },
                )),
            TableCell(
                child: Checkbox(
                  value: item.emcee,
                  onChanged: (val) {
                    setState(() {
                      if(item.id == 1 || item.id == 2) {
                        for(var singleItem in _singleItemSelect) {
                          singleItem.emcee = false;
                        }
                      }
                      item.emcee = val;
                    });
                  },
                )),
            TableCell(
                child: Checkbox(
                  value: item.chairman,
                  onChanged: (val) {
                    setState(() {
                      if(item.id == 1 || item.id == 2) {
                        for(var singleItem in _singleItemSelect) {
                          singleItem.chairman = false;
                        }
                      }
                      item.chairman = val;
                    });
                  },
                )),
            TableCell(
                child: Checkbox(
                  value: item.deck,
                  onChanged: (val) {
                    setState(() {
                      if(item.id == 1 || item.id == 2) {
                        for(var singleItem in _singleItemSelect) {
                          singleItem.deck = false;
                        }
                      }
                      item.deck = val;
                    });
                  },
                )),
            TableCell(
                child: Checkbox(
                  value: item.registrar,
                  onChanged: (val) {
                    setState(() {
                      if(item.id == 1 || item.id == 2) {
                        for(var singleItem in _singleItemSelect) {
                          singleItem.registrar = false;
                        }
                      }
                      item.registrar = val;
                    });
                  },
                )),
            TableCell(
                child: Checkbox(
                  value: item.musicDj,
                  onChanged: (val) {
                    setState(() {
                      if(item.id == 1 || item.id == 2) {
                        for(var singleItem in _singleItemSelect) {
                          singleItem.musicDj = false;
                        }
                      }
                      item.musicDj = val;
                    });
                  },
                )),
            TableCell(
                child: Checkbox(
                  value: item.photosVideo,
                  onChanged: (val) {
                    setState(() {
                      if(item.id == 1 || item.id == 2) {
                        for(var singleItem in _singleItemSelect) {
                          singleItem.photosVideo = false;
                        }
                      }
                      item.photosVideo = val;
                    });
                  },
                )),
            TableCell(
                child: Checkbox(
                  value: item.hairMakeup,
                  onChanged: (val) {
                    setState(() {
                      if(item.id == 1 || item.id == 2) {
                        for(var singleItem in _singleItemSelect) {
                          singleItem.hairMakeup = false;
                        }
                      }
                      item.hairMakeup = val;
                    });
                  },
                )),
          ]),
      );
    }

    return Container(
        margin: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
              child: Text('Module Permissions',
                  style:
                      TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900)),
            ),
            Table(
              columnWidths: {
                0: FlexColumnWidth(6),
              },
              // border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: _children
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
            //   child: Text('Heatlist Permissions',
            //       style:
            //           TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900)),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: new DanceFrameButton(
                      text: "DISCARD",
                      onPressed: () {
                        discardButtonClick();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: new DanceFrameButton(
                      text: "SAVE",
                      onPressed: () {
                        saveButtonClick();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: new DanceFrameButton(
                      text: "EXIT",
                      onPressed: () {
                        Navigator.maybePop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
