import 'package:flutter/services.dart';
import 'package:project_test/models/video.dart';

class ApiService {
  Future videoList() async {
    var response = await rootBundle.loadString('assets/videoList.json');
    // print(response);
    // var data = await json.decode(response);
    // print(data);
    return videoListFromJson(response);
  }
}
