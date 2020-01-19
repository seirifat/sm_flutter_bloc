import 'dart:convert';

import 'package:sm_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:sm_flutter/services/states.dart';

class APIService {
  static Future<APIDetailResult> getUserFromAPI(int id) async {
    String apiURL = "https://reqres.in/api/users/" + id.toString();

    var apiResult = await http.get(apiURL);
    var jsonObject = json.decode(apiResult.body);
    var userData = (jsonObject as Map<String, dynamic>)['data'];
    print(jsonObject);
    final result = APIDetailResult();
    result.code = 101;
    result.message = 'success';
    result.data = User.createUser(userData);
    return result;
  }
}