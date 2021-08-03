import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:marvel_library/character/character.dart';
//import 'package:crypto/crypto.dart';
import 'dart:convert';

class CharacterAPI {
  const CharacterAPI({required this.httpClient});
  final http.Client httpClient;
  final String publicKey = '';
  final String privateKey = '';

  Future<List<Character>> fetchAllCharacters() async {
    final String requestURLBase = 'https://gateway.marvel.com';
    final String path = '/v1/public/characters';
    final response = await httpClient.get(
      Uri.https(requestURLBase, path, <String, String>{
        'apikey': publicKey,
        //'ts': '1',
        //'hash': _generateMd5('1' + privateKey + publicKey),
      }),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body)['data']['results'] as List;
      return body.map((dynamic json) {
        return Character(
          id: json['id'] as int,
          name: json['name'] as String,
        );
      }).toList();
    }

    throw Exception('error fetching posts');
  }

  Future<Character> fetchCharacterDetails(String characterID) async {
    final String requestURLBase = 'https://gateway.marvel.com';
    final String path = '/v1/public/characters/' + characterID;
    final response = await httpClient.get(
      Uri.https(requestURLBase, path, <String, String>{
        'apikey': publicKey,
        //'ts': '1',
        //'hash': _generateMd5('1' + privateKey + publicKey),
      }),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      dynamic result = body['data']['results'][0];
      List<Comic> comics = await _fetchCharacterComics(characterID);
      return Character(
        id: result['id'] as int,
        name: result['name'] as String,
        description: result['description'] as String,
        thumbnailPath: result['thumbnail']['path'] as String,
        thumbnailExtension: result['thumbnail']['extension'] as String,
        comics: comics,
      );
    }

    throw Exception('error fetching posts');
  }

  Future<List<Comic>> _fetchCharacterComics(String characterID) async {
    final String requestURLBase = 'https://gateway.marvel.com';
    final String path = '/v1/public/characters/' + characterID + '/comics';
    final response = await httpClient.get(
      Uri.https(requestURLBase, path, <String, String>{
        'apikey': publicKey,
        //'ts': '1',
        //'hash': _generateMd5('1' + privateKey + publicKey),
      }),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      dynamic result = body['data']['results'][0];
      return result['comics']['items'].map((dynamic json) {
        return Comic(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          thumbnailPath: json['thumbnail']['path'],
          thumbnailExtension: json['thumbnail']['extension'],
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }

/*
  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
  */
}
