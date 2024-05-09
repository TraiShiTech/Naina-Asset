// import 'package:flutter/material.dart';

// class CustomMapPainter extends CustomPainter {
//   final Offset delta;
//   final List<Point> pointsRoads;
//   final List<Point> pointsBuilding;
//   final List<Point> pointsBuildings;
//   final Size screenSize;

//   CustomMapPainter({
//     required this.delta,
//     required this.pointsRoads,
//     required this.pointsBuilding,
//     required this.pointsBuildings,
//     required this.screenSize,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     // Your painting logic here
//     // You can use the provided variables to draw your map
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }

// class YourMapScreen extends StatefulWidget {
//   @override
//   _YourMapScreenState createState() => _YourMapScreenState();
// }

// class _YourMapScreenState extends State<YourMapScreen> {
//   Offset _delta = Offset.zero;
//   List<Point> _roadsPoints = [];
//   List<Point> _buildingPoints = [];
//   List<Point> _pointsBuildings = [];
//   late Size _screenSize;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onPanUpdate: (DragUpdateDetails details) {
//         setState(() {
//           _delta += details.delta;
//         });
//       },
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           _screenSize = Size(200, 200);
//           return CustomPaint(
//             painter: CustomMapPainter(
//               delta: _delta,
//               pointsRoads: [Point(x: 10, y: 20)],
//               pointsBuilding: [Point(x: 10, y: 20)],
//               pointsBuildings: [Point(x: 10, y: 20)],
//               screenSize: _screenSize,
//             ),
//             size: _screenSize,
//           );
//         },
//       ),
//     );
//   }
// }

// class Point {
//   final double x;
//   final double y;

//   Point({required this.x, required this.y});

//   @override
//   String toString() {
//     return 'Point(x: 10, y: 20)';
//   }
// }
