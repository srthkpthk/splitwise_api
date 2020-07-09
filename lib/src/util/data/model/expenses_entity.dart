import '../../../../splitwise_api.dart';

class ExpensesEntity {
  List<Expenses> _expenses;

  List<Expenses> get expenses => _expenses;

  ExpensesEntity({List<Expenses> expenses}) {
    _expenses = expenses;
  }

  ExpensesEntity.fromJson(dynamic json) {
    if (json["expenses"] != null) {
      _expenses = [];
      json["expenses"].forEach((v) {
        _expenses.add(Expenses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_expenses != null) {
      map["expenses"] = _expenses.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Expenses {
  int _id;
  dynamic _groupId;
  dynamic _friendshipId;
  dynamic _expenseBundleId;
  String _description;
  bool _repeats;
  String _repeatInterval;
  bool _emailReminder;
  int _emailReminderInAdvance;
  dynamic _nextRepeat;
  String _details;
  int _commentsCount;
  bool _payment;
  String _creationMethod;
  String _transactionMethod;
  bool _transactionConfirmed;
  dynamic _transactionId;
  String _cost;
  String _currencyCode;
  List<Repayments> _repayments;
  String _date;
  String _createdAt;
  Created_by _createdBy;
  String _updatedAt;
  dynamic _updatedBy;
  dynamic _deletedAt;
  dynamic _deletedBy;
  Category _category;
  Receipt _receipt;
  List<Users> _users;

  int get id => _id;

  dynamic get groupId => _groupId;

  dynamic get friendshipId => _friendshipId;

  dynamic get expenseBundleId => _expenseBundleId;

  String get description => _description;

  bool get repeats => _repeats;

  String get repeatInterval => _repeatInterval;

  bool get emailReminder => _emailReminder;

  int get emailReminderInAdvance => _emailReminderInAdvance;

  dynamic get nextRepeat => _nextRepeat;

  String get details => _details;

  int get commentsCount => _commentsCount;

  bool get payment => _payment;

  String get creationMethod => _creationMethod;

  String get transactionMethod => _transactionMethod;

  bool get transactionConfirmed => _transactionConfirmed;

  dynamic get transactionId => _transactionId;

  String get cost => _cost;

  String get currencyCode => _currencyCode;

  List<Repayments> get repayments => _repayments;

  String get date => _date;

  String get createdAt => _createdAt;

  Created_by get createdBy => _createdBy;

  String get updatedAt => _updatedAt;

  dynamic get updatedBy => _updatedBy;

  dynamic get deletedAt => _deletedAt;

  dynamic get deletedBy => _deletedBy;

  Category get category => _category;

  Receipt get receipt => _receipt;

  List<Users> get users => _users;

  Expenses(
      {int id,
      dynamic groupId,
      dynamic friendshipId,
      dynamic expenseBundleId,
      String description,
      bool repeats,
      String repeatInterval,
      bool emailReminder,
      int emailReminderInAdvance,
      dynamic nextRepeat,
      String details,
      int commentsCount,
      bool payment,
      String creationMethod,
      String transactionMethod,
      bool transactionConfirmed,
      dynamic transactionId,
      String cost,
      String currencyCode,
      List<Repayments> repayments,
      String date,
      String createdAt,
      Created_by createdBy,
      String updatedAt,
      dynamic updatedBy,
      dynamic deletedAt,
      dynamic deletedBy,
      Category category,
      Receipt receipt,
      List<Users> users}) {
    _id = id;
    _groupId = groupId;
    _friendshipId = friendshipId;
    _expenseBundleId = expenseBundleId;
    _description = description;
    _repeats = repeats;
    _repeatInterval = repeatInterval;
    _emailReminder = emailReminder;
    _emailReminderInAdvance = emailReminderInAdvance;
    _nextRepeat = nextRepeat;
    _details = details;
    _commentsCount = commentsCount;
    _payment = payment;
    _creationMethod = creationMethod;
    _transactionMethod = transactionMethod;
    _transactionConfirmed = transactionConfirmed;
    _transactionId = transactionId;
    _cost = cost;
    _currencyCode = currencyCode;
    _repayments = repayments;
    _date = date;
    _createdAt = createdAt;
    _createdBy = createdBy;
    _updatedAt = updatedAt;
    _updatedBy = updatedBy;
    _deletedAt = deletedAt;
    _deletedBy = deletedBy;
    _category = category;
    _receipt = receipt;
    _users = users;
  }

  Expenses.fromJson(dynamic json) {
    _id = json["id"];
    _groupId = json["groupId"];
    _friendshipId = json["friendshipId"];
    _expenseBundleId = json["expenseBundleId"];
    _description = json["description"];
    _repeats = json["repeats"];
    _repeatInterval = json["repeatInterval"];
    _emailReminder = json["emailReminder"];
    _emailReminderInAdvance = json["emailReminderInAdvance"];
    _nextRepeat = json["nextRepeat"];
    _details = json["details"];
    _commentsCount = json["commentsCount"];
    _payment = json["payment"];
    _creationMethod = json["creationMethod"];
    _transactionMethod = json["transactionMethod"];
    _transactionConfirmed = json["transactionConfirmed"];
    _transactionId = json["transactionId"];
    _cost = json["cost"];
    _currencyCode = json["currencyCode"];
    if (json["repayments"] != null) {
      _repayments = [];
      json["repayments"].forEach((v) {
        _repayments.add(Repayments.fromJson(v));
      });
    }
    _date = json["date"];
    _createdAt = json["createdAt"];
    _createdBy = json["createdBy"] != null
        ? Created_by.fromJson(json["createdBy"])
        : null;
    _updatedAt = json["updatedAt"];
    _updatedBy = json["updatedBy"];
    _deletedAt = json["deletedAt"];
    _deletedBy = json["deletedBy"];
    _category =
        json["category"] != null ? Category.fromJson(json["category"]) : null;
    _receipt =
        json["receipt"] != null ? Receipt.fromJson(json["receipt"]) : null;
    if (json["users"] != null) {
      _users = [];
      json["users"].forEach((v) {
        _users.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["groupId"] = _groupId;
    map["friendshipId"] = _friendshipId;
    map["expenseBundleId"] = _expenseBundleId;
    map["description"] = _description;
    map["repeats"] = _repeats;
    map["repeatInterval"] = _repeatInterval;
    map["emailReminder"] = _emailReminder;
    map["emailReminderInAdvance"] = _emailReminderInAdvance;
    map["nextRepeat"] = _nextRepeat;
    map["details"] = _details;
    map["commentsCount"] = _commentsCount;
    map["payment"] = _payment;
    map["creationMethod"] = _creationMethod;
    map["transactionMethod"] = _transactionMethod;
    map["transactionConfirmed"] = _transactionConfirmed;
    map["transactionId"] = _transactionId;
    map["cost"] = _cost;
    map["currencyCode"] = _currencyCode;
    if (_repayments != null) {
      map["repayments"] = _repayments.map((v) => v.toJson()).toList();
    }
    map["date"] = _date;
    map["createdAt"] = _createdAt;
    if (_createdBy != null) {
      map["createdBy"] = _createdBy.toJson();
    }
    map["updatedAt"] = _updatedAt;
    map["updatedBy"] = _updatedBy;
    map["deletedAt"] = _deletedAt;
    map["deletedBy"] = _deletedBy;
    if (_category != null) {
      map["category"] = _category.toJson();
    }
    if (_receipt != null) {
      map["receipt"] = _receipt.toJson();
    }
    if (_users != null) {
      map["users"] = _users.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Users {
  ExpenseUser _user;
  int _userId;
  String _paidShare;
  String _owedShare;
  String _netBalance;

  ExpenseUser get user => _user;

  int get userId => _userId;

  String get paidShare => _paidShare;

  String get owedShare => _owedShare;

  String get netBalance => _netBalance;

  Users(
      {ExpenseUser user,
      int userId,
      String paidShare,
      String owedShare,
      String netBalance}) {
    _user = user;
    _userId = userId;
    _paidShare = paidShare;
    _owedShare = owedShare;
    _netBalance = netBalance;
  }

  Users.fromJson(dynamic json) {
    _user = json["user"] != null ? ExpenseUser.fromJson(json["user"]) : null;
    _userId = json["userId"];
    _paidShare = json["paidShare"];
    _owedShare = json["owedShare"];
    _netBalance = json["netBalance"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    map["userId"] = _userId;
    map["paidShare"] = _paidShare;
    map["owedShare"] = _owedShare;
    map["netBalance"] = _netBalance;
    return map;
  }
}

class ExpenseUser {
  int _id;
  String _firstName;
  String _lastName;
  Picture _picture;

  int get id => _id;

  String get firstName => _firstName;

  String get lastName => _lastName;

  Picture get picture => _picture;

  ExpenseUser({int id, String firstName, String lastName, Picture picture}) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _picture = picture;
  }

  ExpenseUser.fromJson(dynamic json) {
    _id = json["id"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _picture =
        json["picture"] != null ? Picture.fromJson(json["picture"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    if (_picture != null) {
      map["picture"] = _picture.toJson();
    }
    return map;
  }
}

class Receipt {
  dynamic _large;
  dynamic _original;

  dynamic get large => _large;

  dynamic get original => _original;

  Receipt({dynamic large, dynamic original}) {
    _large = large;
    _original = original;
  }

  Receipt.fromJson(dynamic json) {
    _large = json["large"];
    _original = json["original"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["large"] = _large;
    map["original"] = _original;
    return map;
  }
}

class Category {
  int _id;
  String _name;

  int get id => _id;

  String get name => _name;

  Category({int id, String name}) {
    _id = id;
    _name = name;
  }

  Category.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    return map;
  }
}

class Created_by {
  int _id;
  String _firstName;
  dynamic _lastName;
  Picture _picture;
  bool _customPicture;

  int get id => _id;

  String get firstName => _firstName;

  dynamic get lastName => _lastName;

  Picture get picture => _picture;

  bool get customPicture => _customPicture;

  Created_by(
      {int id,
      String firstName,
      dynamic lastName,
      Picture picture,
      bool customPicture}) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _picture = picture;
    _customPicture = customPicture;
  }

  Created_by.fromJson(dynamic json) {
    _id = json["id"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _picture =
        json["picture"] != null ? Picture.fromJson(json["picture"]) : null;
    _customPicture = json["customPicture"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    if (_picture != null) {
      map["picture"] = _picture.toJson();
    }
    map["customPicture"] = _customPicture;
    return map;
  }
}

class Repayments {
  int _from;
  int _to;
  String _amount;

  int get from => _from;

  int get to => _to;

  String get amount => _amount;

  Repayments({int from, int to, String amount}) {
    _from = from;
    _to = to;
    _amount = amount;
  }

  Repayments.fromJson(dynamic json) {
    _from = json["from"];
    _to = json["to"];
    _amount = json["amount"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["from"] = _from;
    map["to"] = _to;
    map["amount"] = _amount;
    return map;
  }
}
