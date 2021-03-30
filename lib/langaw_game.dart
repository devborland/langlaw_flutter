import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

import 'fly.dart';

class LangawGame extends Game {
  LangawGame() {
    initialize();
  }

  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;

  void render(Canvas canvas) {
    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color.fromRGBO(34, 47, 62, 1);
    canvas.drawRect(bgRect, bgPaint);

    flies.forEach((fly) => fly.render(canvas));
  }

  void update(double t) {
    flies.forEach((fly) => fly.update(t));
    flies.removeWhere((fly) => fly.isOffScreen);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
  }

  void initialize() async {
    rnd = Random();
    flies = <Fly>[];
    resize(await Flame.util.initialDimensions());

    spawnFly();
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize);
    double y = rnd.nextDouble() * (screenSize.height - tileSize);
    flies.add(Fly(this, x, y));
  }

  void onTapDown(TapDownDetails d) {
    flies.forEach((fly) {
      if (fly.flyRect.contains(d.globalPosition)) {
        fly.onTapDown();
      }
    });
  }
}
