class GenerateByFalAIModel {
  final String prompt;
  final String aspectRatio;
  final String aiModel;
  final String duration;
  final int coins;

  GenerateByFalAIModel({
    required this.prompt,
    required this.aspectRatio,
    required this.duration,
    required this.aiModel,
    required this.coins,
  });

  Map<String, dynamic> toJson() => {
    'prompt': prompt,
    'aspectRatio': aspectRatio,
    'duration': duration,
    'aiModel': aiModel,
    'coins': coins,
  };
}
