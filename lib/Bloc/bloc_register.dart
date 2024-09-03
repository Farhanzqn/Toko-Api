import 'dart:convert';
import 'package:my_flutter_project/Model/Register/model_register.dart';
import 'package:my_flutter_project/helpers/api.dart';
import 'package:my_flutter_project/helpers/api_url.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi(
      {String? nama, String? email, String? password}) async {
    String apiUrl = ApiUrl.registrasi;

    var body = {"nama": nama, "email": email, "password": password};

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Registrasi.fromJson(jsonObj);
  }
}
