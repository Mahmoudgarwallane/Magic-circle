import 'package:flutter/material.dart';
import 'package:magic_circle/magic_circle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String angle = "0";
  String cos = "0";
  String sin = "0";
  @override
  Widget build(BuildContext context) {
    List<Widget> body() => [
          Flexible(
            child: MagicCircle(
              onDrag: (angle, cos, sin) {
                setState(() {
                  this.angle = angle;
                  this.cos = cos;
                  this.sin = sin;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Displayer(
                  value: "angle: " + angle,
                ),
                Displayer(
                  value: "cos: " + cos,
                ),
                Displayer(
                  value: "sin: " + sin,
                ),
              ],
            ),
          )
        ];
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xff072227),
          child: MediaQuery.of(context).orientation == Orientation.portrait
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center, children: body())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: body()),
          alignment: Alignment.center,
        ),
      ),
    );
  }
}

class Displayer extends StatelessWidget {
  final String value;
  const Displayer({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(0xff35858B), borderRadius: BorderRadius.circular(20)),
      child: Text(
        value,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
