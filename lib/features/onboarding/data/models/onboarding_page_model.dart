import 'package:equatable/equatable.dart';

class OnboardingPageModel extends Equatable {
  const OnboardingPageModel({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.tag,
  });

  final String title;
  final String subtitle;
  final String imagePath;
  final String tag;

  @override
  List<Object?> get props => [title, subtitle, imagePath, tag];
}
