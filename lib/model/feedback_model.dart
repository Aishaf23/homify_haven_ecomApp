class FeedbackModel {
  String userId;
  String name;
  String email;
  String feedback;

  FeedbackModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.feedback,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'feedback': feedback,
    };
  }
}
