class Plant {
  final String image;
  final String nickname;
  final String name;

  Plant({required this.image, required this.nickname, required this.name});

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      image: json['image'] as String,
      nickname: json['nickname'] as String,
      name: json['name'] as String,
    );
  }
}
