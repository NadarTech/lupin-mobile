class CategoryModel {
  int id;
  String title;
  DateTime createdAt;
  List<TemplateModel> templates;

  CategoryModel({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.templates,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    title: json["title"],
    createdAt: DateTime.parse(json["createdAt"]),
    templates: List<TemplateModel>.from(json["templates"].map((x) => TemplateModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "createdAt": createdAt.toIso8601String(),
    "templates": List<dynamic>.from(templates.map((x) => x.toJson())),
  };
}

class TemplateModel {
  int id;
  String template;
  String video;
  String title;
  String? thumbnail;
  String? videoUrl;
  int coins;
  String? prompt;
  int categoryId;
  DateTime createdAt;
  int? number;

  TemplateModel({
    required this.id,
    required this.template,
    required this.video,
    required this.title,
    this.thumbnail,
    this.videoUrl,
    required this.coins,
    required this.prompt,
    required this.categoryId,
    required this.createdAt,
    this.number,
  });

  factory TemplateModel.fromJson(Map<String, dynamic> json) => TemplateModel(
    id: json["id"],
    template: json["template"],
    video: json["video"],
    title: json["title"],
    thumbnail: json["thumbnail"],
    videoUrl: json["videoUrl"],
    coins: json["coins"],
    number: json["number"],
    prompt: json["prompt"],
    categoryId: json["categoryId"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "template": template,
    "video": video,
    "title": title,
    "coins": coins,
    "prompt": prompt,
    "categoryId": categoryId,
    "createdAt": createdAt.toIso8601String(),
  };
}
