import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'langaw_game.dart';
import 'package:flutter/gestures.dart';
import 'package:flame/flame.dart';

void main() async {
  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);

  try {
    Flame.images.loadAll(<String>[
      'images/bg/backyard.png',
      'images/flies/agile-fly-1.png',
      'images/flies/agile-fly-2.png',
      'images/flies/agile-fly-dead.png',
      'images/flies/drooler-fly-1.png',
      'images/flies/drooler-fly-2.png',
      'images/flies/drooler-fly-dead.png',
      'images/flies/house-fly-1.png',
      'images/flies/house-fly-2.png',
      'images/flies/house-fly-dead.png',
      'images/flies/hungry-fly-1.png',
      'images/flies/hungry-fly-2.png',
      'images/flies/hungry-fly-dead.png',
      'images/flies/macho-fly-1.png',
      'images/flies/macho-fly-2.png',
      'images/flies/macho-fly-dead.png',
    ]);
  } catch (e) {
    print(e);
  }

  var game = LangawGame();
  runApp(game.widget);

  var tapper = TapGestureRecognizer();
  tapper.onTapDown = game.onTapDown;
  // ignore: deprecated_member_use
  flameUtil.addGestureRecognizer(tapper);
}
