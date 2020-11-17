class UserDetails {
  String name;
  String rating;
  String tournamentsPlayed;
  String tournamentsWon;
  String profileImage;

  UserDetails(
      {this.name,
      this.rating,
      this.tournamentsPlayed,
      this.tournamentsWon,
      this.profileImage});

  UserDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rating = json['rating'];
    tournamentsPlayed = json['tournaments_played'];
    tournamentsWon = json['tournaments_won'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['tournaments_played'] = this.tournamentsPlayed;
    data['tournaments_won'] = this.tournamentsWon;
    data['profile_image'] = this.profileImage;
    return data;
  }
}

