class FResult {
  final int totalAns;
  final int totalWrong;
  final int totalMark;
  final int totalmarkscored;

  FResult(
      {required this.totalAns,
      required this.totalWrong,
      required this.totalMark,
      required this.totalmarkscored});

  // Factory constructor to create an instance from JSON
  factory FResult.fromJson(Map<String, dynamic> json) {
    return FResult(
      totalAns: json['total_ans'] ?? 0,
      totalWrong: json['total_worng'] ??
          0, // Note: 'worng' might be a typo in the original JSON
      totalMark: json['total_mark'] ?? 0,
      totalmarkscored: json['total_marks'] ?? 0,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'total_ans': totalAns,
      'total_worng': totalWrong,
      'total_mark': totalMark,
      'total_marks': totalmarkscored
    };
  }

  // You might want to add copyWith method for immutability
  FResult copyWith({
    int? totalAns,
    int? totalWrong,
    int? totalMark,
  }) {
    return FResult(
      totalAns: totalAns ?? this.totalAns,
      totalWrong: totalWrong ?? this.totalWrong,
      totalMark: totalMark ?? this.totalMark,
      totalmarkscored: totalmarkscored ?? this.totalmarkscored,
    );
  }

  @override
  String toString() {
    return 'FResult{totalAns: $totalAns, totalWrong: $totalWrong, totalMark: $totalMark}';
  }
}
