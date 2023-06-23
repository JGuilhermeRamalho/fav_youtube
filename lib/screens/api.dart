import 'dart:convert';
import 'package:fav_youtube/models/video.dart';
import 'package:http/http.dart' as http;

//api utilizada para obter a lista de vídeos e para dar play nos vídeos dentro do app
const API_KEY = 'AIzaSyCwZFSDE_oIWDor9S_iyFucXK1pwC-P7JE';

class API {
  String _search = '';
  String _nextToken = '';
  Future<List<Video>> search(String search) async {
    _search = search;
    http.Response response = await http.get(
      Uri.parse(
          "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10"),
    );
    return decode(response);
  }

  Future<List<Video>> nextPage() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken'),
    );
    return decode(response);
  }

  List<Video> decode(http.Response response) {
    //código 200 significa que recebeu os dados com sucesso
    if (response.statusCode == 200) {
      _nextToken = json.decode(response.body)['nextPageToken'];

      List decoded = json.decode(response.body)['items'];
      List<Video> videos =
      decoded.map<Video>((v) => Video.fromJson(v)).toList();
      return videos;
    }
    throw Exception('Falha ao carregar vídeos');
  }
}