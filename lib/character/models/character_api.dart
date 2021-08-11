import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:marvel_library/character/character.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:developer';

class CharacterAPI {
  const CharacterAPI({required this.httpClient});
  final http.Client httpClient;
  final String publicKey = 'c71a3af5ae28e9436b14c4b448152d31';
  final String privateKey = '26617e1cb8cdd563845f1cc07c435b6f0e09a29c';
  final String ts = '1';
  final String characterLimit = '20';
  final String comicLimit = '5';

  Future<List<Character>> fetchAllCharacters() async {
    final String requestURLBase = 'https://gateway.marvel.com';
    final String path = '/v1/public/characters?apikey=' +
        publicKey +
        '&ts=' +
        ts +
        '&hash=' +
        _generateMd5(ts + privateKey + publicKey) +
        '&limit=' +
        characterLimit;
    final response = await httpClient.get(
      Uri.parse(requestURLBase + path),
    );
    log(response.headers.toString());

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
    final String path = '/v1/public/characters/' +
        characterID +
        '?apikey=' +
        publicKey +
        '&ts=' +
        ts +
        '&hash=' +
        _generateMd5(ts + privateKey + publicKey);

    final response = await httpClient.get(
      Uri.parse(requestURLBase + path),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      dynamic result = body['data']['results'][0];
      List<Comic> comics = await _fetchCharacterComics(characterID);
      return Character(
        id: result['id'] as int,
        name: result['name'] as String,
        description: result['description'],
        thumbnailPath: result['thumbnail']['path'],
        thumbnailExtension: result['thumbnail']['extension'],
        comics: comics,
      );
    }

    throw Exception('error fetching posts');
  }

  Future<List<Comic>> _fetchCharacterComics(String characterID) async {
    final String requestURLBase = 'https://gateway.marvel.com';
    final String path = '/v1/public/characters/' +
        characterID +
        '/comics' +
        '?apikey=' +
        publicKey +
        '&ts=' +
        ts +
        '&hash=' +
        _generateMd5(ts + privateKey + publicKey) +
        '&limit=' +
        comicLimit;
    final response = await httpClient.get(
      Uri.parse(requestURLBase + path),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body)['data']['results'] as List;
      return body.map((dynamic json) {
        return Comic(
          id: json['id'] as int,
          title: json['title'] as String,
          description: json['description'],
          thumbnailPath: json['thumbnail']['path'],
          thumbnailExtension: json['thumbnail']['extension'],
        );
      }).toList();
    }

    throw Exception('error fetching posts');
  }

  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
