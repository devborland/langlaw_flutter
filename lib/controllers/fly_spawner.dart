import '../langaw_game.dart';

class FlySpawner {
  FlySpawner(this.game) {
    start();
    game.spawnFly();
  }

  final LangawGame game;

  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 250;
  final int intervalChange = 3;
  final int maxFliesOnScreen = 7;

  int currenntInterval;
  int nextSpawn;

  void start() {
    killAll();
    currenntInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currenntInterval;
  }

  void killAll() {
    game.flies.forEach((fly) => fly.isDead = true);
  }

  void update(double t) {
    int nowTimeStamp = DateTime.now().millisecondsSinceEpoch;
    int livingFlies = 0;
    game.flies.forEach((fly) {
      if (!fly.isDead) livingFlies++;
    });

    if (nowTimeStamp >= nextSpawn && livingFlies < maxFliesOnScreen) {
      game.spawnFly();
      if (currenntInterval > minSpawnInterval) {
        currenntInterval -= intervalChange;
        currenntInterval -= (currenntInterval * 0.02).toInt();
      }
      nextSpawn = nowTimeStamp + currenntInterval;
    }
  }
}
