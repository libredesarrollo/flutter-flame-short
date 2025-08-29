import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shortflame/utils/create_animation_by_limit.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MySprite extends SpriteComponent with HasGameReference {
  MySprite() : super(size: Vector2.all(16));

  late double screenWidth;
  late double screenHeight;

  late double centerX;
  late double centerY;

  final double spriteWidth = 128.0;
  final double spriteHeight = 128.0;

  @override
  void update(double dt) {
    // print(dt);
    // position = Vector2(centerX++, centerY++);
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = await Sprite.load('tiger.png');

    screenWidth = game.size.x;
    screenHeight = game.size.y;

    size = Vector2(spriteWidth, spriteHeight);

    centerX = (screenWidth / 2);
    centerY = (screenHeight / 2);
    position = Vector2(centerX, centerY);

    return super.onLoad();
  }
}

class MySpriteSheet extends SpriteComponent with HasGameReference {
  MySpriteSheet() : super(size: Vector2.all(256));

  late double centerX;
  late double centerY;

  late double screenWidth;
  late double screenHeight;

  final double spriteWidth = 680.0;
  final double spriteHeight = 472.0;

  @override
  void update(double dt) {
    // position = Vector2(centerX++, centerY++);
    super.update(dt);
  }

  @override
  FutureOr<void> onLoad() async {
    screenWidth = game.size.x;
    screenHeight = game.size.y;

    var spriteImages = await Flame.images.load('dinofull.png');

    final spriteSheet = SpriteSheet(
      image: spriteImages,
      srcSize: Vector2(spriteWidth, spriteHeight),
    );

    sprite = spriteSheet.getSprite(1, 0);

    centerX = (screenWidth / 2);
    centerY = (screenHeight / 2);
    position = Vector2(centerX, centerY);

    return super.onLoad();
  }
}

class MySpriteAnimationSheet extends SpriteAnimationComponent
    with HasGameReference, TapCallbacks, KeyboardHandler {
  MySpriteAnimationSheet() : super(size: Vector2.all(256));

  late double centerX;
  late double centerY;

  late double screenWidth;
  late double screenHeight;

  final double spriteWidth = 680.0;
  final double spriteHeight = 472.0;

  int animationIndex = 0;

  late SpriteAnimation dinoAnimation;
  late SpriteAnimation deadAnimation;
  late SpriteAnimation idleAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation runAnimation;
  late SpriteAnimation walkAnimation;

  bool right = true;

  @override
  void update(double dt) {
    // position = Vector2(centerX++, centerY++);
    super.update(dt);
  }

  // @override
  // void onTapUp(TapUpEvent event) {
  //   // print("Player tap up on ${event.localPosition}");
  //   animationIndex++;
  //   if (animationIndex > 4) animationIndex = 0;
  //   switch (animationIndex) {
  //     case 1:
  //       animation = idleAnimation;
  //       break;
  //     case 2:
  //       animation = jumpAnimation;
  //       break;
  //     case 3:
  //       animation = walkAnimation;
  //       break;
  //     case 4:
  //       animation = runAnimation;
  //       break;
  //     case 0:
  //     default:
  //       animation = deadAnimation;
  //       break;
  //   }
  //   super.onTapUp(event);
  // }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.isEmpty) {
      animation = idleAnimation;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight) ||
        keysPressed.contains(LogicalKeyboardKey.keyD)) {
      animation = walkAnimation;
      // flipHorizontally();
      if (!right) flipHorizontally();
      right = true;

      position.x += 5;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) ||
        keysPressed.contains(LogicalKeyboardKey.keyA)) {
      animation = walkAnimation;
      if (right) flipHorizontally();
      right = false;
      position.x -= 5;
    }
    return true;
  }

  @override
  FutureOr<void> onLoad() async {
    screenWidth = game.size.x;
    screenHeight = game.size.y;

    anchor = Anchor.center;

    var spriteImages = await Flame.images.load('dinofull.png');

    final spriteSheet = SpriteSheet(
      image: spriteImages,
      srcSize: Vector2(spriteWidth, spriteHeight),
    );

    // sprite = spriteSheet.getSprite(1, 0);

    dinoAnimation = spriteSheet.createAnimationByLimit(
      xInit: 0,
      yInit: 0,
      step: 10,
      sizeX: 5,
      stepTime: .08,
    );
    deadAnimation = spriteSheet.createAnimationByLimit(
      xInit: 0,
      yInit: 0,
      step: 8,
      sizeX: 5,
      stepTime: .08,
    );
    idleAnimation = spriteSheet.createAnimationByLimit(
      xInit: 1,
      yInit: 2,
      step: 10,
      sizeX: 5,
      stepTime: .08,
    );
    jumpAnimation = spriteSheet.createAnimationByLimit(
      xInit: 3,
      yInit: 0,
      step: 12,
      sizeX: 5,
      stepTime: .08,
    );
    runAnimation = spriteSheet.createAnimationByLimit(
      xInit: 5,
      yInit: 0,
      step: 8,
      sizeX: 5,
      stepTime: .08,
    );
    walkAnimation = spriteSheet.createAnimationByLimit(
      xInit: 6,
      yInit: 2,
      step: 10,
      sizeX: 5,
      stepTime: .08,
    );
    // end animation
    animation = idleAnimation;

    centerX = (screenWidth / 2);
    centerY = (screenHeight / 2);
    position = Vector2(centerX, centerY);

    return super.onLoad();
  }
}

class MyCircle extends PositionComponent {
  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(100, 500), 50, Paint()..color = Colors.red);

    super.render(canvas);
  }
}

class MyRect extends PositionComponent {
  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(
      Rect.fromCircle(center: Offset(500, 500), radius: 50),
      Paint()..color = Colors.blue,
    );

    super.render(canvas);
  }
}

class MyGame extends FlameGame
    with HasKeyboardHandlerComponents /*with KeyboardEvents, TapDetector*/ {
  @override
  FutureOr<void> onLoad() async {
    // await add(MySprite());
    // await add(MySpriteSheet());
    await add(MySpriteAnimationSheet());
    // await add(MyCircle());
    // await add(MyRect());
    return super.onLoad();
  }
  // @override
  //   void onTapUp(TapUpInfo info) {
  //     print("Player tap up on ${info.eventPosition.global}");
  //     super.onTapUp(info);
  //   }

  // @override
  // KeyEventResult onKeyEvent(
  //   KeyEvent event,
  //   Set<LogicalKeyboardKey> keysPressed,
  // ) {
  //   super.onKeyEvent(event, keysPressed);
  //   //print(keysPressed);
  //   print(event);
  //   return KeyEventResult.handled;
  // }
}

class MyCircle2 extends Game {
  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(100, 500), 50, Paint()..color = Colors.red);
  }

  @override
  void update(double dt) {
    // TODO: implement update
  }
}
