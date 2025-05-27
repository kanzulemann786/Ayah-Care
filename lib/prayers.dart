import 'package:flutter/material.dart';

class Prayers extends StatefulWidget {
  const Prayers({super.key});

  @override
  _PrayersState createState() => _PrayersState();
}

class _PrayersState extends State<Prayers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ɴᴀᴍᴀᴢ ᴛɪᴍɪɴɢs'),
        backgroundColor: Colors.red[100],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: namazList.length,
        itemBuilder: (BuildContext context, int index) {
          final namaz = namazList[index];
          return NamazCard(namaz: namaz);
        },
      ),
    );
  }
}

class NamazCard extends StatelessWidget {
  final Namaz namaz;

  const NamazCard({super.key, required this.namaz});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              namaz.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 2, 83),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Time: ${namaz.time}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rakats: ${namaz.rakats}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Description: ${namaz.description}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Namaz {
  final String name;
  final String time;
  final String rakats;
  final String description;

  Namaz({
    required this.name,
    required this.time,
    required this.rakats,
    required this.description,
  });
}

final List<Namaz> namazList = [
  Namaz(
    name: 'Fajr',
    time: '05:00 AM',
    rakats: '2 Sunnah, 2 Fard',
    description: 'The dawn prayer, performed before sunrise.',
  ),
  Namaz(
    name: 'Dhuhr',
    time: '01:00 PM',
    rakats: '4 Sunnah, 4 Fard, 2 Sunnah, 2 Nafl',
    description: 'The midday prayer, performed after the sun passes its zenith.',
  ),
  Namaz(
    name: 'Asr',
    time: '04:30 PM',
    rakats: '4 Fard',
    description: 'The afternoon prayer, performed in the late afternoon.',
  ),
  Namaz(
    name: 'Maghrib',
    time: '06:30 PM',
    rakats: '3 Fard, 2 Sunnah, 2 Nafl',
    description: 'The evening prayer, performed just after sunset.',
  ),
  Namaz(
    name: 'Isha',
    time: '08:00 PM',
    rakats: '4 Fard, 2 Sunnah, 2 Nafl, 3 Witr',
    description: 'The night prayer, performed after the twilight has disappeared.',
  ),
  Namaz(
  name: 'Tahajjud',
  time: 'Late Night',
  rakats: '2 to 12 Rakats (Optional)',
  description: 'Optional night prayer performed after Isha.',
),
Namaz(
  name: 'Jumu\'ah',
  time: '01:00 PM (Friday)',
  rakats: '2 Fard (Friday Prayer)',
  description: 'Friday congregational prayer, replaces Dhuhr on Fridays.',
),
 Namaz(
    name: 'Istekhara',
    time: 'Anytime (Optional)',
    rakats: '2 Rakats',
    description: 'Prayer for seeking guidance from Allah in decision-making.',
  ),
  Namaz(
    name: 'Witr',
    time: 'After Isha',
    rakats: '1, 3, 5, 7, or 9 Rakats (Odd Number)',
    description: 'Optional night prayer performed after Isha.',
  ),
  Namaz(
    name: 'Jumu\'ah',
    time: '01:00 PM (Friday)',
    rakats: '2 Fard (Friday Prayer)',
    description: 'Friday congregational prayer, replaces Dhuhr on Fridays.',
  ),
  Namaz(
    name: 'Janazah',
    time: 'When Needed',
    rakats: 'No Rakats (Funeral Prayer)',
    description: 'Prayer performed for the deceased.',
  ),
  Namaz(
    name: 'Eid',
    time: 'Morning (Eid al-Fitr & Eid al-Adha)',
    rakats: '2 Rakats',
    description: 'Prayer performed on the days of Eid.',
  ),
  Namaz(
    name: 'Duha',
    time: 'Morning (After Sunrise)',
    rakats: '2 to 12 Rakats (Optional)',
    description: 'Optional prayer performed in the forenoon.',
  ),
  Namaz(
    name: 'Taraweeh',
    time: 'After Isha (Ramadan)',
    rakats: '8 or 20 Rakats (Optional)',
    description: 'Special night prayer performed during Ramadan.',
  ),
  Namaz(
  name: 'Salatul Tasbih',
  time: 'Anytime (Optional)',
  rakats: '4 Rakats',
  description: 'Optional prayer for seeking forgiveness and blessings.',
),
Namaz(
  name: 'Salatul Hajah',
  time: 'Anytime (Optional)',
  rakats: '2 Rakats',
  description: 'Optional prayer for seeking Allah\'s help in times of need.',
),
Namaz(
  name: 'Salatul Taubah',
  time: 'Anytime (Optional)',
  rakats: '2 Rakats',
  description: 'Optional prayer for seeking forgiveness from Allah.',
),
Namaz(
  name: 'Salatul Hifz',
  time: 'Anytime (Optional)',
  rakats: '2 Rakats',
  description: 'Optional prayer for seeking Allah\'s protection for memorization.',
),
Namaz(
  name: 'Salatul Awwabin',
  time: 'After Maghrib (Optional)',
  rakats: '6 Rakats',
  description: 'Optional prayer for seeking forgiveness and blessings.',
),
Namaz(
  name: 'Salatul Khauf',
  time: 'During Battle (Optional)',
  rakats: '2 Rakats',
  description: 'Optional prayer performed during battle.',
),
Namaz(
  name: 'Salatul Istisqa',
  time: 'During Drought (Optional)',
  rakats: '2 Rakats',
  description: 'Optional prayer for seeking rain from Allah.',
),
Namaz(
  name: 'Salatul Qasr',
  time: 'While Traveling (Optional)',
  rakats: '2 Rakats',
  description: 'Optional shortened prayer performed while traveling.',
),
Namaz(
  name: 'Salatul Tahiyatul Wudu',
  time: 'After Wudu (Optional)',
  rakats: '2 Rakats',
  description: 'Optional prayer performed after performing Wudu.',
),
Namaz(
  name: 'Salatul Tawbah',
  time: 'Anytime (Optional)',
  rakats: '2 Rakats',
  description: 'Optional prayer for seeking forgiveness from Allah.',
),
Namaz(
  name: 'Salatul Haja',
  time: 'Anytime (Optional)',
  rakats: '2 Rakats',
  description: 'Optional prayer for seeking Allah\'s help in times of need.',
),
];