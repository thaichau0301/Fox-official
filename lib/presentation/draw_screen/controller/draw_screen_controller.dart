
import 'package:fox/widgets/colors_picker.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

enum DrawingMode {
  Paint, Pencil, Highlighter,
}
class DrawnLine {
  final List<Offset> points;
  final Color color;
  final double width;
  final DrawingMode mode;
  DrawnLine(this.points, this.color, this.width, this.mode);
}
class DrawingPainter extends CustomPainter {
  final List<DrawnLine> lines;
  final DrawnLine? currentLine;

  DrawingPainter({required this.lines, this.currentLine});

  @override
  void paint(Canvas canvas, Size size) {
    for (var line in lines) {
      Paint paint = Paint()
        ..color = line.color.withOpacity(line.mode == DrawingMode.Highlighter ? 0.3 : 1.0)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = line.width
        ..style = PaintingStyle.stroke;

      _drawSmoothPath(canvas, line.points, paint);
    }

    if (currentLine != null) {
      Paint paint = Paint()
        ..color = currentLine!.color.withOpacity(currentLine!.mode == DrawingMode.Highlighter ? 0.3 : 1.0)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = currentLine!.width
        ..style = PaintingStyle.stroke;

      _drawSmoothPath(canvas, currentLine!.points, paint);
    }
  }

  void _drawSmoothPath(Canvas canvas, List<Offset> points, Paint paint) {
    if (points.isEmpty) return;
    if (points.length < 3) {
      // If there are fewer than 3 points, just draw a simple line.
      for (int i = 0; i < points.length - 1; i++) {
        canvas.drawLine(points[i], points[i + 1], paint);
      }
      return;
    }

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 2; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final p2 = points[i + 2];

      final cp1 = Offset((p0.dx + p1.dx) / 2, (p0.dy + p1.dy) / 2);
      final cp2 = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);

      path.quadraticBezierTo(p1.dx, p1.dy, cp2.dx, cp2.dy);
    }

    path.lineTo(points.last.dx, points.last.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class PaintController extends GetxController {
  var selectedIndex = 0.obs;
  var sliderValue = 10.0.obs;
  void onTapChange(int index) {

    selectedIndex.value = index;
    switch(index) {
      case 0: setDrawingMode(DrawingMode.Paint); break;
      case 1: setDrawingMode(DrawingMode.Pencil); break;
      case 2: setDrawingMode(DrawingMode.Highlighter); break;
      case 3: clear(); break;
    }
    update();
  }
  List<DrawnLine> lines = [];
  DrawnLine? line;
  // change color of line paint

  Color selectedColor = Colors.white;
  double strokeWidth = 10;
  DrawingMode selectedMode = DrawingMode.Paint;
  ColorsPickerController colorsPickerController = Get.put(ColorsPickerController());
  // void updateStrokeWidth(){
  //   strokeWidth = sliderValue.value;
  //   update();
  // }
  void updateValueSlider(newValue) {
    sliderValue.value = newValue;
    strokeWidth = newValue;
    update();
  }
  void updateColorLine(){
    selectedColor = colorsPickerController.Picker();
    update();
  }

  void startLine(Offset offset) {
    line = DrawnLine(
      [offset],
      selectedColor,
      strokeWidth,
      selectedMode,
    );
    update();
  }
  void updateLine(Offset offset) {
    line?.points.add(offset);
    update();
  }

  void endLine() {
    if (line != null) {
      lines.add(line!);
      line = null;
    }
    update();
  }
  void setDrawingMode(DrawingMode mode) {
    selectedMode = mode;
    if (mode == DrawingMode.Paint) {
      strokeWidth = 4.0;
    } else if (mode == DrawingMode.Pencil) {
      strokeWidth = 2.0;
    } else if (mode == DrawingMode.Highlighter) {
      strokeWidth = 10.0;
    }
    update();
  }
  void clear() {
    lines.clear();
    update();
  }
}