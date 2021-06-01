import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;

class CalendarClient {
  static const scopes = const [CalendarApi.calendarScope];
  var credential;
  final String androidIdentifier = "200328242871-nhmj0v1r6nf24letk02ejt145c04n3sq.apps.googleusercontent.com";
  final String iosIdentifier = '';

  void prompt(String url) async {
    print('Please go to the following url and grant access');
    print('$url');

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('cannot launch $url');
    }
  }
  
  insert(String description, DateTime startTime, DateTime endTime) {
    var clientId;
    if(Platform.isAndroid) {
      clientId = ClientId(androidIdentifier, '');
    } else if (Platform.isIOS) {
      clientId = ClientId(iosIdentifier, '');
    }
    if (clientId != null) {
      clientViaUserConsent(clientId, scopes, prompt).then((AuthClient client) {
        var calendar = CalendarApi(client);
        var differenceDuration = DateTime.now().timeZoneOffset;
        if (differenceDuration.isNegative) {
          startTime = startTime.add(differenceDuration);
          endTime = endTime.add(differenceDuration);
        } else {
          startTime = startTime.subtract(differenceDuration);
          endTime = endTime.subtract(differenceDuration);
        }
        // calendar.calendarList.list().then((value) => print('VAL $value'));
        String calendarId = 'primary';
        Event event = Event();
        event.description = description;
        event.summary = 'Smmart Professional Organizational Building';

        EventDateTime start = EventDateTime();
        start.dateTime = startTime;
        start.timeZone = '';
        event.start = start;

        EventDateTime end = EventDateTime();
        end.dateTime = endTime;
        event.end = end;

        try {
          calendar.events.insert(event, calendarId).then((value) {
            print('added before calendar ${value.status}');
            if (value.status == 'confirmed') print('Event added confirmed');
            else print('event not added');
          });
        } catch (e) {
          print('Error creating event $e');
        }
      });
    } else {
      print('not created client id');
    }
  }
}