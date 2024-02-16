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
