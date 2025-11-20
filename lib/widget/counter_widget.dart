import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CountdownTimerWidget extends StatefulWidget {
  final int postId;
  const CountdownTimerWidget({super.key, required this.postId});

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  late int totalDuration; // random seconds (10, 20, 25)
  int remaining = 0;
  Timer? _timer;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    totalDuration = [10, 20, 25][Random().nextInt(3)];
    remaining = totalDuration;
  }

  void startTimer() {
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remaining > 0) {
        setState(() {
          remaining--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("timer_${widget.postId}"),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          // item visible
          startTimer();
        } else {
          // item hidden
          stopTimer();
        }
      },
      child: Row(mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.timer, size: 20, color: Colors.grey),
          const SizedBox(width: 4),
          Text("$remaining s",style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
