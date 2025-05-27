import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:permission_handler/permission_handler.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  _QiblaScreenState createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  Future<bool>? _deviceSupport;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.locationWhenInUse.status;
    
    if (!status.isGranted) {
      status = await Permission.locationWhenInUse.request();
    }

    if (mounted) {
      setState(() {
      _deviceSupport = status.isGranted
    ? FlutterQiblah.androidDeviceSensorSupport().then((value) => value as bool)
    : Future.value(false);

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ǫɪʙʟᴀ ᴄᴏᴍᴘᴀss'),
        backgroundColor: Colors.red[100],
        centerTitle: true,
      ),
      body: FutureBuilder<bool>(
        future: _deviceSupport,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data == true) {
            return const QiblaCompass();
          } else {
            return const Center(
              child: Text(
                'Sensors or location permissions are not supported on this device.\nPlease enable location access in settings.',
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}

class QiblaCompass extends StatelessWidget {
  const QiblaCompass({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QiblahDirection>(
      stream: FlutterQiblah.qiblahStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final qiblahDirection = snapshot.data;
        if (qiblahDirection == null) {
          return const Center(
            child: Text(
              'Failed to get Qibla direction.\nEnsure location and sensors are enabled.',
              textAlign: TextAlign.center,
            ),
          );
        }

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Qibla Direction: ${qiblahDirection.qiblah.toStringAsFixed(2)}°',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
             const SizedBox(height: 20),
Padding(
  padding: const EdgeInsets.all(20.0), // Adjust padding as needed
  child: Stack(
    alignment: Alignment.center, // Ensures both images are aligned properly
    children: [
      Transform.rotate(
        angle: qiblahDirection.direction * (3.141592653589793 / 180),
        child: Image.asset(
          'assets/compas.png', // Ensure this is in pubspec.yaml
          width: 200,
          height: 200,
        ),
      ),
      Transform.rotate(
        angle: qiblahDirection.qiblah * (3.141592653589793 / 180), 
        child: Image.asset(
          'assets/needle.png', // Ensure this is in pubspec.yaml
          width: 100, // Adjust size to fit within the compass
          height: 100,
        ),
      ),
    ],
  ),
),
const SizedBox(height: 20),

              Text(
                'Device Direction: ${qiblahDirection.direction.toStringAsFixed(2)}°',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
