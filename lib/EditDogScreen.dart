import 'package:flutter/material.dart';
import 'package:projet/model/Dog.dart';
import 'package:projet/model/Owner.dart';
import 'package:projet/services/api_service.dart';

class EditDogScreen extends StatefulWidget {
  final Dog dog;

  const EditDogScreen({super.key, required this.dog});

  @override
  State<EditDogScreen> createState() => _EditDogScreenState();
}

class _EditDogScreenState extends State<EditDogScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController colorController;
  late TextEditingController weightController;
  late TextEditingController locationController;
  late TextEditingController imageUrlController;
  late TextEditingController descriptionController;
  late TextEditingController ownerNameController;
  late TextEditingController ownerBioController;
  late TextEditingController ownerImageUrlController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.dog.name);
    ageController = TextEditingController(text: widget.dog.age.toString());
    colorController = TextEditingController(text: widget.dog.color ?? '');
    weightController = TextEditingController(text: widget.dog.weight?.toString() ?? '');
    locationController = TextEditingController(text: widget.dog.location ?? '');
    imageUrlController = TextEditingController(text: widget.dog.imageUrl ?? '');
    descriptionController = TextEditingController(text: widget.dog.description ?? '');
    ownerNameController = TextEditingController(text: widget.dog.owner.name);
    ownerBioController = TextEditingController(text: widget.dog.owner.bio);
    ownerImageUrlController = TextEditingController(text: widget.dog.owner.imageUrl ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    colorController.dispose();
    weightController.dispose();
    locationController.dispose();
    imageUrlController.dispose();
    descriptionController.dispose();
    ownerNameController.dispose();
    ownerBioController.dispose();
    ownerImageUrlController.dispose();
    super.dispose();
  }

  Future<void> updateDog() async {
    if (_formKey.currentState!.validate()) {
      final updatedDog = Dog(
        id: widget.dog.id,
        name: nameController.text,
        age: double.parse(ageController.text),
        gender: widget.dog.gender,
        color: colorController.text.isNotEmpty ? colorController.text : null,
        weight: weightController.text.isNotEmpty ? double.parse(weightController.text) : null,
        location: locationController.text.isNotEmpty ? locationController.text : null,
        imageUrl: imageUrlController.text.isNotEmpty ? imageUrlController.text : null,
        description: descriptionController.text.isNotEmpty ? descriptionController.text : null,
        owner: Owner(
          name: ownerNameController.text,
          bio: ownerBioController.text,
          imageUrl: ownerImageUrlController.text.isNotEmpty ? ownerImageUrlController.text : null,
        ),
      );

      await ApiService().updateDog(updatedDog); 
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chien modifié avec succès')),
      );
      Navigator.pop(context); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Modifier un chien")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
             
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nom"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Le nom est obligatoire" : null,
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(labelText: "Âge"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || double.tryParse(value) == null ? "Entrez un âge valide" : null,
              ),
              TextFormField(
                controller: colorController,
                decoration: const InputDecoration(labelText: "Couleur"),
              ),
              TextFormField(
                controller: weightController,
                decoration: const InputDecoration(labelText: "Poids"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(labelText: "Localisation"),
              ),
              TextFormField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: "Image URL"),
              ),
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextFormField(
                controller: ownerNameController,
                decoration: const InputDecoration(labelText: "Nom du propriétaire"),
              ),
              TextFormField(
                controller: ownerBioController,
                decoration: const InputDecoration(labelText: "Bio du propriétaire"),
              ),
              TextFormField(
                controller: ownerImageUrlController,
                decoration: const InputDecoration(labelText: "Image du propriétaire"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateDog,
                child: const Text("Modifier"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
