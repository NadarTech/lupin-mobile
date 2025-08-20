class CoinsModel {
  final String sample;

  CoinsModel({required this.sample});

  factory CoinsModel.fromJson(Map<String, dynamic> json) => CoinsModel(
        sample: json['sample'],
      );

  Map<String, dynamic> toJson() => {
        'sample': sample,
      };
}
