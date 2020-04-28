import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class TimeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    String retVal = "";

    String s = newValue.text;
    int _offset = newValue.text.runes.length;
    int hour = 0;
    int min = 0;
    String categ = "";
    List<String> trunc1 = s.contains(":") ? s.split(":") : [];
    List<String> trunc2 = trunc1.length > 0 && trunc1[1].contains(" ") ? trunc1[1].split(" ") : [];
    //retVal = "";
    print("s: $s");
    print("trunc1: $trunc1");
    print("trunc2: $trunc2");
    print("OFFSET: " + _offset.toString()); 

    //for 24 hour format
    if(trunc1.length > 0) { 
      String hh = trunc1[0], mm = trunc1[1];
      hour = int.parse(hh);
      print("hour: $hour");
      min = !mm.isEmpty ? int.parse(mm) : 0;
      print("min: $min");

      if(hour > 0 && min <= 0) {
        _offset = 2;
      }
      else if(hour > 0 && min > 0 && _offset != 9) {
        _offset = 5;
      } else {
        _offset = 6;
      } 

      if(hour > 24 || min > 59) {
        retVal = oldValue.text;
      } else {
        retVal += hour.toString().padLeft(2, "0");
        retVal += ":";
        retVal +=
        min != 0 ? min.toString().padLeft(2, "0") : min.toString().padRight(2, "0");
        //retVal += !categ.isEmpty ? " $categ" : "";
      }
      
    } else if(s.length > 0) {
      hour = int.parse(s);
      print(hour);
      retVal += hour.toString().padLeft(2, "0");
      retVal += ":00";
      _offset = 2;
    }

    if(retVal == "00:00" || (hour == 0 && min ==0)) {
      retVal = "";
    }
    
    //for 12 hour format
    // if(trunc1.length > 0) {
    //   String hh = trunc1[0], mm = trunc2[0];
    //   hour = int.parse(hh);
    //   print("hour: $hour");
    //   min = !mm.isEmpty ? int.parse(mm) : 0;
    //   print("min: $min");

    //   if(hour > 0 && min <= 0) {
    //     _offset = 2;
    //   }
    //   else if(hour > 0 && min > 0 && _offset != 9) {
    //     _offset = 5;
    //   } else {
    //     _offset = 6;
    //   } 
    //   if(hour > 12) {
    //     var _pre = hh;
    //     hh = _pre.substring(0, 2);
    //     hour = int.parse(hh);
    //     mm = _pre.substring(2, 3);
    //     min = int.parse(mm);
    //     print("new hour: $hour");
    //     print("new min: $min");
    //     _offset = 5;
    //   }
    //   else if(min > 59) {
    //     print("min is greater than 59");
    //     var _pre = hh;
    //     hh = _pre.substring(0, 2);
    //     hour = int.parse(hh);
    //     mm = mm.substring(0, 2);
    //     min = int.parse(mm);
    //     print("new hour: $hour");
    //     print("new min: $min");
    //     _offset = 5;
    //   }

    //   print("pre offset: $_offset");
    //   if(_offset == 9) {
    //     _offset = 6;
    //   }

    //   if(trunc2.length > 1 && trunc2[1]?.isNotEmpty) {
    //     // get AM/PM
    //     if(trunc2[1][0].toLowerCase() == "a") {
    //       categ = "AM";
    //     }
    //     else if(trunc2[1][0].toLowerCase() == "p") {
    //       categ = "PM";
    //     }
    //   }

    //   if(hour > 12 || min > 59) {
    //     retVal = oldValue.text;
    //   } else {
    //     retVal += hour.toString().padLeft(2, "0");
    //     retVal += ":";
    //     retVal +=
    //     min != 0 ? min.toString().padLeft(2, "0") : min.toString().padRight(2, "0");
    //     retVal += !categ.isEmpty ? " $categ" : " AM";
    //   }
    // } else if(s.length > 0) {
    //   hour = int.parse(s);
    //   retVal += hour.toString().padLeft(2, "0");
    //   retVal += ":00 AM";
    //   _offset = 2;
    // }

    // if(retVal == "00:00" || (hour == 0 && min ==0)) {
    //   retVal = "";
    // }
    print("offset: $_offset");
    print("retVal: $retVal");

    final TextSelection newSelection = newValue.selection.copyWith(
      baseOffset: _offset,
      extentOffset: _offset,
    );

    return new TextEditingValue(
      text: retVal,
      selection: newSelection,
      composing: TextRange.empty,
    );
  }
}