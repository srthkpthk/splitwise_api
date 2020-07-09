import '../../../../splitwise_api.dart';
import 'friends_entity.dart';

class CurrentUserEntity {
  User _user;

  User get user => _user;

  CurrentUserEntity({User user}) {
    _user = user;
  }

  CurrentUserEntity.fromJson(dynamic json) {
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_user != null) {
      map["user"] = _user.toJson();
    }
    return map;
  }
}

class User {
  int _id;
  String _firstName;
  String _lastName;
  Picture _picture;
  bool _customPicture;
  String _email;
  String _registrationStatus;
  dynamic _forceRefreshAt;
  String _locale;
  String _countryCode;
  String _dateFormat;
  String _defaultCurrency;
  int _defaultGroupId;
  String _notificationsRead;
  int _notificationsCount;
  CureentUserNotifications _notifications;

  int get id => _id;

  String get firstName => _firstName;

  String get lastName => _lastName;

  Picture get picture => _picture;

  bool get customPicture => _customPicture;

  String get email => _email;

  String get registrationStatus => _registrationStatus;

  dynamic get forceRefreshAt => _forceRefreshAt;

  String get locale => _locale;

  String get countryCode => _countryCode;

  String get dateFormat => _dateFormat;

  String get defaultCurrency => _defaultCurrency;

  int get defaultGroupId => _defaultGroupId;

  String get notificationsRead => _notificationsRead;

  int get notificationsCount => _notificationsCount;

  CureentUserNotifications get notifications => _notifications;

  User(
      {int id,
      String firstName,
      String lastName,
      Picture picture,
      bool customPicture,
      String email,
      String registrationStatus,
      dynamic forceRefreshAt,
      String locale,
      String countryCode,
      String dateFormat,
      String defaultCurrency,
      int defaultGroupId,
      String notificationsRead,
      int notificationsCount,
      CureentUserNotifications notifications}) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _picture = picture;
    _customPicture = customPicture;
    _email = email;
    _registrationStatus = registrationStatus;
    _forceRefreshAt = forceRefreshAt;
    _locale = locale;
    _countryCode = countryCode;
    _dateFormat = dateFormat;
    _defaultCurrency = defaultCurrency;
    _defaultGroupId = defaultGroupId;
    _notificationsRead = notificationsRead;
    _notificationsCount = notificationsCount;
    _notifications = notifications;
  }

  User.fromJson(dynamic json) {
    _id = json["id"];
    _firstName = json["firstName"];
    _lastName = json["lastName"];
    _picture =
        json["picture"] != null ? Picture.fromJson(json["picture"]) : null;
    _customPicture = json["customPicture"];
    _email = json["email"];
    _registrationStatus = json["registrationStatus"];
    _forceRefreshAt = json["forceRefreshAt"];
    _locale = json["locale"];
    _countryCode = json["countryCode"];
    _dateFormat = json["dateFormat"];
    _defaultCurrency = json["defaultCurrency"];
    _defaultGroupId = json["defaultGroupId"];
    _notificationsRead = json["notificationsRead"];
    _notificationsCount = json["notificationsCount"];
    _notifications = json["notifications"] != null
        ? CureentUserNotifications.fromJson(json["notifications"])
        : null;
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
    map["email"] = _email;
    map["registrationStatus"] = _registrationStatus;
    map["forceRefreshAt"] = _forceRefreshAt;
    map["locale"] = _locale;
    map["countryCode"] = _countryCode;
    map["dateFormat"] = _dateFormat;
    map["defaultCurrency"] = _defaultCurrency;
    map["defaultGroupId"] = _defaultGroupId;
    map["notificationsRead"] = _notificationsRead;
    map["notificationsCount"] = _notificationsCount;
    if (_notifications != null) {
      map["notifications"] = _notifications.toJson();
    }
    return map;
  }
}

class CureentUserNotifications {
  bool _addedAsFriend;
  bool _addedToGroup;
  bool _expenseAdded;
  bool _expenseUpdated;
  bool _bills;
  bool _payments;
  bool _monthlySummary;
  bool _announcements;

  bool get addedAsFriend => _addedAsFriend;

  bool get addedToGroup => _addedToGroup;

  bool get expenseAdded => _expenseAdded;

  bool get expenseUpdated => _expenseUpdated;

  bool get bills => _bills;

  bool get payments => _payments;

  bool get monthlySummary => _monthlySummary;

  bool get announcements => _announcements;

  CureentUserNotifications(
      {bool addedAsFriend,
      bool addedToGroup,
      bool expenseAdded,
      bool expenseUpdated,
      bool bills,
      bool payments,
      bool monthlySummary,
      bool announcements}) {
    _addedAsFriend = addedAsFriend;
    _addedToGroup = addedToGroup;
    _expenseAdded = expenseAdded;
    _expenseUpdated = expenseUpdated;
    _bills = bills;
    _payments = payments;
    _monthlySummary = monthlySummary;
    _announcements = announcements;
  }

  CureentUserNotifications.fromJson(dynamic json) {
    _addedAsFriend = json["addedAsFriend"];
    _addedToGroup = json["addedToGroup"];
    _expenseAdded = json["expenseAdded"];
    _expenseUpdated = json["expenseUpdated"];
    _bills = json["bills"];
    _payments = json["payments"];
    _monthlySummary = json["monthlySummary"];
    _announcements = json["announcements"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["addedAsFriend"] = _addedAsFriend;
    map["addedToGroup"] = _addedToGroup;
    map["expenseAdded"] = _expenseAdded;
    map["expenseUpdated"] = _expenseUpdated;
    map["bills"] = _bills;
    map["payments"] = _payments;
    map["monthlySummary"] = _monthlySummary;
    map["announcements"] = _announcements;
    return map;
  }
}
