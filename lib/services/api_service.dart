// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projet/model/Dog.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000';
//GetAll
  Future<List<Dog>> fetchDogs() async {
    final url = Uri.parse('$baseUrl/dogs');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((dogJson) => Dog.fromJson(dogJson)).toList();
    } else {
      throw Exception('Failed to fetch dogs. Status code: ${response.statusCode}');
    }
  }

//POST
  Future<void> addDog(Dog dog) async {
    final url = Uri.parse('$baseUrl/dogs');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': dog.name,
        'age': dog.age,
        'gender': dog.gender,
        'color': dog.color,
        'weight': dog.weight,
        'location': dog.location,
        'imageUrl': dog.imageUrl,
        'description': dog.description,
        'owner': {
          'name': dog.owner.name,
          'bio': dog.owner.bio,
          'imageUrl': dog.owner.imageUrl,
        },
      }),
    );

    if (response.statusCode == 201) {
    } else {
      throw Exception('Failed to add dog');
    }
  }
//DELETE
  Future<void> deleteDog(String dogId) async {
    final url = Uri.parse('$baseUrl/dogs/$dogId'); 

    final response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Chien supprimé avec succès');
    } else {
      throw Exception('Échec de la suppression du chien');
    }
  }

//PUT
Future<void> updateDog(Dog dog) async {
  final url = Uri.parse('$baseUrl/dogs/${dog.id}');
  final response = await http.put(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': dog.name,
      'age': dog.age,
      'gender': dog.gender,
      'color': dog.color,
      'weight': dog.weight,
      'location': dog.location,
      'imageUrl': dog.imageUrl,
      'description': dog.description,
      'owner': {
        'name': dog.owner.name,
        'bio': dog.owner.bio,
        'imageUrl': dog.owner.imageUrl,
      },
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to update dog. Status code: ${response.statusCode}');
  }
}


}


