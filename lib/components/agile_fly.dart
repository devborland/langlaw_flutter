import 'dart:ui';

import 'package:flame/sprite.dart';
import 'fly.dart';
import '../langaw_game.dart';

class AgileFly extends Fly {
  double get speed => game.tileSize * 4.5;
  AgileFly(LangawGame game, double x, double y) : super(game) {
    flyingSprite = [];
    flyingSprite.add(Sprite('flies/agile-fly-1.png'));
    flyingSprite.add(Sprite('flies/agile-fly-2.png'));
    deadSprite = Sprite('flies/agile-fly-dead.png');

    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.5, game.tileSize * 1.5);
  }
}
