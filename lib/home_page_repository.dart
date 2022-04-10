import 'dart:convert';

import 'package:tournament_design/tournament_response.dart';
import 'package:http/http.dart' as http;
class HomePageRepository{
  Future<TournamentData> getTournamentListData() async {
    var queryParameters = {
      'limit': '10',
      'status': 'all',
      'cursor':'CmMKGQoMcmVnX2VuZF9kYXRlEgkIgLTH_rqS7AISQmoOc35nYW1lLXR2LXByb2RyMAsSClRvdXJuYW1lbnQiIDIxMDQ5NzU3N2UwOTRmMTU4MWExMDUzODEwMDE3NWYyDBgAIAE='
    };
    var uri =
    Uri.http('tournaments-dot-game-tv-prod.uc.r.appspot.com','/tournament/api/tournaments_list_v2', queryParameters);
    var response = await http.get(uri);
    TournamentData data = TournamentData.fromJson(jsonDecode(response.body));
    return data;
  }
}