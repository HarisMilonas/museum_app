class Role {
  int? id;
  String title;
  int hierarchy;

  Role({
    this.id,
    required this.title,
    required this.hierarchy,
  });
  // Convert Exhibit object to a map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'hierarchy': hierarchy,
    };
  }

  // Create an Exhibit object from a map
  factory Role.fromMap(Map<String, dynamic> map) => Role(
        id: map['id'],
        title: map['title'],
        hierarchy: map['hierarchy'],
      );
}
