class Story{
  String? id;
  String? name;
  String? description;
  String? photoUrl;
  String? createAt;

  Story({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createAt
  });

  factory Story.fromMap(Map<String, dynamic> map){
    return Story(
      id: map['id'],
      name: map['name'],
      createAt: map['createdAt'],
      description: map['description'],
      photoUrl: map['photoUrl']
    );
  }
}