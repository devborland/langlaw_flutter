import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';
import 'package:langaw_flutter/view.dart';

import 'fly.dart';

class Callout {
  final Fly fly;
  Rect rect;
  Sprite sprite;
  double value;

  TextPainter textPainter;
  TextStyle textStyle;
  Offset textOffset;

  Callout(this.fly) {
    sprite = Sprite('ui/callout.png');
    value = 1;
    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xFF000000),
      fontSize: 15,
    );
  }

  void render(Canvas canvas) {
    sprite.renderRect(canvas, rect);
    textPainter.paint(canvas, textOffset);
  }

  void update(double t) {
    if (fly.game.activeView == View.playing) {
      value -= t * 0.2;
      if (value <= 0) {
        fly.game.activeView = View.lost;
      }
    }

    rect = Rect.fromLTWH(
      fly.flyRect.left - fly.game.tileSize * 0.25,
      fly.flyRect.top - fly.game.tileSize * 0.5,
      fly.game.tileSize * 0.75,
      fly.game.tileSize * 0.75,
    );

    textPainter.text = TextSpan(
      text: (value * 10).toInt().toString(),
      style: textStyle,
    );

    textPainter.layout();
    textOffset = Offset(
      rect.center.dx - textPainter.width * 0.5,
      rect.top + rect.height * 0.4 - textPainter.height * 0.5,
    );
  }
}
