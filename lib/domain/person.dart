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
