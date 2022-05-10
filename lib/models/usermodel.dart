class FreelancerModel {
  String id;
  String name;
  String email;
  String mobileNo;
  String Avatar;
  String banner;
  List<PastBooking> pastBookings;
  List<UpcomingBooking> upcomingBookings;
  List<BookMark> bookmarks;

  FreelancerModel(
    this.id,
    this.name,
    this.email,
    this.mobileNo,
    this.Avatar,
    this.banner,
    this.pastBookings,
    this.upcomingBookings,
    this.bookmarks,
  );

  factory FreelancerModel.fromJson(Map<String, dynamic> json) {
    Iterable list = json['upcomingBookings'];
    Iterable nlist = json['pastBookings'];
    Iterable clist = json['bookmarks'];

    print(list);
    return FreelancerModel(
        json['_id'] as String,
        json['name'] as String,
        json['email'] as String,
        json['mobileNo'] as String,
        json['Avatar'] as String,
        json['banner'] as String,
        nlist.map((e) => PastBooking.fromJson(e)).toList(),
        list.map((e) => UpcomingBooking.fromJson(e)).toList(),
        clist.map((e) => BookMark.fromJson(e)).toList());
  }
}

class UpcomingBooking {
  String freelancerId;
  String freelancerName;
  String freelancerEmail;
  String mobileNo;
  String bio;
  String avatar;

  UpcomingBooking({
    required this.freelancerId,
    required this.freelancerName,
    required this.freelancerEmail,
    required this.mobileNo,
    required this.bio,
    required this.avatar,
  });
  factory UpcomingBooking.fromJson(Map<String, dynamic> json) {
    return UpcomingBooking(
      freelancerId: json['freelancerId'],
      freelancerName: json['freelancerName'],
      freelancerEmail: json['freelancerEmail'],
      mobileNo: json['mobileNo'],
      bio: json['bio'],
      avatar: json['Avatar'],
    );
  }
}

class PastBooking {
  String freelancerId;
  String freelancerName;
  String freelancerEmail;
  String mobileNo;
  String bio;
  String avatar;

  PastBooking({
    required this.freelancerId,
    required this.freelancerName,
    required this.freelancerEmail,
    required this.mobileNo,
    required this.bio,
    required this.avatar,
  });
  factory PastBooking.fromJson(Map<String, dynamic> json) {
    return PastBooking(
      freelancerId: json['freelancerId'],
      freelancerName: json['freelancerName'],
      freelancerEmail: json['freelancerEmail'],
      mobileNo: json['mobileNo'],
      bio: json['bio'],
      avatar: json['Avatar'],
    );
  }
}

class BookMark {
  String freelancerId;
  String freelancerName;
  String freelancerEmail;
  String Avatar;

  BookMark({
    required this.freelancerId,
    required this.freelancerName,
    required this.freelancerEmail,
    required this.Avatar,
  });
  factory BookMark.fromJson(Map<String, dynamic> json) {
    return BookMark(
      freelancerId: json['freelancerId'],
      freelancerName: json['freelancerName'],
      freelancerEmail: json['freelancerEmail'],
      Avatar: json['Avatar'],
    );
  }
}
