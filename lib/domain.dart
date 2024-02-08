class Person {
  String name;
  Person(this.name);

  Map<String, dynamic> toJson() {
    return {
      "name": name,
    };
  }

  Person fromJson(Map<String, dynamic> jsonNode){
    return Person(jsonNode["name"]);
  }
}
