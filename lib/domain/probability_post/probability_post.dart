class ProbabilityPost {
  final String chord_ID;
  final String chord_HTML;
  final double probability;
  final String child_path;

  ProbabilityPost(
      {this.chord_ID, this.chord_HTML, this.probability, this.child_path});

  factory ProbabilityPost.fromJson(Map<String, dynamic> json) {
    return ProbabilityPost(
      chord_ID: json['chord_ID'],
      chord_HTML: json['chord_HTML'],
      probability: json['probability'],
      child_path: json['child_path'],
    );
  }
}
