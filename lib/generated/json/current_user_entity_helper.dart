import 'package:splitwise_api/src/util/data/model/current_user_entity.dart';

currentUserEntityFromJson(CurrentUserEntity data, Map<String, dynamic> json) {
	if (json['user'] != null) {
		data.user = new CurrentUserUser().fromJson(json['user']);
	}
	return data;
}

Map<String, dynamic> currentUserEntityToJson(CurrentUserEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.user != null) {
		data['user'] = entity.user.toJson();
	}
	return data;
}

currentUserUserFromJson(CurrentUserUser data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id']?.toInt();
	}
	if (json['first_name'] != null) {
		data.firstName = json['first_name']?.toString();
	}
	if (json['last_name'] != null) {
		data.lastName = json['last_name']?.toString();
	}
	if (json['picture'] != null) {
		data.picture = new CurrentUserUserPicture().fromJson(json['picture']);
	}
	if (json['custom_picture'] != null) {
		data.customPicture = json['custom_picture'];
	}
	if (json['email'] != null) {
		data.email = json['email']?.toString();
	}
	if (json['registration_status'] != null) {
		data.registrationStatus = json['registration_status']?.toString();
	}
	if (json['force_refresh_at'] != null) {
		data.forceRefreshAt = json['force_refresh_at'];
	}
	if (json['locale'] != null) {
		data.locale = json['locale']?.toString();
	}
	if (json['country_code'] != null) {
		data.countryCode = json['country_code']?.toString();
	}
	if (json['date_format'] != null) {
		data.dateFormat = json['date_format']?.toString();
	}
	if (json['default_currency'] != null) {
		data.defaultCurrency = json['default_currency']?.toString();
	}
	if (json['default_group_id'] != null) {
		data.defaultGroupId = json['default_group_id']?.toInt();
	}
	if (json['notifications_read'] != null) {
		data.notificationsRead = json['notifications_read']?.toString();
	}
	if (json['notifications_count'] != null) {
		data.notificationsCount = json['notifications_count']?.toInt();
	}
	if (json['notifications'] != null) {
		data.notifications = new CurrentUserUserNotifications().fromJson(json['notifications']);
	}
	return data;
}

Map<String, dynamic> currentUserUserToJson(CurrentUserUser entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['first_name'] = entity.firstName;
	data['last_name'] = entity.lastName;
	if (entity.picture != null) {
		data['picture'] = entity.picture.toJson();
	}
	data['custom_picture'] = entity.customPicture;
	data['email'] = entity.email;
	data['registration_status'] = entity.registrationStatus;
	data['force_refresh_at'] = entity.forceRefreshAt;
	data['locale'] = entity.locale;
	data['country_code'] = entity.countryCode;
	data['date_format'] = entity.dateFormat;
	data['default_currency'] = entity.defaultCurrency;
	data['default_group_id'] = entity.defaultGroupId;
	data['notifications_read'] = entity.notificationsRead;
	data['notifications_count'] = entity.notificationsCount;
	if (entity.notifications != null) {
		data['notifications'] = entity.notifications.toJson();
	}
	return data;
}

currentUserUserPictureFromJson(CurrentUserUserPicture data, Map<String, dynamic> json) {
	if (json['small'] != null) {
		data.small = json['small']?.toString();
	}
	if (json['medium'] != null) {
		data.medium = json['medium']?.toString();
	}
	if (json['large'] != null) {
		data.large = json['large']?.toString();
	}
	return data;
}

Map<String, dynamic> currentUserUserPictureToJson(CurrentUserUserPicture entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['small'] = entity.small;
	data['medium'] = entity.medium;
	data['large'] = entity.large;
	return data;
}

currentUserUserNotificationsFromJson(CurrentUserUserNotifications data, Map<String, dynamic> json) {
	if (json['added_as_friend'] != null) {
		data.addedAsFriend = json['added_as_friend'];
	}
	if (json['added_to_group'] != null) {
		data.addedToGroup = json['added_to_group'];
	}
	if (json['expense_added'] != null) {
		data.expenseAdded = json['expense_added'];
	}
	if (json['expense_updated'] != null) {
		data.expenseUpdated = json['expense_updated'];
	}
	if (json['bills'] != null) {
		data.bills = json['bills'];
	}
	if (json['payments'] != null) {
		data.payments = json['payments'];
	}
	if (json['monthly_summary'] != null) {
		data.monthlySummary = json['monthly_summary'];
	}
	if (json['announcements'] != null) {
		data.announcements = json['announcements'];
	}
	return data;
}

Map<String, dynamic> currentUserUserNotificationsToJson(CurrentUserUserNotifications entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['added_as_friend'] = entity.addedAsFriend;
	data['added_to_group'] = entity.addedToGroup;
	data['expense_added'] = entity.expenseAdded;
	data['expense_updated'] = entity.expenseUpdated;
	data['bills'] = entity.bills;
	data['payments'] = entity.payments;
	data['monthly_summary'] = entity.monthlySummary;
	data['announcements'] = entity.announcements;
	return data;
}