import 'package:flutter/material.dart';
import 'package:projet/main.dart';
import 'package:projet/services/api_service.dart';
import 'package:projet/model/Dog.dart';
import 'package:projet/model/Owner.dart';

class AddDogScreen extends StatefulWidget {
  const AddDogScreen({super.key});

  @override
  State<AddDogScreen> createState() => _AddDogScreenState();
}

class _AddDogScreenState extends State<AddDogScreen> {
  final _formKey = GlobalKey<FormState>();

  // varibale pour le stockagee
  String name = '';
  double age = 0;
  String gender = 'male';
  String? color;
  double? weight;
  String? location;
  String? imageUrl;
  String? description;

  String? ownerName;
  String? ownerBio;
  String? ownerImageUrl;

void addDog() async {
  if (_formKey.currentState!.validate()) {
    final dog = Dog(
      id: '', 
      name: name,
      age: age,
      gender: gender,
      color: color,
      weight: weight,
      location: location,
      imageUrl: imageUrl,
      description: description,
      owner: Owner(
        name: ownerName ?? '',
        bio: ownerBio ?? '',
        imageUrl: ownerImageUrl ?? '',
      ),
    );

    await apiService.addDog(dog); 
    Navigator.pop(context, true);  
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un chien'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom du chien'),
                onChanged: (value) => name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est requis';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Âge'),
                keyboardType: TextInputType.number,
                onChanged: (value) => age = double.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est requis';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sexe (male/female)'),
                onChanged: (value) => gender = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ce champ est requis';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Couleur (optionnel)'),
                onChanged: (value) => color = value.isEmpty ? null : value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Poids (optionnel)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => weight = double.tryParse(value),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Localisation (optionnel)'),
                onChanged: (value) => location = value.isEmpty ? null : value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'URL de l\'image (optionnel)'),
                onChanged: (value) => imageUrl = value.isEmpty ? null : value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description (optionnel)'),
                onChanged: (value) => description = value.isEmpty ? null : value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nom du propriétaire (optionnel)'),
                onChanged: (value) => ownerName = value.isEmpty ? null : value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Bio du propriétaire (optionnel)'),
                onChanged: (value) => ownerBio = value.isEmpty ? null : value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Image du propriétaire (optionnel)'),
                onChanged: (value) => ownerImageUrl = value.isEmpty ? null : value,
              ),
              ElevatedButton(
                onPressed: addDog,
                child: const Text('Ajouter le chien'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
