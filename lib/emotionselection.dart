import 'package:flutter/material.dart';
import 'quranicverses.dart'; // Import QuranicVersesScreen

class EmotionSelectionScreen extends StatelessWidget {
  final List<Map<String, dynamic>> emotions = [
    {'name': 'Angry', 'color': Colors.pink[200]},
    {'name': 'Anxious', 'color': Colors.blue[100]},
    {'name': 'Bored', 'color': Colors.grey[300]},
    {'name': 'Confident', 'color': Colors.teal[100]},
    {'name': 'Confused', 'color': Colors.brown[100]},
    {'name': 'Content', 'color': Colors.pink[100]},
    {'name': 'Depressed', 'color': Colors.pink[300]},
    {'name': 'Doubtful', 'color': Colors.red[100]},
    {'name': 'Grateful', 'color': Colors.blue[200]},
    {'name': 'Greedy', 'color': Colors.grey[200]},
    {'name': 'Guilty', 'color': Colors.green[100]},
    {'name': 'Happy', 'color': Colors.amber[100]},
    {'name': 'Hurt', 'color': Colors.pink[200]},
    {'name': 'Hypocritical', 'color': Colors.pink[300]},
    {'name': 'Indecisive', 'color': Colors.red[200]},
    {'name': 'Jealous', 'color': Colors.blue[100]},
    {'name': 'Lazy', 'color': Colors.grey[300]},
    {'name': 'Lonely', 'color': Colors.green[100]},
     {'name': 'Lost', 'color': Colors.brown[100]},
    {'name': 'Nervous', 'color': Colors.pink[200]},
    {'name': 'Overwhelmed', 'color': Colors.pink[300]},
    {'name': 'Regret', 'color': Colors.red[100]},
    {'name': 'Sad', 'color': Colors.blue[200]},
    {'name': 'Scared', 'color': Colors.grey[300]},
    {'name': 'Suicidal', 'color': Colors.green[100]},
    {'name': 'Tired', 'color': Colors.brown[100]},
    {'name': 'Unloved', 'color': Colors.pink[200]},
    {'name': 'Weak', 'color': Colors.brown[100]},
    {'name': 'Anticipation', 'color': Colors.brown[100]},
    {'name': 'Aroused', 'color': Colors.green[100]},
    {'name': 'Curious', 'color': Colors.grey[300]},
    {'name': 'Defeated', 'color': Colors.blue[200]},
    {'name': 'Desire', 'color': Colors.pink[200]},
    {'name': 'Desperate', 'color': Colors.brown[100]},
    {'name': 'Determined', 'color': Colors.green[100]},
    {'name': 'Disbelief', 'color': Colors.grey[300]},
    {'name': 'Envious', 'color': Colors.blue[100]},
    {'name': 'Hatred', 'color': Colors.red[100]},
    {'name': 'Humiliated', 'color': Colors.blue[100]},
    {'name': 'Impatient', 'color': Colors.grey[300]},
    {'name': 'Insecure', 'color': Colors.green[100]},
    {'name': 'Irritated', 'color': Colors.brown[100]},
    {'name': 'Love', 'color': Colors.pink[200]},
    {'name': 'Nostalgic', 'color': Colors.green[100]},
    {'name': 'Offended', 'color': Colors.grey[300]},
    {'name': 'Peaceful', 'color': Colors.blue[100]},
    {'name': 'Rage', 'color': Colors.red[100]},
    {'name': 'Satisfied', 'color': Colors.blue[100]},
    {'name': 'Uncertain', 'color': Colors.grey[300]},
    {'name': 'Uneasy', 'color': Colors.green[100]},
  ];

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("I AM FEELING...", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two items per row
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 3,
          ),
          itemCount: emotions.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuranicVersesScreen(emotion: emotions[index]['name']),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: emotions[index]['color'],
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  emotions[index]['name'],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
