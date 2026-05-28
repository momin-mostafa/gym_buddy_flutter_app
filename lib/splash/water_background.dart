import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class WaterShaderBackground extends StatefulWidget {
  const WaterShaderBackground({super.key});

  @override
  State<WaterShaderBackground> createState() =>
      _WaterShaderBackgroundState();
}

class _WaterShaderBackgroundState
    extends State<WaterShaderBackground>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;

  double time = 0;

  @override
  void initState() {
    super.initState();

    _ticker = createTicker((elapsed) {
      setState(() {
        time =
            elapsed.inMilliseconds / 100.0;
      });
    });

    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      (context, shader, child) {
        return CustomPaint(
          painter: _WaterPainter(
            shader,
            time,
          ),
          child: const SizedBox.expand(),
        );
      },
      assetKey: 'assets/shader/water_gradient.frag',
    );
  }
}

class _WaterPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;

  _WaterPainter(this.shader, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    shader.setFloat(2, time);

    // color1 (#00ff00)
    shader.setFloat(3, 0.0);
    shader.setFloat(4, 1.0);
    shader.setFloat(5, 0.0);

    // color2 (#002b00)
    shader.setFloat(6, 0.0);
    shader.setFloat(7, 0.168);
    shader.setFloat(8, 0.0);

    // color3 (#FEF9F5)
    shader.setFloat(9, 0.996);
    shader.setFloat(10, 0.976);
    shader.setFloat(11, 0.961);

    final paint = Paint()
      ..shader = shader;

    canvas.drawRect(
      Offset.zero & size,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _WaterPainter oldDelegate) {
    return true;
  }
}