import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';

import 'components/fly.dart';
import 'components/backyard.dart';
import 'components/house_fly.dart';
import 'components/agile_fly.dart';
import 'components/macho_fly.dart';
import 'components/hungry_fly.dart';
import 'components/drooler_fly.dart';

class LangawGame extends Game {
  LangawGame() {
    initialize();
  }

  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;
  Backyard background;

  void render(Canvas canvas) {
    background.render(canvas);
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

    background = Backyard(this);
    spawnFly();
  }

  void spawnFly() {
    double x = rnd.nextDouble() * (screenSize.width - tileSize * 2.025);
    double y = rnd.nextDouble() * (screenSize.height - tileSize * 2.025);

    switch (rnd.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
      case 2:
        flies.add(AgileFly(this, x, y));
        break;
      case 3:
        flies.add(MachoFly(this, x, y));
        break;
      case 4:
        flies.add(HungryFly(this, x, y));
        break;
    }
  }

  void onTapDown(TapDownDetails d) {
    flies.forEach((fly) {
      if (fly.flyRect.contains(d.globalPosition)) {
        fly.onTapDown();
      }
    });
  }
}
