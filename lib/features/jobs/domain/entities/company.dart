class Company {
  final String id;
  final String name;
  final String? address;
  final String? website;
  final String? description;
  final String? industry;
  final String? size;
  final String? location;

  Company({
    required this.id,
    required this.name,
    this.address,
    this.website,
    this.description,
    this.industry,
    this.size,
    this.location,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'],
      website: json['website'],
      description: json['description'],
      industry: json['industry'],
      size: json['size'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'website': website,
      'description': description,
      'industry': industry,
      'size': size,
      'location': location,
    };
  }
}
