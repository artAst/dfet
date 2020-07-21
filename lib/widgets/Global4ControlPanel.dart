import 'package:flutter/material.dart';

class Global4ControlPanel extends StatefulWidget {
  @override
  _Global4ControlPanelState createState() => new _Global4ControlPanelState();
}

class _Global4ControlPanelState extends State<Global4ControlPanel> {

  @override
  Widget build(BuildContext context) {
    bool checkValue = false;
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
              border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  TableCell(child: Text('')),
                  TableCell(
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                            child: Text('Judge',
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.w900)),
                          ))),
                  TableCell(
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                            child: Text('Scrutineer',
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.w900)),
                          ))),
                  TableCell(
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                            child: Text('MG',
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.w900)),
                          ))),
                  TableCell(
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                            child: Text('COJ',
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.w900)),
                          ))),
                  TableCell(
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                            child: Text('Desk Captian',
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.w900)),
                          )))
                ]),
                TableRow(children: [
                  TableCell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                        child: Text('Access to Critique Mode',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600)),
                      )),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(child: Checkbox(value: checkValue, onChanged: null))
                ]),
                TableRow(children: [
                  TableCell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                        child: Text('Access to Heatlist Mode',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600)),
                      )),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(child: Checkbox(value: checkValue, onChanged: null))
                ]),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
              child: Text('Heatlist Permissions',
                  style:
                  TextStyle(fontSize: 24.0, fontWeight: FontWeight.w900)),
            ),
            Table(
              border: TableBorder.all(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  TableCell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                        child: Text('View all Heat Participants',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600)),
                      )),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(child: Checkbox(value: checkValue, onChanged: null))
                ]),
                TableRow(children: [
                  TableCell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                        child: Text('Scratch Competitors',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600)),
                      )),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(child: Checkbox(value: checkValue, onChanged: null))
                ]),
                TableRow(children: [
                  TableCell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                        child: Text('On Scratch Competitors',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600)),
                      )),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(child: Checkbox(value: checkValue, onChanged: null))
                ]),
                TableRow(children: [
                  TableCell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                        child: Text('Add/Schedule Judging Panel',
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.w600)),
                      )),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(child: Checkbox(value: checkValue, onChanged: null))
                ]),
                TableRow(children: [
                  TableCell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                        child: Text('Marked Couple Checked',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600)),
                      )),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(child: Checkbox(value: checkValue, onChanged: null))
                ]),
                TableRow(children: [
                  TableCell(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                        child: Text('Statistics Event Monitoring',
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.w600)),
                      )),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(
                      child: Checkbox(value: checkValue, onChanged: null)),
                  TableCell(child: Checkbox(value: checkValue, onChanged: null))
                ]),
              ],
            )
          ],
    ));
  }
}