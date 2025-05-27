import 'package:flutter/material.dart';

class DuaZikar extends StatefulWidget {
  const DuaZikar({super.key});

  @override
  State<DuaZikar> createState() => _DuaZikarState();
}

class _DuaZikarState extends State<DuaZikar> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ᴅᴜᴀ & ᴢɪᴋᴀʀ'),
        backgroundColor: Colors.red[100],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: duaZikarList.length,
        itemBuilder: (context, index) {
          final duaZikar = duaZikarList[index];
          return DuaZikarCard(duaZikar: duaZikar);
        },
      ),
    );
  }
}

class DuaZikarCard extends StatelessWidget {
  final DuaZikarModel duaZikar;

  const DuaZikarCard({super.key, required this.duaZikar});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.white70,
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              duaZikar.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 2, 83),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              duaZikar.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Reference: ${duaZikar.reference}',
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}

class DuaZikarModel {
  final String title;
  final String description;
  final String reference;

  DuaZikarModel({
    required this.title,
    required this.description,
    required this.reference,
  });
}

final List<DuaZikarModel> duaZikarList = [
  DuaZikarModel(
    title: 'Dua for Morning',
    description: 'أَصْبَحْنَا وَأَصْبَحَ الْمُلْكُ لِلَّهِ، وَالْحَمْدُ لِلَّهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ',
    reference: 'Sahih Muslim',
  ),
  DuaZikarModel(
    title: 'Dua for Evening',
    description: 'أَمْسَيْنا وَأَمْسَى المُلْكُ للهِ، وَالحَمدُ للهِ، لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ',
    reference: 'Sahih Muslim',
  ),
  DuaZikarModel(
    title: 'Dua Before Sleeping',
    description: 'بِاسْمِكَ رَبِّي وَضَعْتُ جَنْبِي، وَبِكَ أَرْفَعُهُ، إِنْ أَمْسَكْتَ نَفْسِي فَارْحَمْهَا، وَإِنْ أَرْسَلْتَهَا فَاحْفَظْهَا',
    reference: 'Sahih Bukhari',
  ),
DuaZikarModel(
  title: 'Dua for Gratitude',
  description: 'اللهم لك الحمد كما ينبغي لجلال وجهك وعظيم سلطانك',
  reference: 'General Reference',
),
DuaZikarModel(
  title: 'Dua for Relief',
  description: 'اللهم إني أعوذ بك من غلبة الدين وقهر الرجال',
  reference: 'General Reference',
),
  DuaZikarModel(
    title: 'Dua After Waking Up',
    description: 'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
    reference: 'Sahih Bukhari',
  ),
  DuaZikarModel(
    title: 'Dua Before Eating',
    description: 'اللَّهُمَّ بَارِكْ لَنَا فِيهِ وَأَطْعِمْنَا خَيْرًا مِنْهُ',
    reference: 'Sunan Abu Dawood',
  ),
  DuaZikarModel(
    title: 'Dua After Eating',
    description: 'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنَا وَسَقَانَا وَجَعَلَنَا مُسْلِمِينَ',
    reference: 'Sunan Abu Dawood',
  ),
  DuaZikarModel(
    title: 'Dua When Leaving Home',
    description: 'بِسْمِ اللَّهِ تَوَكَّلْتُ عَلَى اللَّهِ، لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللَّهِ',
    reference: 'Sunan Abu Dawood',
  ),
  DuaZikarModel(
    title: 'Dua When Entering Home',
    description: 'اللَّهُمَّ إِنِّي أَسْأَلُكَ خَيْرَ الْمَوْلِجِ وَخَيْرَ الْمَخْرَجِ، بِسْمِ اللَّهِ وَلَجْنَا، وَبِسْمِ اللَّهِ خَرَجْنَا، وَعَلَى اللَّهِ رَبِّنَا تَوَكَّلْنَا',
    reference: 'Sunan Abu Dawood',
  ),
  DuaZikarModel(
    title: 'Dua for Anxiety',
    description: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَالْعَجْزِ وَالْكَسَلِ، وَالْبُخْلِ وَالْجُبْنِ، وَضَلَعِ الدَّيْنِ وَغَلَبَةِ الرِّجَالِ',
    reference: 'Sahih Bukhari',
  ),
  DuaZikarModel(
    title: 'Dua for Forgiveness',
    description: 'رَبِّ اغْفِرْ لِي وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيمُ',
    reference: 'Sahih Bukhari',
  ),
  DuaZikarModel(
    title: 'Dua for Protection',
    description: 'بِسْمِ اللَّهِ الَّذِي لَا يَضُرُّ مَعَ اسْمِهِ شَيْءٌ فِي الْأَرْضِ وَلَا فِي السَّمَاءِ وَهُوَ السَّمِيعُ الْعَلِيمُ',
    reference: 'Sunan Abu Dawood',
  ),
  DuaZikarModel(
    title: 'Dua for Good Health',
    description: 'اللَّهُمَّ عَافِنِي فِي بَدَنِي، اللَّهُمَّ عَافِنِي فِي سَمْعِي، اللَّهُمَّ عَافِنِي فِي بَصَرِي، لَا إِلَهَ إِلَّا أَنْتَ',
    reference: 'Sunan Abu Dawood',
  ),
  DuaZikarModel(
    title: 'Dua for Wealth',
    description: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْكُفْرِ، وَالْفَقْرِ، اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلَهَ إِلَّا أَنْتَ',
    reference: 'Sunan Abu Dawood',
  ),
  DuaZikarModel(
    title: 'Dua for Protection from Evil',
    description: 'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ شَرِّ مَا خَلَقَ',
    reference: 'Sahih Muslim',
  ),
  DuaZikarModel(
    title: 'Dua for Protection from Hellfire',
    description: 'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ النَّارِ',
    reference: 'Sunan Abu Dawood',
  ),
  DuaZikarModel(
    title: 'Dua for Patience',
    description: 'اللَّهُمَّ اجْعَلْنِي مِنَ الصَّابِرِينَ',
    reference: 'Sahih Bukhari',
  ),
  DuaZikarModel(
    title: 'Dua for Guidance',
    description: 'اللَّهُمَّ اهْدِنَا فِيمَنْ هَدَيْتَ',
    reference: 'Sunan Abu Dawood',
  ),
  DuaZikarModel(
    title: 'Dua for Success',
    description: 'رَبِّ زِدْنِي عِلْمًا',
    reference: 'Quran 20:114',
  ),
  DuaZikarModel(
    title: 'Dua for Healing',
    description: 'اللَّهُمَّ اشْفِ مَرْضَانَا وَمَرْضَى الْمُسْلِمِينَ',
    reference: 'Sunan Abu Dawood',
  ),
  DuaZikarModel(
    title: 'Dua for Mercy',
    description: 'اللَّهُمَّ ارْحَمْنَا بِرَحْمَتِكَ',
    reference: 'Sunan Abu Dawood',
  ),
  DuaZikarModel(
    title: 'Dua for Barakah',
    description: 'اللَّهُمَّ بَارِكْ لَنَا فِي رِزْقِنَا',
    reference: 'Sunan Abu Dawood',
  ),
  DuaZikarModel(
    title: 'Dua for Repentance',
    description: 'اللَّهُمَّ إِنِّي أَسْتَغْفِرُكَ وَأَتُوبُ إِلَيْكَ',
    reference: 'Sahih Bukhari',
  ),
  DuaZikarModel(
    title: 'Dua for Peace',
    description: 'اللَّهُمَّ اجْعَلْ هَذَا الْبَلَدَ آمِنًا مُطْمَئِنًّا',
    reference: 'Quran 2:126',
  ),
];

