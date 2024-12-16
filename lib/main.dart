import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet/AddDogScreen.dart';
import 'package:projet/EditDogScreen.dart';
import 'package:projet/model/Owner.dart';
import 'detailscreen_dog.dart';
import 'package:projet/model/Dog.dart';
import 'package:projet/services/api_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const SignUpPage(), // Page d'inscription
    ),
    GoRoute(
      path: '/home',
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

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Déconnexion réussie')),
      );
      context.go('/login');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Une erreur est survenue lors de la déconnexion')),
      );
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
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: signOut,  //deconnecter  
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
//authennnnnnnnnnnnnnnnnnnnnnnnntification
// Page d'inscription
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Compte créé pour $email')),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Une erreur est survenue.';
      if (e.code == 'weak-password') {
        errorMessage = 'Le mot de passe est trop faible.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Cet email est déjà utilisé.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une adresse email';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value;
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      signUp(email!, password!);
                    }
                  },
                  child: const Text("S'inscrire"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Page de Connexion
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bienvenue $email')),
      );
      context.go('/home');
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Une erreur est survenue.';
      if (e.code == 'user-not-found') {
        errorMessage = 'Aucun utilisateur trouvé pour cet email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Mot de passe incorrect.';
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une adresse email';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Mot de passe',
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value;
                },
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      signIn(email!, password!);
                    }
                  },
                  child: const Text("Se connecter"),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  context.push('/sign-up');
                },
                child: const Text("Pas encore inscrit ? S'inscrire"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
