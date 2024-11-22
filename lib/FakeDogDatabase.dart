import 'package:projet/model/Dog.dart';
import 'package:projet/model/Owner.dart';

Owner owner =
    Owner("Spikey Sanju", "Developer & Pet Lover", "assets/owner.jpg");
List<Dog> dogList = [
  Dog(
      0,
      "Hachiko",
      3.5,
      "Male",
      "Brown",
      12.9,
      "389m away",
      "assets/orange_dog.png", // Corrigé
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      owner),
  Dog(
      1,
      "Skooby Doo",
      3.5,
      "Male",
      "Gold",
      12.4,
      "412m away",
      "assets/blue_dog.png", // Corrigé
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      owner),
  Dog(
      2,
      "Miss Agnes",
      3.5,
      "Female",
      "White",
      9.6,
      "879m away",
      "assets/red_dog.png", // Corrigé
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      owner),
  Dog(
      3,
      "Cyrus",
      3.5,
      "Male",
      "Black",
      8.2,
      "672m away",
      "assets/yellow_dog.png", // Corrigé
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      owner),
  Dog(
      4,
      "Shelby",
      3.5,
      "Female",
      "Choco",
      14.9,
      "982m away",
      "assets/white_dog.png", // Corrigé
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
      owner)
];
