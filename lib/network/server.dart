// import 'dart:html';
import 'calendar_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String apiUrl = 'http://40.114.4.245:8000/';

Future<List> getTableDetails(String tableName) async {
  List res = [];
  String url = apiUrl + tableName + '/?format=json';
  // print('url');
  // print(url);
  http.Response resp = await http.get(Uri.parse(url));
  if (resp.statusCode == 200) {
    res = json.decode(resp.body);
    return res;
  } else {
    return res;
  }
}

Future<void> putFloor(String fno) async {
  String url = apiUrl + 'floors/';
  Map<String, String> headers = {'Content-type': 'application/json'};
  Map data = {
    'floor_no': fno,
    'building': 'Building 1',
  };
  String body = json.encode(data);
  print(body);
  http.Response resp = await http.post(Uri.parse(url), headers: headers, body: body);
  print(resp.statusCode);
  print(resp.body);
}

Future<bool> putRoom(String room, String roomType, String deviceId, String max, int floor) async {
  String url = apiUrl + 'rooms/';
  Map<String, String> headers = {'Content-type': 'application/json'};
  Map data = {
    'room_no': room,
    'room_type': roomType,
    'deviceId': deviceId,
    'max_count': max,
    'floor': floor.toString(),
    'building': 'Building 1',
  };
  String body = json.encode(data);
  print(body);
  http.Response resp = await http.post(Uri.parse(url), headers: headers, body: body);
  print(resp.statusCode);
  if (resp.statusCode == 201) {
    return true;
  } else {
    return false;
  }
}

Future<bool> postBooking(String fromTime, String toTime, String description, String roomId, String user) async {
  String url = apiUrl + 'bookings/';
  // CalendarClient calendarClient = CalendarClient();
  // DateTime startTime = DateTime.tryParse(fromTime);
  // DateTime endTime = DateTime.tryParse(toTime);

  // calendarClient.insert(description, startTime, endTime);
  // return false;
  Map<String, String> headers = {'Content-type': 'application/json'};
  Map data = {
    'from_date_time': fromTime,
    'to_date_time': toTime,
    'description': description,
    'room': roomId,
    'user': user,
  };
  String body = json.encode(data);
  http.Response resp = await http.post(Uri.parse(url), headers: headers, body: body);
  print(resp.body);
  if (resp.statusCode == 201){
    CalendarClient calendarClient = CalendarClient();
    DateTime startTime = DateTime.tryParse(fromTime);
    DateTime endTime = DateTime.tryParse(toTime);

    calendarClient.insert(description, startTime, endTime);
    return true;
  } else {
    return false;
  }
}

Future<bool> postUser(String email, String mobileno, String password) async {
  String url = apiUrl + 'users/';
  Map<String, String> headers = {'Content-type': 'application/json'};
  Map data = {
    'email_id': email,
    'mobile_no': mobileno,
    'password': password,
  };
  String body = json.encode(data);
  http.Response resp = await http.post(Uri.parse(url), headers: headers, body: body);
  if (resp.statusCode == 201) return true;
  else return false;
}

Future<void> allowUser(String id, String emailId, String password, String mobileNo) async {
  String url = apiUrl + 'users/' + id + '/';
  final headers = {'Content-type': 'application/json'};
  final json = '''{"is_verified": true}''';
  final response = await http.patch(Uri.parse(url), headers: headers, body: json);
  if (response.statusCode == 200) return true;
  else return false;
}