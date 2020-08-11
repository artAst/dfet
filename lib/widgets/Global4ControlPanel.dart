import 'package:flutter/material.dart';
import 'package:danceframe_et/util/LoadContent.dart';
import 'package:danceframe_et/model/JobPanel.dart';
import 'package:danceframe_et/widgets/CPCheckbox.dart';
import 'package:danceframe_et/widgets/DanceFrameButton.dart';

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
    LoadContent.loadEventPermission(context).then((jobPanelList) {
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
    });

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

  void saveButtonClick() {
    for (var item in jPanels) {
      LoadContent.saveEventPermission(context, item);
    }
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
    // for (var item in jPanels) {
    //   print(item.id);
    //   print(item.description);
    //   print(item.judge);
    //   print(item.scrutiner);
    //   print(item.emcee);
    //   print(item.chairman);
    //   print(item.deck);
    //   _rowData.add(Checkbox(
    //     value: item.emcee,
    //     onChanged: (val) {
    //       setState(() {
    //         item.emcee = val;
    //       });
    //     },
    //   ));
    // }
    int counter = 0;
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
              children: [
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
                for (var item in jPanels)
                  TableRow(
                      decoration: BoxDecoration(color: getColor(counter++)),
                      children: [
                        TableCell(
                            child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
                          child: Text(
                            item.description,
                            style: TextStyle(fontSize: 20.0),
                          ),
                        )),
                        TableCell(
                            child: Checkbox(
                          value: item.judge,
                          onChanged: (val) {
                            setState(() {
                              item.judge = val;
                            });
                          },
                        )),
                        TableCell(
                            child: Checkbox(
                          value: item.scrutineer,
                          onChanged: (val) {
                            setState(() {
                              item.scrutineer = val;
                            });
                          },
                        )),
                        TableCell(
                            child: Checkbox(
                          value: item.emcee,
                          onChanged: (val) {
                            setState(() {
                              item.emcee = val;
                            });
                          },
                        )),
                        TableCell(
                            child: Checkbox(
                          value: item.chairman,
                          onChanged: (val) {
                            setState(() {
                              item.chairman = val;
                            });
                          },
                        )),
                        TableCell(
                            child: Checkbox(
                          value: item.deck,
                          onChanged: (val) {
                            setState(() {
                              item.deck = val;
                            });
                          },
                        )),
                        TableCell(
                            child: Checkbox(
                          value: item.registrar,
                          onChanged: (val) {
                            setState(() {
                              item.registrar = val;
                            });
                          },
                        )),
                        TableCell(
                            child: Checkbox(
                          value: item.musicDj,
                          onChanged: (val) {
                            setState(() {
                              item.musicDj = val;
                            });
                          },
                        )),
                        TableCell(
                            child: Checkbox(
                          value: item.photosVideo,
                          onChanged: (val) {
                            setState(() {
                              item.photosVideo = val;
                            });
                          },
                        )),
                        TableCell(
                            child: Checkbox(
                          value: item.hairMakeup,
                          onChanged: (val) {
                            setState(() {
                              item.hairMakeup = val;
                            });
                          },
                        )),
                      ]),
              ],
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
