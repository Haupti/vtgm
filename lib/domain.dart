class Person {
  String id;
  String name;
  int workoutsPrepared;
  int openFine;
  Person(this.id, this.name, [this.workoutsPrepared = 0, this.openFine = 0]);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "workoutsPrepared": workoutsPrepared,
      "openFine": openFine,
    };
  }

  static Person fromJson(Map<String, dynamic> jsonNode) {
    return Person(
      jsonNode["id"],
      jsonNode["name"],
      jsonNode["workoutsPrepared"],
      jsonNode["openFine"],
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
