import 'dart:ui';

import 'package:flutter/painting.dart';
import '../langaw_game.dart';

class ScoreDisplay {
  final LangawGame game;
  TextPainter painter;
  TextStyle textStyle;
  Offset position;

  ScoreDisplay(this.game) {
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textStyle = TextStyle(
      color: Color(0xFFFFFFFF),
      fontSize: 80,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xFF000000),
          offset: Offset(3.0, 3.0),
        )
      ],
    );

    position = Offset.zero;
  }

  void render(Canvas canvas) {
    painter.paint(canvas, position);
  }

  void update(double t) {
    if ((painter.text ?? '') != game.score.toString()) {
      painter.text = TextSpan(
        text: game.score.toString(),
        style: textStyle,
      );

      painter.layout();

      position = Offset(
        game.screenSize.width / 2 - painter.width / 2,
        game.screenSize.height / 10 - painter.height / 2,
      );
    }
  }
}
