import 'dart:ui';
import 'package:flame/sprite.dart';
import '../langaw_game.dart';

class HomeViews {
  final LangawGame game;
  Rect titleRect;
  Sprite titleSprite;

  HomeViews(this.game) {
    titleRect = Rect.fromLTWH(
      game.tileSize,
      game.screenSize.height / 2 - game.tileSize * 4,
      game.tileSize * 7,
      game.tileSize * 4,
    );

    titleSprite = Sprite('branding/title.png');
    // titleSprite = Sprite('ui/start-button.png');
  }

  void render(Canvas c) {
    titleSprite.renderRect(c, titleRect);
  }

  void update(double t) {}
}
