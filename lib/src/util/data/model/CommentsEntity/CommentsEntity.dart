import 'package:splitwise_api/src/util/data/model/CommentsEntity/comments.dart';

class CommentsEntity {

  final List<Comments> comments;

	CommentsEntity.fromJsonMap(Map<String, dynamic> map): 
		comments = List<Comments>.from(map["comments"].map((it) => Comments.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['comments'] = comments != null ? 
			this.comments.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
