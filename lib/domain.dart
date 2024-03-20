class Person {
  String id;
  String name;
  bool checked;
  int currentDelays;
  Person(this.id, this.name, [this.checked = false, this.currentDelays = 0]);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "checked": checked,
      "currentDelays": currentDelays,
    };
  }

  static Person fromJson(Map<String, dynamic> jsonNode) {
    return Person(
      jsonNode["id"],
      jsonNode["name"],
      jsonNode["checked"],
      jsonNode["currentDelays"],
    );
  }
}

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
