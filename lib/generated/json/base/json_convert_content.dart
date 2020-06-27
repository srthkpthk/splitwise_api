// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:splitwise_api/src/util/data/model/current_user_entity.dart';
import 'package:splitwise_api/generated/json/current_user_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
    switch (type) {			case CurrentUserEntity:
			return currentUserEntityFromJson(data as CurrentUserEntity, json) as T;			case CurrentUserUser:
			return currentUserUserFromJson(data as CurrentUserUser, json) as T;			case CurrentUserUserPicture:
			return currentUserUserPictureFromJson(data as CurrentUserUserPicture, json) as T;			case CurrentUserUserNotifications:
			return currentUserUserNotificationsFromJson(data as CurrentUserUserNotifications, json) as T;    }
    return data as T;
  }

  static _getToJson<T>(Type type, data) {
		switch (type) {			case CurrentUserEntity:
			return currentUserEntityToJson(data as CurrentUserEntity);			case CurrentUserUser:
			return currentUserUserToJson(data as CurrentUserUser);			case CurrentUserUserPicture:
			return currentUserUserPictureToJson(data as CurrentUserUserPicture);			case CurrentUserUserNotifications:
			return currentUserUserNotificationsToJson(data as CurrentUserUserNotifications);    }
    return data as T;
  }
  //Go back to a single instance by type
  static _fromJsonSingle(String type, json) {
    switch (type) {			case 'CurrentUserEntity':
			return CurrentUserEntity().fromJson(json);			case 'CurrentUserUser':
			return CurrentUserUser().fromJson(json);			case 'CurrentUserUserPicture':
			return CurrentUserUserPicture().fromJson(json);			case 'CurrentUserUserNotifications':
			return CurrentUserUserNotifications().fromJson(json);    }
    return null;
  }

  //empty list is returned by type
  static _getListFromType(String type) {
    switch (type) {			case 'CurrentUserEntity':
			return List<CurrentUserEntity>();			case 'CurrentUserUser':
			return List<CurrentUserUser>();			case 'CurrentUserUserPicture':
			return List<CurrentUserUserPicture>();			case 'CurrentUserUserNotifications':
			return List<CurrentUserUserNotifications>();    }
    return null;
  }

  static M fromJsonAsT<M>(json) {
    String type = M.toString();
    if (json is List && type.contains("List<")) {
      String itemType = type.substring(5, type.length - 1);
      List tempList = _getListFromType(itemType);
      json.forEach((itemJson) {
        tempList
            .add(_fromJsonSingle(type.substring(5, type.length - 1), itemJson));
      });
      return tempList as M;
    } else {
      return _fromJsonSingle(M.toString(), json) as M;
    }
  }
}