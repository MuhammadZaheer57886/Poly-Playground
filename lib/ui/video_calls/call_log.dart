import 'package:flutter/material.dart';
import 'package:poly_playground/common/nav_function.dart';
import 'package:poly_playground/ui/video_calls/video_calls.dart';

class CallLog extends StatelessWidget {
  const CallLog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => screenPushRep(context, const CallListScreen()),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Call Log'),
      ),
      body: const Center(
        child: Text('Call Log'),
      ),
    );
  }
}