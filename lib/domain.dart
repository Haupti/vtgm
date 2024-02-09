class Person {
  String name;
  bool checked;
  int currentDelays; 
  Person(this.name, [this.checked = false, this.currentDelays = 0]);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "checked": checked,
      "currentDelays": currentDelays,
    };
  }

  static Person fromJson(Map<String, dynamic> jsonNode){
    return Person(
      jsonNode["name"],
      jsonNode["checked"],
      jsonNode["currentDelays"],
      );
  }
}
