import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:danceframe_et/util/ScreenUtil.dart';

const TIMEOUT_DURATION = 20;

class HttpUtil {

  static Future getRequest(String uri) async {
    try {
      http.Response res = await http.get(uri);
      print("res status code: ${res.statusCode}");
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        print("response body:");
        print(body);
        return body;
      } else {
        print("INVALID RESPONSE: ${res.statusCode}");
        print(res.reasonPhrase);
        return {
          "error": res.statusCode,
          "message": res.reasonPhrase
        };
      }
    } catch (e) {
      print("Error decoding: $e");
      return {
        "error": 404,
        "message": e
      };
    }
  }

  static Future postRequest(context, String uri,
      dynamic jsonBody) async {
    print("Sending HTTP POST: $uri");
    print("request post body: $jsonBody");
    try {
      http.Response res = await http.post(
          uri, headers: {"Content-Type": "application/json"},
          body: jsonEncode(jsonBody));
      //.timeout(Duration(seconds: TIMEOUT_DURATION))
      //  .catchError((error) {
      //ScreenUtil.showMainFrameDialog(context, "debug", error.message);
      /*if (error is TimeoutException || error is SocketException) {
        print("Request has timed out");
        throw new StateError("Error: Request has timed out.");
      }
      else {
        print("error: ${error}");
        throw new StateError(
            "Error: Internal error has occurred. Please contact support.");
      }
    });*/

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        print("response body:");
        print(body);
        return body;
      } else {
        print("INVALID RESPONSE: ${res.statusCode}");
        print(res.reasonPhrase);
        return {
          "error": res.statusCode,
          "message": res.reasonPhrase
        };
      }
    } catch(e) {
      print("Error decoding: $e");
      return {
        "error": 404,
        "message": e
      };
    }
  }

  static Future uploadImage(context, String uri, File filename) async {
    print("UPLOADING IMAGE @ $uri");
    var postUri = Uri.parse(uri);
    var request = http.MultipartRequest("POST", postUri);
    request.fields["Content-Type"] = "multipart/form-data";
    request.files.add(await http.MultipartFile.fromPath("uploadfile", filename.absolute.path, contentType: new MediaType("image", "png")));
    var stres = await request.send();
    print("status: ${stres.statusCode}");
    print("phrase: ${stres.reasonPhrase}");
    if (stres.statusCode == 200) {
      var res = await http.Response.fromStream(stres);
      var body = jsonDecode(res.body);
      print("response body:");
      print(body);
      return body;
    } else {
      print("INVALID RESPONSE: ${stres.statusCode}");
      print(stres.reasonPhrase);
      return {
        "error": stres.statusCode,
        "message": stres.reasonPhrase
      };
    }
  }
}