
class Picture {

  final String medium;

  Picture.fromJsonMap(Map<String, dynamic> map):
        medium = map["medium"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medium'] = medium;
    return data;
  }
}
