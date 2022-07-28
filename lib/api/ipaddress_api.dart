import 'package:http/http.dart' as http;

class IpaddressApi {
  static Future<String?> getIpAddress() async {
    try {
      final url = Uri.parse('https://api.ipify.org');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}
