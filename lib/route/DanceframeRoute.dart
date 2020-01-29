import 'package:flutter/material.dart';
import 'package:danceframe_et/screens/splash.dart';
import 'package:danceframe_et/screens/device_mode.dart';
import 'package:danceframe_et/template/screen_template.dart';
import 'package:danceframe_et/screens/personalize_device.dart';
import 'package:danceframe_et/screens/contact_us_end.dart';
import 'package:danceframe_et/screens/contact_us.dart';
import 'package:danceframe_et/screens/critique_sheet_1.dart';
import 'package:danceframe_et/screens/critique_sheet_2.dart';
import 'package:danceframe_et/screens/signing_initials.dart';
import 'package:danceframe_et/screens/new_judge.dart';
import 'package:danceframe_et/screens/change_device_mode.dart';
import 'package:danceframe_et/screens/critique_done.dart';
import 'package:danceframe_et/screens/websocket_conn.dart';
import 'package:danceframe_et/screens/sign_in.dart';
import 'package:danceframe_et/screens/heat_list_panel.dart';

/*
  Author: Art

  [_MainFrameRoute] this class contains all routing/navigation path
  for the application. It also utilizes a fade transition when going
  to another screen
 */
class MainFrameRoute<T> extends MaterialPageRoute<T> {
  MainFrameRoute({ WidgetBuilder builder, RouteSettings settings })
      : super(builder: builder, settings: settings);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 400);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute)
      return child;

    return new FadeTransition(opacity: animation, child: child);
  }
}

/*
  Method for getting all the route for this application
 */
Route<Null> getMainFrameOnRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return new MainFrameRoute(
        builder: (_) => new Splash(),
        settings: settings,
      );

    case '/deviceMode':
      return new MainFrameRoute(
        builder: (_) => new device_mode(),
        settings: settings,
      );

    case '/screenTemplate':
      return new MainFrameRoute(
        builder: (_) => new screen_template(),
        settings: settings,
      );

    case '/personaliseDevice':
      return new MainFrameRoute(
        builder: (_) => new personalize_device(),
        settings: settings,
      );

    case '/signingInitials':
      return new MainFrameRoute(
        builder: (_) => new signing_initials(),
        settings: settings,
      );

    case '/newJudge':
      return new MainFrameRoute(
        builder: (_) => new new_judge(),
        settings: settings,
      );

    case '/sign-in':
      return new MainFrameRoute(
        builder: (_) => new sign_in(),
        settings: settings,
      );

    case '/critique1':
      return new MainFrameRoute(
        builder: (_) => new critique_sheet_1(),
        settings: settings,
      );

    case '/critique2':
      return new MainFrameRoute(
        builder: (_) => new critique_sheet_2(),
        settings: settings,
      );

    case '/heatlistPanel':
      return new MainFrameRoute(
        builder: (_) => new heat_list_panel(),
        settings: settings,
      );

    case '/critiqueDone':
      return new MainFrameRoute(
        builder: (_) => new critique_done(),
        settings: settings,
      );

    case '/changeDeviceMode':
      return new MainFrameRoute(
        builder: (_) => new change_device_mode(),
        settings: settings,
      );

    case '/contactUs':
      return new MainFrameRoute(
        builder: (_) => new contact_us(),
        settings: settings,
      );

    case '/contactUsEnd':
      return new MainFrameRoute(
        builder: (_) => new contact_us_end(),
        settings: settings,
      );

    case '/websocket':
      return new MainFrameRoute(
        builder: (_) => new websocket_conn(),
        settings: settings,
      );

    default:
      return null;
  }
}

Map<String, WidgetBuilder> getMainFrameRoute() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => new Splash(),
    '/deviceMode': (BuildContext context) => new device_mode(),
    '/screenTemplate': (BuildContext context) => new screen_template(),
    '/personaliseDevice': (BuildContext context) => new personalize_device(),
    '/signingInitials': (BuildContext context) => new signing_initials(),
    '/newJudge': (BuildContext context) => new new_judge(),
    '/sign-in': (BuildContext context) => new sign_in(),
    '/critique1': (BuildContext context) => new critique_sheet_1(),
    '/critique2': (BuildContext context) => new critique_sheet_2(),
    '/heatlistPanel': (BuildContext context) => new heat_list_panel(),
    '/critiqueDone': (BuildContext context) => new critique_done(),
    '/changeDeviceMode': (BuildContext context) => new change_device_mode(),
    '/contactUs': (BuildContext context) => new contact_us(),
    '/contactUsEnd': (BuildContext context) => new contact_us_end(),
    '/websocket': (BuildContext context) => new websocket_conn(),
  };
}