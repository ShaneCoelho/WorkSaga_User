class FreelancerModel {
  String id;
  String name;
  String email;
  String mobileNo;
  List<PastBooking> pastBookings;
  List<UpcomingBooking> upcomingBookings;

  FreelancerModel(
    this.id,
    this.name,
    this.email,
    this.mobileNo,
    this.pastBookings,
    this.upcomingBookings,
  );

  factory FreelancerModel.fromJson(Map<String, dynamic> json) {
    Iterable list = json['upcomingBookings'];
    print(list);
    return FreelancerModel(
        json['_id'] as String,
        json['name'] as String,
        json['email'] as String,
        json['mobileNo'] as String,
        list.map((e) => PastBooking.fromJson(e)).toList(),
        list.map((e) => UpcomingBooking.fromJson(e)).toList());
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
