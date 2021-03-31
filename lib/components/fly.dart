import 'dart:ui';
import 'package:flame/sprite.dart';

import '../langaw_game.dart';

class Fly {
  Rect flyRect;
  // Paint flyPaint;
  final LangawGame game;
  bool isDead = false;
  bool isOffScreen = false;
  List<Sprite> flyingSprite;
  Sprite deadSprite;
  double flyingSpriteIndex = 0;
  double get speed => game.tileSize * 3;
  Offset targetLocation;

  Fly(
    this.game,
    // double x,
    // double y,
  ) {
    // flyRect = Rect.fromLTWH(x, y, game.tileSize, game.tileSize);
    // flyPaint = Paint();
    // flyPaint.color = Color(0xff6ab04c);
    setTargetLocation();
  }

  void setTargetLocation() {
    double x = game.rnd.nextDouble() *
        (game.screenSize.width - (game.tileSize * 2.025));
    double y = game.rnd.nextDouble() *
        (game.screenSize.width - (game.tileSize * 2.025));
    targetLocation = Offset(x, y);
  }

  void render(Canvas c) {
    // c.drawRect(flyRect, flyPaint);
    if (isDead) {
      deadSprite.renderRect(c, flyRect.inflate(2));
    } else {
      flyingSprite[flyingSpriteIndex.toInt()].renderRect(
        c,
        flyRect.inflate(2),
      );
    }
  }

  void update(double t) {
    if (isDead) {
      flyRect = flyRect.translate(0, game.tileSize * t * 5);
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
    }

    if (flyRect.top > game.screenSize.height) {
      isOffScreen = true;
    }
  }

  void onTapDown() {
    //  flyPaint.color = Color(0xffff4757);
    if (isDead == false) {
      isDead = true;
      game.spawnFly();
    }
  }
}
