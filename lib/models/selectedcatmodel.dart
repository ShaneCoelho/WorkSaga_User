class SelectedCategoriesModel {
  SelectedCategoriesModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.Avatar,
    required this.banner,
    required this.rating
  });
  late final String id;
  late final String name;
  late final String bio;
  late final String Avatar;
  late final String banner;
  late final int rating;

  SelectedCategoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    bio = json['bio'];
    Avatar = json['Avatar'];
    banner = json['banner'];
    rating = json['rating'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['bio'] = bio;
    _data['Avatar'] = Avatar;
    _data['banner'] = banner;
    _data['rating'] = rating;
    return _data;
  }
}

