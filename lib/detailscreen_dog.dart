import 'package:flutter/material.dart';
import 'package:projet/model/Dog.dart';

class DogDetailScreen extends StatelessWidget {
  final Dog dog;

  const DogDetailScreen({super.key, required this.dog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dog.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    dog.imageUrl ?? 'assets/default_dog.png', 
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                dog.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text('Age: ${dog.age} ans', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Text('Genre: ${dog.gender}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Text('Couleur: ${dog.color ?? "Inconnu"}', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 5),
              Text('Poids: ${dog.weight ?? "Inconnu"} kg', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Text(
                'Description: ${dog.description ?? "Aucune description disponible"}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                'Propriétaire',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      dog.owner.imageUrl ?? 'assets/default_owner.png',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dog.owner.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(dog.owner.bio, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}