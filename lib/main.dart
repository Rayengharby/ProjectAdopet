import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet/FakeDogDatabase.dart';
import 'package:projet/model/Dog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'AdoPet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
    );
  }
}

// Configuration GoRouter avec tout dans main.dart
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    // Route pour la liste des chiens
    GoRoute(
      path: '/',
      builder: (context, state) => const DogListScreen(),
    ),
    // Route pour les détails du chien
    GoRoute(
      path: '/details/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final dog = dogList.firstWhere((dog) => dog.id == id);
        return DogDetailScreen(dog: dog);
      },
    ),
  ],
);

class DogListScreen extends StatelessWidget {
  const DogListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dogs for Adoption"),
      ),
      body: ListView.builder(
        itemCount: dogList.length,
        itemBuilder: (context, index) {
          final dog = dogList[index];
          return GestureDetector(
            onTap: () {
              context.push('/details/${dog.id}');
            },
            child: DogCard(dog: dog),
          );
        },
      ),
    );
  }
}

class DogCard extends StatelessWidget {
  final Dog dog;

  const DogCard({super.key, required this.dog});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              dog.image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dog.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${dog.age} yrs | ${dog.color}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red, size: 14),
                    Text(
                      "${dog.location} away",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: dog.gender == 'Male' ? Colors.blue[50] : Colors.pink[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              dog.gender,
              style: TextStyle(
                color: dog.gender == 'Male' ? Colors.blue : Colors.pink,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Écran de détail pour les chiens
class DogDetailScreen extends StatelessWidget {
  final Dog dog;

  const DogDetailScreen({super.key, required this.dog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(dog.name),
      ),
      body: SingleChildScrollView( // Ajout du SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    dog.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                dog.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Age: ${dog.age} years',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                'Gender: ${dog.gender}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                'Color: ${dog.color}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              Text(
                'Weight: ${dog.weight} kg',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'About: ${dog.about}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                'Owner: ${dog.owner.name}',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
