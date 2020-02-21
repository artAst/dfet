import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart';
import 'package:danceframe_et/util/ScreenUtil.dart';

const TIMEOUT_DURATION = 20;

class HttpUtil {

 static Future getRequest(String uri) async {
   Response res = await get(uri);

   if (res.statusCode == 200) {
     List<dynamic> body = jsonDecode(res.body);
     print("response body:");
     print(body);
     return body;
   } else {
     return {
       "error": res.statusCode,
       "message": res.reasonPhrase
     };
   }
 }

 static Future postRequest(context, String uri, Map<String, dynamic> jsonBody) async {
   Response res = await post(uri, headers: {}, body: jsonEncode(jsonBody))
       .timeout(Duration(seconds: TIMEOUT_DURATION))
       .catchError((error){
     ScreenUtil.showMainFrameDialog(context, "debug", error.message);
     if(error is TimeoutException || error is SocketException) {
       print("Request has timed out");
       throw new StateError("Error: Request has timed out.");
     }
     else {
       print("error: ${error}");
       throw new StateError("Error: Internal error has occurred. Please contact support.");
     }
   });

   return res;
 }
}