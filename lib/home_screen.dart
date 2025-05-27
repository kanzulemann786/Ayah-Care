// ignore_for_file: unused_field, unused_element

import 'package:ayahcare_app/qibla.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'emotionselection.dart';
import 'stories.dart';
import 'allah_names.dart';
import 'dua_zikar.dart';
import 'prayers.dart';
import 'login.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Import to check if running on Web

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => EmotionSelectionScreen()));
        break;
      case 1:
        Navigator.pushNamed(context, 'stories');
        break;
      case 2:
        Navigator.pushNamed(context, 'prayerTimes');
        break;
      case 3:
        Navigator.pushNamed(context, 'allahNames');
        break;
      case 4:
        Navigator.pushNamed(context, 'duaZikar');
        break;
      case 5:
        if (!kIsWeb) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => QiblaScreen()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Qibla Compass is not supported on Web.")),
          );
        }
        break;
    }
  }

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyLogin()), // Redirect to login screen
      );
    } catch (e) {
      print("Sign-out error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(
        title: Text(
          "ᴀʏᴀʜ ᴄᴀʀᴇ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        backgroundColor: Colors.red[100],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildNavigationButton(context, "ᴇᴍᴏᴛɪᴏɴ sᴇʟᴇᴄᴛɪᴏɴ", EmotionSelectionScreen()),
          _buildNavigationButton(context, "ᴘʀᴏᴘʜᴇᴛ\'s ʜɪsᴛᴏʀʏ", Stories()),
          _buildNavigationButton(context, "ᴘʀᴀʏᴇʀ ᴛɪᴍᴇs", Prayers()),
          _buildNavigationButton(context, "𝟿𝟿 ɴᴀᴍᴇs ᴏғ ᴀʟʟᴀʜ", AllahNames()),
          _buildNavigationButton(context, "ᴅᴜᴀ & ᴢɪᴋᴀʀ", DuaZikar()),
          _buildQiblaButton(context), // Modified Qibla button logic
          SizedBox(height: 20), // Spacing before sign-out button
          _buildSignOutButton(), // Sign Out button placed at the bottom
        ],
      ),
    );
  }

  Widget _buildNavigationButton(BuildContext context, String title, dynamic route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          padding: EdgeInsets.symmetric(vertical: 12.0),
          fixedSize: Size(50, 80),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          if (route is Widget) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => route),
            );
          } else {
            Navigator.pushNamed(context, route);
          }
        },
        child: Text(
          title,
          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildQiblaButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          padding: EdgeInsets.symmetric(vertical: 12.0),
          fixedSize: Size(50, 80),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          if (!kIsWeb) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => QiblaScreen()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Qibla Compass is not supported on Web.")),
            );
          }
        },
        child: Text(
          "ǫɪʙʟᴀ ᴄᴏᴍᴘᴀss",
          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSignOutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey, // Different color to highlight logout
          padding: EdgeInsets.symmetric(vertical: 12.0),
          fixedSize: Size(50, 80),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: _signOut,
        child: Text(
          "Log Out",
          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
