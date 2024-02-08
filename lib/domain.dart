class Person {
  String name;
  bool checked;
  Person(this.name, [this.checked = false]);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "checked": checked
    };
  }

  Person fromJson(Map<String, dynamic> jsonNode){
    return Person(
      jsonNode["name"],
      jsonNode["checked"]
      );
  }
}
