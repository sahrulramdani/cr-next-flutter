import '../constants/style.dart';
import '../models/http_leads.dart';
import 'package:http/http.dart' as http;

class LeadsService {
  static final String _baseUrl = "$urlAddress/marketing/leadsdata";

  Future getLeads() async {
    Uri urlApi = Uri.parse(_baseUrl);

    final response = await http.get(urlApi, headers: {
      'pte-token': kodeToken,
    });

    if (response.statusCode == 200) {
      leadsFromJson(response.body.toString());
      // print("response.body");
      // return response.body.toString();
      return leadsFromJson(response.body.toString());
    } else {
      throw Exception("Aksek gagal untuk data Leads");
    }
  }
}
