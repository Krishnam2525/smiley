import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const InteractiveEmojiApp());
}

class InteractiveEmojiApp extends StatelessWidget {
  const InteractiveEmojiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Emoji Drawing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const EmojiDrawingScreen(),
    );
  }
}

class EmojiDrawingScreen extends StatefulWidget {
  const EmojiDrawingScreen({super.key});

  @override
  State<EmojiDrawingScreen> createState() => _EmojiDrawingScreenState();
}

class _EmojiDrawingScreenState extends State<EmojiDrawingScreen> {
  String selectedEmoji = 'Smiley Face';

  final List<String> emojiOptions = [
    'Smiley Face',
    'Party Face',
    'Heart',
    'Winking Face',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF87CEEB), // Sky blue
              Color(0xFFF0F8FF), // Alice blue
            ],
          ),
        ),
        child: Column(
          children: [
            // App Bar with gradient
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 10,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.blue],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.white, Colors.yellow],
                    ).createShader(bounds),
                    child: const Text(
                      'Interactive Emoji Drawing',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Emoji Selection UI
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Choose Your Emoji:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: emojiOptions.map((emoji) {
                      final isSelected = selectedEmoji == emoji;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedEmoji = emoji;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? const LinearGradient(
                                    colors: [Colors.purple, Colors.blue],
                                  )
                                : null,
                            color: isSelected ? null : Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:
                                  isSelected ? Colors.transparent : Colors.grey,
                            ),
                          ),
                          child: Text(
                            emoji,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Drawing Canvas
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CustomPaint(
                    painter: EmojiPainter(selectedEmoji),
                    size: const Size(double.infinity, double.infinity),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmojiPainter extends CustomPainter {
  final String emojiType;

  EmojiPainter(this.emojiType);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Draw background gradient
    final backgroundGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.8,
      colors: [Colors.blue.shade50, Colors.white],
    );

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = backgroundGradient.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        ),
    );

    switch (emojiType) {
      case 'Smiley Face':
        _drawSmileyFace(canvas, Offset(centerX, centerY));
        break;
      case 'Party Face':
        _drawPartyFace(canvas, Offset(centerX, centerY));
        break;
      case 'Heart':
        _drawHeart(canvas, Offset(centerX, centerY));
        break;
      case 'Winking Face':
        _drawWinkingFace(canvas, Offset(centerX, centerY));
        break;
    }
  }

  void _drawSmileyFace(Canvas canvas, Offset center) {
    // Draw the face with gradient
    final faceGradient = RadialGradient(
      colors: [Colors.yellow.shade300, Colors.yellow.shade600],
    );

    final faceRect = Rect.fromCenter(center: center, width: 200, height: 200);
    canvas.drawCircle(
      center,
      100,
      Paint()
        ..shader = faceGradient.createShader(faceRect)
        ..style = PaintingStyle.fill,
    );

    // Face border
    canvas.drawCircle(
      center,
      100,
      Paint()
        ..color = Colors.orange.shade700
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );

    // Left eye
    canvas.drawCircle(
      Offset(center.dx - 30, center.dy - 30),
      12,
      Paint()..color = Colors.black,
    );

    // Right eye
    canvas.drawCircle(
      Offset(center.dx + 30, center.dy - 30),
      12,
      Paint()..color = Colors.black,
    );

    // Smile (arc)
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(center.dx, center.dy + 10), width: 80, height: 60),
      0,
      pi,
      false,
      smilePaint,
    );
  }

  void _drawPartyFace(Canvas canvas, Offset center) {
    // Draw the face
    final faceGradient = RadialGradient(
      colors: [Colors.yellow.shade200, Colors.yellow.shade500],
    );

    final faceRect = Rect.fromCenter(center: center, width: 200, height: 200);
    canvas.drawCircle(
      center,
      100,
      Paint()
        ..shader = faceGradient.createShader(faceRect)
        ..style = PaintingStyle.fill,
    );

    // Face border
    canvas.drawCircle(
      center,
      100,
      Paint()
        ..color = Colors.orange.shade700
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );

    // Party hat
    final hatPath = Path()
      ..moveTo(center.dx - 40, center.dy - 80)
      ..lineTo(center.dx + 40, center.dy - 80)
      ..lineTo(center.dx, center.dy - 140)
      ..close();

    final hatGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.purple.shade700, Colors.purple.shade400],
    );

    canvas.drawPath(
      hatPath,
      Paint()
        ..shader = hatGradient.createShader(
          Rect.fromPoints(
            Offset(center.dx - 40, center.dy - 140),
            Offset(center.dx + 40, center.dy - 80),
          ),
        ),
    );

    // Hat pompom
    canvas.drawCircle(
      Offset(center.dx, center.dy - 140),
      8,
      Paint()..color = Colors.pink.shade300,
    );

    // Eyes
    canvas.drawCircle(
      Offset(center.dx - 30, center.dy - 20),
      12,
      Paint()..color = Colors.black,
    );
    canvas.drawCircle(
      Offset(center.dx + 30, center.dy - 20),
      12,
      Paint()..color = Colors.black,
    );

    // Big smile
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(center.dx, center.dy + 20), width: 100, height: 80),
      0,
      pi,
      false,
      smilePaint,
    );

    // Draw confetti
    final confettiColors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
    ];

    final random = Random(42); // Fixed seed for consistent confetti
    for (int i = 0; i < 20; i++) {
      final confettiX = center.dx + (random.nextDouble() - 0.5) * 400;
      final confettiY = center.dy + (random.nextDouble() - 0.5) * 400;
      final confettiColor =
          confettiColors[random.nextInt(confettiColors.length)];

      if (random.nextBool()) {
        // Square confetti
        canvas.drawRect(
          Rect.fromCenter(
              center: Offset(confettiX, confettiY), width: 8, height: 8),
          Paint()..color = confettiColor,
        );
      } else {
        // Circle confetti
        canvas.drawCircle(
          Offset(confettiX, confettiY),
          4,
          Paint()..color = confettiColor,
        );
      }
    }
  }

  void _drawHeart(Canvas canvas, Offset center) {
    final heartPath = Path();

    // Create heart shape using bezier curves
    final size = 80.0;

    heartPath.moveTo(center.dx, center.dy + size * 0.3);

    // Left curve
    heartPath.cubicTo(
      center.dx - size * 0.6,
      center.dy - size * 0.2,
      center.dx - size * 0.6,
      center.dy - size * 0.6,
      center.dx - size * 0.3,
      center.dy - size * 0.6,
    );

    heartPath.cubicTo(
      center.dx,
      center.dy - size * 0.8,
      center.dx,
      center.dy - size * 0.8,
      center.dx,
      center.dy - size * 0.4,
    );

    // Right curve
    heartPath.cubicTo(
      center.dx,
      center.dy - size * 0.8,
      center.dx,
      center.dy - size * 0.8,
      center.dx + size * 0.3,
      center.dy - size * 0.6,
    );

    heartPath.cubicTo(
      center.dx + size * 0.6,
      center.dy - size * 0.6,
      center.dx + size * 0.6,
      center.dy - size * 0.2,
      center.dx,
      center.dy + size * 0.3,
    );

    heartPath.close();

    // Heart gradient
    final heartGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.red.shade400, Colors.red.shade700],
    );

    canvas.drawPath(
      heartPath,
      Paint()
        ..shader = heartGradient.createShader(
          Rect.fromCenter(
              center: center, width: size * 1.2, height: size * 1.2),
        ),
    );

    // Heart shine effect
    final shinePath = Path();
    shinePath.moveTo(center.dx - 15, center.dy - 40);
    shinePath.cubicTo(
      center.dx - 5,
      center.dy - 50,
      center.dx + 5,
      center.dy - 50,
      center.dx + 15,
      center.dy - 40,
    );
    shinePath.cubicTo(
      center.dx + 10,
      center.dy - 30,
      center.dx - 10,
      center.dy - 30,
      center.dx - 15,
      center.dy - 40,
    );

    canvas.drawPath(
      shinePath,
      Paint()
        ..color = Colors.white.withOpacity(0.6)
        ..style = PaintingStyle.fill,
    );
  }

  void _drawWinkingFace(Canvas canvas, Offset center) {
    // Draw the face
    final faceGradient = RadialGradient(
      colors: [Colors.yellow.shade300, Colors.yellow.shade600],
    );

    final faceRect = Rect.fromCenter(center: center, width: 200, height: 200);
    canvas.drawCircle(
      center,
      100,
      Paint()
        ..shader = faceGradient.createShader(faceRect)
        ..style = PaintingStyle.fill,
    );

    // Face border
    canvas.drawCircle(
      center,
      100,
      Paint()
        ..color = Colors.orange.shade700
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4,
    );

    // Left eye (open)
    canvas.drawCircle(
      Offset(center.dx - 30, center.dy - 30),
      12,
      Paint()..color = Colors.black,
    );

    // Right eye (winking) - draw as arc
    final winkPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(center.dx + 30, center.dy - 30),
          width: 24,
          height: 12),
      0,
      pi,
      false,
      winkPaint,
    );

    // Smile
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCenter(
          center: Offset(center.dx, center.dy + 10), width: 80, height: 60),
      0,
      pi,
      false,
      smilePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is EmojiPainter && oldDelegate.emojiType != emojiType;
  }
}
