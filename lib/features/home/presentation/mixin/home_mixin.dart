import 'package:flutter/material.dart';
import 'package:luden/features/home/presentation/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/consts/gen/assets.gen.dart';
import '../../data/home_model.dart';
import '../view/home_view.dart';

mixin HomeMixin on State<HomeView> {
  int number = 0;

  Future<void> updateUser() async {
    number++;
    if (number == 10) {
      await context.read<HomeViewModel>().updateUser();
    }
  }

  final homeVideos = <HomeModel>[
    HomeModel(
      videoPath: Assets.videos.home.home1,
      title: 'Gorilla Here',
      number: 3245,
      prompt:
          'A playful young gorilla in sun-dappled rainforest, looks at camera, speaks with friendly tone, laughs, then runs and performs a playful jump between two rocks, exaggerated but natural motion, energetic camera tracking, high-detail fur bounce and cloth-like muscle movement, lip-sync and expressive facial animation, Veo3/Hailuo realistic motion style. Sound: warm voice with chuckle, bird song and leaf rustle.',
    ),
    HomeModel(
      videoPath: Assets.videos.home.home2,
      title: 'Red Sea',
      number: 4321,
      prompt: """
          "caption": "POV: Moses trying to record a vlog mid–Red Sea split 🌊📹 #faithvibes #holyshorts",
          "concept": "Moses looks straight into the camera, trying to act calm while walls of water rise dramatically beside him.",
        "setting": "Vast sea corridor glowing in blue light, reflections dancing on wet sand, robes fluttering in the wind.",
        "status": "to produce"
      """,
    ),
    HomeModel(
      videoPath: Assets.videos.home.home3,
      title: 'Baby Interview',
      number: 1004,
      prompt:
          "Scene: Baby in a toy car, gripping the steering wheel seriously, reporter leaning in from the side holding a pastel-colored handheld microphone near the baby's face. Dialogue:—Reporter: Where are you driving to? — Baby:To get ice cream! Visual style: Outdoor sunny day, pastel tones, clear view of microphone.",
    ),
  ];
}
