class CategoriesEntity {
  List<Categories> _categories;

  List<Categories> get categories => _categories;

  CategoriesEntity({
    List<Categories> categories}) {
    _categories = categories;
  }

  CategoriesEntity.fromJson(dynamic json) {
    if (json["categories"] != null) {
      _categories = [];
      json["categories"].forEach((v) {
        _categories.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_categories != null) {
      map["categories"] = _categories.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Categories {
  int _id;
  String _name;
  String _icon;
  Icon_types _iconTypes;
  List<Subcategories> _subcategories;

  int get id => _id;

  String get name => _name;

  String get icon => _icon;

  Icon_types get iconTypes => _iconTypes;

  List<Subcategories> get subcategories => _subcategories;

  Categories({
    int id,
    String name,
    String icon,
    Icon_types iconTypes,
    List<Subcategories> subcategories}) {
    _id = id;
    _name = name;
    _icon = icon;
    _iconTypes = iconTypes;
    _subcategories = subcategories;
  }

  Categories.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _icon = json["icon"];
    _iconTypes =
    json["iconTypes"] != null ? Icon_types.fromJson(json["iconTypes"]) : null;
    if (json["subcategories"] != null) {
      _subcategories = [];
      json["subcategories"].forEach((v) {
        _subcategories.add(Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["icon"] = _icon;
    if (_iconTypes != null) {
      map["iconTypes"] = _iconTypes.toJson();
    }
    if (_subcategories != null) {
      map["subcategories"] = _subcategories.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Subcategories {
  int _id;
  String _name;
  String _icon;
  Icon_types _iconTypes;

  int get id => _id;

  String get name => _name;

  String get icon => _icon;

  Icon_types get iconTypes => _iconTypes;

  Subcategories({
    int id,
    String name,
    String icon,
    Icon_types iconTypes}) {
    _id = id;
    _name = name;
    _icon = icon;
    _iconTypes = iconTypes;
  }

  Subcategories.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _icon = json["icon"];
    _iconTypes =
    json["iconTypes"] != null ? Icon_types.fromJson(json["iconTypes"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["icon"] = _icon;
    if (_iconTypes != null) {
      map["iconTypes"] = _iconTypes.toJson();
    }
    return map;
  }

}

class Icon_types {
  Slim _slim;
  Square _square;

  Slim get slim => _slim;

  Square get square => _square;

  Icon_types({
    Slim slim,
    Square square}) {
    _slim = slim;
    _square = square;
  }

  Icon_types.fromJson(dynamic json) {
    _slim = json["slim"] != null ? Slim.fromJson(json["slim"]) : null;
    _square = json["square"] != null ? Square.fromJson(json["square"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_slim != null) {
      map["slim"] = _slim.toJson();
    }
    if (_square != null) {
      map["square"] = _square.toJson();
    }
    return map;
  }

}

class Square {
  String _large;
  String _xlarge;

  String get large => _large;

  String get xlarge => _xlarge;

  Square({
    String large,
    String xlarge}) {
    _large = large;
    _xlarge = xlarge;
  }

  Square.fromJson(dynamic json) {
    _large = json["large"];
    _xlarge = json["xlarge"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["large"] = _large;
    map["xlarge"] = _xlarge;
    return map;
  }

}

class Slim {
  String _small;
  String _large;

  String get small => _small;

  String get large => _large;

  Slim({
    String small,
    String large}) {
    _small = small;
    _large = large;
  }

  Slim.fromJson(dynamic json) {
    _small = json["small"];
    _large = json["large"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["small"] = _small;
    map["large"] = _large;
    return map;
  }

}
