/// name : "1"
/// age : 12
/// sex : 0

class Person {
  String _name;
  int _age;
  int _sex;

  String get name => _name;
  int get age => _age;
  int get sex => _sex;

  Person({
      String name, 
      int age, 
      int sex}){
    _name = name;
    _age = age;
    _sex = sex;
}

  Person.fromJson(dynamic json) {
    _name = json["name"];
    _age = json["age"];
    _sex = json["sex"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = _name;
    map["age"] = _age;
    map["sex"] = _sex;
    return map;
  }

}