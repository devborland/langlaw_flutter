import 'dart:ui';
import 'package:flame/sprite.dart';

import '../langaw_game.dart';
import '../view.dart';
import 'callout.dart';

class Fly {
  Rect flyRect;
  final LangawGame game;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  double get speed => game.tileSize * 3;
  Offset targetLocation;
  Callout callout;

  Fly(this.game) {
    setTargetLocation();
    callout = Callout(this);
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() *
        (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() *
        (game.screenSize.width - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void render(Canvas canvas) {
    if (isDead) {
      deadSprite.renderRect(canvas, flyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(
        canvas,
        flyRect.inflate(2),
      );
      if (game.activeView == View.playing) callout.render(canvas);
    }
  }

  void update(double t) {
    if (isDead) {
      flyRect = flyRect.translate(0, game.tileSize * t * 8);
    } else {
      flyingSpriteIndex += 30 * t;
      if (flyingSpriteIndex >= 2) {
        flyingSpriteIndex -= 2;
      }

      double stepDistance = speed * t;
      Offset toTarget = targetLocation - Offset(flyRect.left, flyRect.top);

      if (stepDistance < toTarget.distance) {
        Offset stepToTarget = Offset.fromDirection(
          toTarget.direction,
          stepDistance,
        );
        flyRect = flyRect.shift(stepToTarget);
      } else {
        flyRect = flyRect.shift(toTarget);
        setTargetLocation();
      }
      callout.update(t);
    }

    if (flyRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
  }

  void onTapDown() {
    isDead = true;
    game.score++;
  }
}
