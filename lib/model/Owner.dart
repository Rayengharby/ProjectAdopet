class Owner {
  final String name;
  final String bio;
  final String? imageUrl;  

  Owner({
    required this.name,
    required this.bio,
    this.imageUrl,  
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: json['name'],
      bio: json['bio'],
      imageUrl: json['imageUrl'],  
    );
  }
}
