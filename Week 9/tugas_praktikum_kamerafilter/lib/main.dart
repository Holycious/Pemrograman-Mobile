import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'widget/takepicture_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MyApp(firstCamera: firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.firstCamera});
  final CameraDescription firstCamera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera + Filter Carousel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: TakePictureScreen(camera: firstCamera),
    );
  }
}
