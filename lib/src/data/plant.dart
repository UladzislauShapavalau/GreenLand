import 'package:equatable/equatable.dart';

final class Plant extends Equatable {
  const Plant({
    required this.image,
    required this.nickname,
    required this.name,
  });

  final String image;
  final String nickname;
  final String name;

  @override
  List<Object?> get props => [image, nickname, name];
}
