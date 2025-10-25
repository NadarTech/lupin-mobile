class PopularVideoDetailModel {
  final String sample;

  PopularVideoDetailModel({required this.sample});

  factory PopularVideoDetailModel.fromJson(Map<String, dynamic> json) => PopularVideoDetailModel(
        sample: json['sample'],
      );

  Map<String, dynamic> toJson() => {
        'sample': sample,
      };
}
