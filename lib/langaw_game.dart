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
import 'components/start_button.dart';
import 'components/help_button.dart';
import 'components/credits_button.dart';

import 'view.dart';
import 'views/home_view.dart';
import 'views/lost_view.dart';
import 'views/help_view.dart';
import 'views/credits_view.dart';

import 'controllers/fly_spawner.dart';

class LangawGame extends Game {
  LangawGame() {
    initialize();
  }

  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Random rnd;
  Backyard background;
  View activeView = View.home;
  HomeViews homeViews;
  StartButton startButton;
  LostView lostView;
  FlySpawner spawner;
  HelpButton helpButton;
  CreditsButton creditsButton;
  HelpView helpView;
  CreditsView creditsView;

  void initialize() async {
    rnd = Random();
    flies = <Fly>[];

    resize(await Flame.util.initialDimensions());

    background = Backyard(this);
    homeViews = HomeViews(this);
    startButton = StartButton(this);
    lostView = LostView(this);
    spawner = FlySpawner(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);
  }

  void render(Canvas canvas) {
    background.render(canvas);
    flies.forEach((fly) => fly.render(canvas));

    if (activeView == View.home) {
      homeViews.render(canvas);
    }

    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }

    if (activeView == View.lost) lostView.render(canvas);
    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditsView.render(canvas);
  }

  void update(double t) {
    flies.forEach((fly) => fly.update(t));
    flies.removeWhere((fly) => fly.isOffScreen);
    spawner.update(t);
  }

  void resize(Size size) {
    screenSize = size;
    tileSize = screenSize.width / 9;
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
    bool didHitFly = false;

    if (startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        startButton.onTapDown();
        return;
      }
    }

    if (activeView == View.playing) {
      flies.forEach((fly) {
        if (fly.flyRect.contains(d.globalPosition)) {
          didHitFly = true;
          fly.onTapDown();
          return;
        }
      });
      if (activeView == View.playing && !didHitFly) {
        activeView = View.lost;
      }
    }

    if (helpButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        return;
      }
    }

    if (creditsButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        return;
      }
    }

    if (activeView == View.help || activeView == View.credits) {
      activeView = View.home;
      return;
    }
  }
}
