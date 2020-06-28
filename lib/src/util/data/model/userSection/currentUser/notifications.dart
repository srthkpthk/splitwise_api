
class Notifications {

  final bool added_as_friend;
  final bool added_to_group;
  final bool expense_added;
  final bool expense_updated;
  final bool bills;
  final bool payments;
  final bool monthly_summary;
  final bool announcements;

	Notifications.fromJsonMap(Map<String, dynamic> map): 
		added_as_friend = map["added_as_friend"],
		added_to_group = map["added_to_group"],
		expense_added = map["expense_added"],
		expense_updated = map["expense_updated"],
		bills = map["bills"],
		payments = map["payments"],
		monthly_summary = map["monthly_summary"],
		announcements = map["announcements"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['added_as_friend'] = added_as_friend;
		data['added_to_group'] = added_to_group;
		data['expense_added'] = expense_added;
		data['expense_updated'] = expense_updated;
		data['bills'] = bills;
		data['payments'] = payments;
		data['monthly_summary'] = monthly_summary;
		data['announcements'] = announcements;
		return data;
	}
}
