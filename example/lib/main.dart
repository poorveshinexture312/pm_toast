import 'package:flutter/material.dart';
import 'package:pm_toast/pm_toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(child: Text(' PM Toast Package ')),
          backgroundColor: Colors.purple[100]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                PMToast(
                  context: context,
                  message: 'This is a simple toast!',
                ).show();
              },
              child: const Text('Show Simple Toast'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                PMToast(
                  context: context,
                  message: 'This is a toast with a button!',
                  backgroundColor: Colors.purple,
                  textColor: Colors.white,
                  fontSize: 18.0,
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  position: ToastPosition.bottom,
                  leftImage: const Icon(Icons.info, color: Colors.white),
                  rightButton: const Icon(Icons.close, color: Colors.white),
                  onRightButtonPressed: () {
                    print('Right button pressed');
                  },
                ).show();
              },
              child: const Text('Show Toast with Button'),
            ),
          ],
        ),
      ),
    );
  }
}
