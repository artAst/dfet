import 'package:flutter/material.dart';
import 'package:danceframe_et/screens/splash.dart';
import 'package:danceframe_et/screens/device_mode.dart';
import 'package:danceframe_et/template/screen_template.dart';
import 'package:danceframe_et/screens/personalize_device.dart';
import 'package:danceframe_et/screens/contact_us_end.dart';
import 'package:danceframe_et/screens/contact_us.dart';

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
    '/contactUs': (BuildContext context) => new contact_us(),
    '/contactUsEnd': (BuildContext context) => new contact_us_end(),
  };
}