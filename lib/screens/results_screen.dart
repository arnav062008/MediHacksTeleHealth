import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medihacks_2024/constants.dart';

class DramaticPage extends StatefulWidget {
  final String disease;
  final bool status;

  const DramaticPage({super.key, required this.disease, required this.status});

  @override
  _DramaticPageState createState() => _DramaticPageState();
}

class _DramaticPageState extends State<DramaticPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.withOpacity(_animation.value),
                        Colors.blue.withOpacity(1 - _animation.value),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24),
            child: IconButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: darkColor,
                size: 35,
              ),
            ).animate().fadeIn(duration: 3.seconds),
          ),
          Center(
            child: Text(
              widget.status
                  ? "You likely have ${widget.disease}"
                  : "You likely don't have ${widget.disease}",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(duration: 3.seconds),
          ),
        ],
      ),
    );
  }
}
