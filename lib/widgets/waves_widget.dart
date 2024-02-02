import 'package:flutter/material.dart';

class WavesWidget extends StatefulWidget {
  const WavesWidget({
    super.key,
  });

  @override
  State<WavesWidget> createState() => _WavesWidgetState();
}

class _WavesWidgetState extends State<WavesWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _animation;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    _controller.repeat();

    _animation = Tween<double>(begin: -400, end: 0).animate(_controller);

    _animation.addListener(_updateScreenListerner);
  }

  void _updateScreenListerner() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(_updateScreenListerner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return FittedBox(
      child: SizedBox(
        height: 270,
        width: 200,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: 220,
              width: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CustomBorder(
                    size: const Size(200, 220),
                    child: Container(
                      width: 200,
                      height: 220,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Transform.scale(
                        scaleY: 0.6,
                        alignment: Alignment.bottomCenter,
                        child: Stack(children: [
                          Positioned(
                            bottom: 0,
                            right: _animation.value,
                            child: ClipPath(
                              clipper: MyWaveClipper(),
                              child: Container(
                                color: const Color(0xFFFE9177),
                                width: 900,
                                height: 240,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: _animation.value,
                            child: ClipPath(
                              clipper: MyWaveClipper(),
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFFFA782),
                                      Color(0xFFFE9177),
                                      Color(
                                        0xFFD54735,
                                      ),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    stops: [
                                      0.3,
                                      0.4,
                                      0.8,
                                    ],
                                  ),
                                ),
                                width: 900,
                                height: 240,
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    child: Container(
                      width: 50,
                      height: 15,
                      color: scaffoldBackgroundColor,
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 30,
              left: 100 - 35,
              child: Container(
                height: 37,
                width: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFA782),
                ),
              ),
            ),
            Positioned(
              top: 30,
              right: 100 - 35,
              child: Container(
                height: 37,
                width: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFA782),
                ),
              ),
            ),
            Positioned(
              top: 10,
              child: Container(
                width: 90,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFFFA782),
                    width: 10,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, 40.0);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 40.0);

    for (int i = 0; i < 10; i++) {
      if (i % 2 == 0) {
        path.quadraticBezierTo(
            size.width - (size.width / 16) - (i * size.width / 8),
            0.0,
            size.width - ((i + 1) * size.width / 8),
            size.height - 180);
      } else {
        path.quadraticBezierTo(
            size.width - (size.width / 16) - (i * size.width / 8),
            size.height - 120,
            size.width - ((i + 1) * size.width / 8),
            size.height - 180);
      }
    }

    path.lineTo(0.0, 40.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomBorder extends StatelessWidget {
  final Size size;
  final Widget child;

  const CustomBorder({
    super.key,
    required this.size,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: size,
      foregroundPainter: CustomBorderPainter(),
      child: child,
    );
  }
}

class CustomBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    final paint = Paint()
      ..color = const Color(0xFFFFA782)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;

    canvas.drawCircle(
      center,
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
