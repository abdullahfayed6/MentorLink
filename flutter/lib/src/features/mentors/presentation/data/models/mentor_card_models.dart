class MentorModel {
  final String imageUrl;
  final String name;
  final String badge;
  final List<String>? benefit; // like fast responder feature
  final double rating;
  final int reviewsCount;
  final String jobTitle;
  final String jobDescription;
  final int hourlyRate;
  final List<String> skills;

  MentorModel( {
    required this.imageUrl,
    required this.name,
    required this.badge,
    required this.rating,
    required this.reviewsCount,
    required this.jobTitle,
    required this.jobDescription,
    required this.hourlyRate,
    required this.skills,
     this.benefit ,
  });

  factory MentorModel.fromJson(Map<String, dynamic> json) {
    return MentorModel(
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      badge: json['badge'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'] as int,
      jobTitle: json['jobTitle'] as String,
      jobDescription: json['jobDescription'] as String,
      hourlyRate: json['hourlyRate'] as int,
      benefit: json['benefit'] != null ? json['benefit'] as List<String> : null,
      skills: json['skills'],
    );
  }
}
