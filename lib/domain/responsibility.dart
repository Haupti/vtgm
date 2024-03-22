class Responsibility {
  final String id;
  final String name;
  final String personId;

  Responsibility(
      {required this.id, required this.name, required this.personId});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "personId": personId,
    };
  }

  static Responsibility fromJson(Map<String, dynamic> jsonNode) {
    return Responsibility(
      id: jsonNode["id"],
      name: jsonNode["name"],
      personId: jsonNode["personId"],
    );
  }
}
