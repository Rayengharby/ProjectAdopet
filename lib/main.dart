import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet/AddDogScreen.dart';
import 'package:projet/EditDogScreen.dart';
import 'package:projet/model/Owner.dart';
import 'detailscreen_dog.dart';
import 'package:projet/model/Dog.dart';
import 'package:projet/services/api_service.dart';

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

final ApiService apiService = ApiService();

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DogListScreen(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => DogDetailScreen(
        dog: state.extra as Dog,
      ),
    ),
    GoRoute(
      path: '/add-dog',
      builder: (context, state) => const AddDogScreen(),  
    ),
    GoRoute(
      path: '/edit-dog',
      builder: (context, state) {
        final dog = state.extra as Dog; 
        return EditDogScreen(dog: dog); 
      },
    ),
  ],
);

class DogListScreen extends StatefulWidget {
  const DogListScreen({super.key});

  @override
  State<DogListScreen> createState() => DogListScreenState();
}

class DogListScreenState extends State<DogListScreen> {
  late Future<List<Dog>> futureDogs;

  @override
  void initState() {
    super.initState();
    futureDogs = apiService.fetchDogs(); 
  }

  void refreshDogs() {
    setState(() {
      futureDogs = apiService.fetchDogs(); 
    });
  }

  void navigateToAddDog() async {
    final result = await context.push('/add-dog'); 
    if (result == true) {
      refreshDogs(); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chiens à adopter"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.push('/add-dog'); 
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Dog>>(
        future: futureDogs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final dogs = snapshot.data ?? [];
          if (dogs.isEmpty) {
            return const Center(child: Text("Aucun chien disponible"));
          }

          return ListView.builder(
            itemCount: dogs.length,
            itemBuilder: (context, index) {
              final dog = dogs[index];
              return GestureDetector(
                onTap: () => context.push('/details', extra: dog),
                child: DogCard(
                  dog: dog,
                  onDelete: () {
                    apiService.deleteDog(dog.id).then((_) {
                      refreshDogs(); 
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Chien supprimé')),
                      );
                    });
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class DogCard extends StatelessWidget {
  final Dog dog;
  final VoidCallback onDelete;

  const DogCard({super.key, required this.dog, required this.onDelete});

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
            child: Image.network(
              dog.imageUrl ?? 'assets/default_dog.png',
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
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  '${dog.age} ans | ${dog.color ?? "Inconnu"}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              context.push('/edit-dog', extra: dog); 
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
