import 'package:flutter/material.dart';

class Stories extends StatefulWidget {
  const Stories({super.key});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {

  @override
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ᴘʀᴏᴘʜᴇᴛ\'s ʜɪsᴛᴏʀʏ'),
        backgroundColor: Colors.red[100],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: prophetStoriesList.length,
        itemBuilder: (context, index) {
          final story = prophetStoriesList[index];
          return ProphetStoryCard(story: story);
        },
      ),
    );
  }
}

class ProphetStoryCard extends StatelessWidget {
  final ProphetStory story;

  const ProphetStoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: ExpansionTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ᴘʀᴏᴘʜᴇᴛ',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              story.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 2, 83),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              story.story,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProphetStory {
  final String name;
  final String story;

  ProphetStory({
    required this.name,
    required this.story,
  });
}

final List<ProphetStory> prophetStoriesList = [
  ProphetStory(
    name: 'Adam A.S.',
    story: 'Adam was the first human and prophet created by Allah. He and his wife, Hawwa (Eve), lived in Paradise but were sent to Earth after eating from the forbidden tree.',
  ),
  ProphetStory(
    name: 'Idris A.S.',
    story: 'Idris (Enoch) was known for his wisdom and knowledge. He was raised to a high status by Allah and is mentioned in the Quran for his righteousness.',
  ),
  ProphetStory(
    name: 'Nuh A.S.',
    story: 'Nuh (Noah) was sent to guide his people, who had turned to idol worship. He built an ark to save believers and animals from a great flood.',
  ),
  ProphetStory(
    name: 'Hud A.S.',
    story: 'Hud was sent to the people of Ad, who were arrogant and rejected his message. They were destroyed by a fierce wind as a punishment from Allah.',
  ),
  ProphetStory(
    name: 'Salih A.S.',
    story: 'Salih was sent to the people of Thamud, who demanded a miracle. A she-camel was sent as a sign, but they killed it and were destroyed by an earthquake.',
  ),
  ProphetStory(
    name: 'Ibrahim A.S.',
    story: 'Ibrahim (Abraham) is known for his unwavering faith in Allah. He was tested with many trials, including the command to sacrifice his son Ismail.',
  ),
  ProphetStory(
    name: 'Ismail A.S.',
    story: 'Ismail (Ishmael) was the son of Ibrahim and Hajar. He helped his father build the Kaaba and is known for his patience and obedience to Allah.',
  ),
  ProphetStory(
    name: 'Ishaq A.S.',
    story: 'Ishaq (Isaac) was the son of Ibrahim and Sarah. He was a prophet and the father of Yaqub (Jacob).',
  ),
  ProphetStory(
    name: 'Yaqub A.S.',
    story: 'Yaqub (Jacob) was the son of Ishaq and the father of the twelve tribes of Israel. He was known for his patience and trust in Allah.',
  ),
  ProphetStory(
    name: 'Lut A.S.',
    story: 'Lut (Lot) was sent to the people of Sodom, who were engaged in immoral behavior. They were destroyed by a rain of stones as a punishment from Allah.',
  ),
  ProphetStory(
    name: 'Shuaib A.S.',
    story: 'Shuaib was sent to the people of Madyan, who were dishonest in trade. They rejected his message and were destroyed by an earthquake.',
  ),
  ProphetStory(
    name: 'Yusuf A.S.',
    story: 'Yusuf (Joseph) was known for his beauty and wisdom. He was betrayed by his brothers but eventually became a powerful leader in Egypt.',
  ),
  ProphetStory(
    name: 'Ayyub A.S.',
    story: 'Ayyub (Job) was tested with severe illness and loss but remained patient and faithful to Allah. He was eventually rewarded with recovery and prosperity.',
  ),
  ProphetStory(
    name: 'Yunus A.S.',
    story: 'Yunus (Jonah) was swallowed by a whale after leaving his people. He repented, and Allah saved him. He later returned to guide his people.',
  ),
  ProphetStory(
    name: 'Musa A.S.',
    story: 'Musa (Moses) was sent to free the Children of Israel from Pharaoh\'s tyranny. He received the Torah and performed many miracles, such as parting the Red Sea.',
  ),
  ProphetStory(
    name: 'Harun A.S.',
    story: 'Harun (Aaron) was the brother of Musa and a prophet who supported him in his mission to guide the Children of Israel.',
  ),
  ProphetStory(
    name: 'Dawud A.S.',
    story: 'Dawud (David) was a king and prophet known for his wisdom and devotion to Allah. He received the Zabur (Psalms) and defeated Goliath.',
  ),
  ProphetStory(
    name: 'Sulaiman A.S.',
    story: 'Sulaiman (Solomon) was a king and prophet known for his wisdom and ability to communicate with animals and jinn. He built the Temple in Jerusalem.',
  ),
  ProphetStory(
    name: 'Ilyas A.S.',
    story: 'Ilyas (Elijah) was sent to the people of Baalbek, who worshipped idols. He called them to worship Allah, but they rejected him.',
  ),
  ProphetStory(
    name: 'Al-Yasa A.S.',
    story: 'Al-Yasa (Elisha) was a prophet who succeeded Ilyas. He continued to guide the people and performed miracles by the will of Allah.',
  ),
  ProphetStory(
    name: 'Zakariya A.S.',
    story: 'Zakariya (Zechariah) was a prophet and the father of Yahya. He prayed for a son in his old age and was blessed with Yahya.',
  ),
  ProphetStory(
    name: 'Yahya A.S.',
    story: 'Yahya (John the Baptist) was a prophet known for his piety and devotion. He prepared the way for the coming of Isa (Jesus).',
  ),
  ProphetStory(
    name: 'Isa A.S.',
    story: 'Isa (Jesus) was born miraculously to Maryam (Mary). He performed miracles like healing the sick and raising the dead, and he preached the message of Allah.',
  ),
  ProphetStory(
    name: 'Muhammad S.A.W.',
    story: 'Muhammad is the final prophet and messenger of Allah. He received the Quran and spread the message of Islam to all of humanity.',
  ),
];

