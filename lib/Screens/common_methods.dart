List categoriseRooms(List floors, List rooms, String roomType) {
  List finalTemp = [];
  for (var i = 0; i < floors.length; i++) {
    List temp = [];
    for (var j = 0; j < rooms.length; j++) {
      if (floors[i]['floor_no'] == rooms[j]['floor'] && (rooms[j]['room_type'] == roomType)) {
        temp.add(rooms[j]);
      }
    }
    finalTemp.add(temp);
  }
  return finalTemp;
}

//filtering rooms by floors
List categoriseRoomsbyFloors(int floor, List rooms) {
  List finalTemp = [];

  for (var j = 0; j < rooms.length; j++) {
    if (floor == rooms[j]['floor']) {
      finalTemp.add(rooms[j]);
    }
  }
  return finalTemp;
}

//device id to list of device id
Future<List> removeDuplicateRoomsAndIntegrateResult(List rooms) async {
    print('in remove');
    print(rooms);
    List cRooms = [];
    for (var i = 0; i < rooms.length; i++) {
      bool add = true;
      // if (rooms[i]['room_no'] not in cRooms)
      for(var j = 0; j < cRooms.length; j++){
        if (rooms[i]['room_no'] == cRooms[j]['room_no']){
          add = false;
          List temp = cRooms[j]['deviceId'];
          print('getting values in list');
          temp.add(rooms[i]['deviceId']);
          cRooms[j]['deviceId'] = temp;
        }
      }
      if (add){
        //change deviceid to list of device ID
        print('device id to list of device id');
        List temp = [rooms[i]['deviceId']];
        print(temp);
        rooms[i]['deviceId'] = temp;
        cRooms.add(rooms[i]);
        print(cRooms);
      }
    }
    print('final');
    print(cRooms);
    return cRooms;
  }

String findMaxCountbyRoomTypeAndRoomNo(List rooms, String roomNo, String roomType) {
  print(rooms);
  String max;
  for (var i = 0; i < rooms.length; i++) {
    if (rooms[i]['room_no'].toString() == roomNo && rooms[i]['room_type'] == roomType) {
      max = rooms[i]['max_count'].toString();
      print('max ' + max);
      return max;
    }
  }
  return max;
}

List filterRooms(List booking, int id) {
  List temp = [];
  for (var i = 0; i < booking.length; i++) {
    if (booking[i]['room'] == id) {
      temp.add(booking[i]);
    }
  }
  return temp;
}

Future<List> getNotVerifiedUsers(List users) async {
  List temp = [];
  for (var i = 0; i < users.length; i++) {
    if (users[i]['is_verified'] == false) {
      temp.add(users[i]);
    }
  }
  return temp;
}
