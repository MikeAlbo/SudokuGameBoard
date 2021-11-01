//  TILE ANIMATIONS
// -----
// Animated container color based on state provided
// Animations should be prebuilt
// should take in a child to be animated of type container
// update state of of playback

import 'package:basic_game/Themes/tile_decoration_themes.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'tile_helper.dart';

// todo: this should be inherited from theme scope
TileDecorationParams tileDecorationParams = TileDecorationParams();

class AnimationMode {
  final Color color;
  final int duration;
  final bool setToComplete;
  AnimationMode(this.color, this.setToComplete, {this.duration = 50});
}

AnimationMode errorAnimation = AnimationMode(
  tileDecorationParams.error,
  false,
  duration: 100,
);
AnimationMode highlightedAnimation = AnimationMode(
  tileDecorationParams.highlighted,
  true,
);
AnimationMode selectedAnimation = AnimationMode(
  tileDecorationParams.selected,
  true,
);
AnimationMode correctAnimation = AnimationMode(
  tileDecorationParams.correct,
  true,
);

AnimationMode completedAnimation = AnimationMode(
  tileDecorationParams.completed,
  true,
);

Tuple3<Color, int, bool> selectAnimation(TileMode tileMode) {
  AnimationMode am;

  switch (tileMode) {
    case TileMode.error:
      {
        am = errorAnimation;
        break;
      }
    case TileMode.selected:
      {
        am = selectedAnimation;
        break;
      }
    case TileMode.highlighted:
      {
        am = highlightedAnimation;
        break;
      }
    case TileMode.correct:
      {
        am = correctAnimation;
        break;
      }
    case TileMode.completed:
      {
        am = completedAnimation;
        break;
      }
    default:
      {
        am = errorAnimation;
      }
  }
  return Tuple3(am.color, am.duration, am.setToComplete);
}
