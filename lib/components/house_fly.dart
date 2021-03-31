import 'dart:ui';

import 'package:flame/sprite.dart';
import 'fly.dart';
import '../langaw_game.dart';

class HouseFly extends Fly {
  HouseFly(
    LangawGame game,
    double x,
    double y,
  ) : super(game) {
    flyingSprite = <Sprite>[];
    flyingSprite.addAll([
      Sprite('flies/house-fly-1.png'),
      Sprite('flies/house-fly-2.png'),
    ]);
    deadSprite = Sprite('flies/house-fly-dead.png');

    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.5, game.tileSize * 1.5);
  }
}
