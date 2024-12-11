import 'package:projet/model/Owner.dart';

class Dog {
  final String id;  
  final String name;
  final double age;
  final String gender;
  final String? color;  
  final double? weight;  
  final String? location;  
  final String? imageUrl;  
  final String? description;  
  final Owner owner;

  Dog({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    this.color,
    this.weight,
    this.location,
    this.imageUrl,
    this.description,
    required this.owner,
  });

  factory Dog.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        '_id': String id, 
        'name': String name, 
        'age': num age, 
        'gender': String gender, 
        'color': String? color, 
        'weight': num? weight, 
        'location': String? location, 
        'imageUrl': String? imageUrl, 
        'description': String? description, 
        'owner': Map<String, dynamic> ownerJson
      } => Dog(
        id: id,
        name: name,
        age: age.toDouble(),
        gender: gender,
        color: color,
        weight: weight?.toDouble(),
        location: location,
        imageUrl: imageUrl,
        description: description,
        owner: Owner.fromJson(ownerJson),
      ),
      _ => throw const FormatException('Failed to load dog.'),
    };
  }
}
