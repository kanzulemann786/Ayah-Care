import 'package:flutter/material.dart';

class AllahNames extends StatefulWidget {
  const AllahNames({super.key});

  @override
  State<AllahNames> createState() => _AllahNamesState();
}

class _AllahNamesState extends State<AllahNames> {
  @override
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '𝟿𝟿 ɴᴀᴍᴇs ᴏғ ᴀʟʟᴀʜ',),
           backgroundColor: Colors.red[100],
        
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: namesOfAllahList.length,
        itemBuilder: (context, index) {
          final name = namesOfAllahList[index];
          return NameOfAllahCard(name: name);
        },
      ),
    );
  }
}

class NameOfAllahCard extends StatelessWidget {
  final NameOfAllah name;

  const NameOfAllahCard({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.white70 ,
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name.arabic,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 2, 83),
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 8),
            Text(
              name.transliteration,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name.meaning,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NameOfAllah {
  final String arabic;
  final String transliteration;
  final String meaning;

  NameOfAllah({
    required this.arabic,
    required this.transliteration,
    required this.meaning,
  });
}

final List<NameOfAllah> namesOfAllahList = [
  NameOfAllah(
    arabic: 'الرَّحْمَنُ',
    transliteration: 'Ar-Rahman',
    meaning: 'The Beneficent',
  ),
  NameOfAllah(
    arabic: 'الرَّحِيمُ',
    transliteration: 'Ar-Rahim',
    meaning: 'The Merciful',
  ),
  NameOfAllah(
    arabic: 'الْمَلِكُ',
    transliteration: 'Al-Malik',
    meaning: 'The Eternal Lord',
  ),
  NameOfAllah(
    arabic: 'الْقُدُّوسُ',
    transliteration: 'Al-Quddus',
    meaning: 'The Most Sacred',
  ),
  NameOfAllah(
    arabic: 'السَّلَامُ',
    transliteration: 'As-Salam',
    meaning: 'The Source of Peace',
  ),
  NameOfAllah(
    arabic: 'الْمُؤْمِنُ',
    transliteration: 'Al-Mu\'min',
    meaning: 'The Inspirer of Faith',
  ),
  NameOfAllah(
    arabic: 'الْمُهَيْمِنُ',
    transliteration: 'Al-Muhaymin',
    meaning: 'The Guardian',
  ),
  NameOfAllah(
    arabic: 'الْعَزِيزُ',
    transliteration: 'Al-Aziz',
    meaning: 'The Mighty',
  ),
  NameOfAllah(
    arabic: 'الْجَبَّارُ',
    transliteration: 'Al-Jabbar',
    meaning: 'The Compeller',
  ),
  NameOfAllah(
    arabic: 'الْمُتَكَبِّرُ',
    transliteration: 'Al-Mutakabbir',
    meaning: 'The Supreme',
  ),
  NameOfAllah(
    arabic: 'الْخَالِقُ',
    transliteration: 'Al-Khaliq',
    meaning: 'The Creator',
  ),
  NameOfAllah(
    arabic: 'الْبَارِئُ',
    transliteration: 'Al-Bari\'',
    meaning: 'The Evolver',
  ),
  NameOfAllah(
    arabic: 'الْمُصَوِّرُ',
    transliteration: 'Al-Musawwir',
    meaning: 'The Fashioner',
  ),
  NameOfAllah(
    arabic: 'الْغَفَّارُ',
    transliteration: 'Al-Ghaffar',
    meaning: 'The Repeatedly Forgiving',
  ),
  NameOfAllah(
    arabic: 'الْقَهَّارُ',
    transliteration: 'Al-Qahhar',
    meaning: 'The Subduer',
  ),
  NameOfAllah(
    arabic: 'الْوَهَّابُ',
    transliteration: 'Al-Wahhab',
    meaning: 'The Bestower',
  ),
  NameOfAllah(
    arabic: 'الرَّزَّاقُ',
    transliteration: 'Ar-Razzaq',
    meaning: 'The Provider',
  ),
  NameOfAllah(
    arabic: 'الْفَتَّاحُ',
    transliteration: 'Al-Fattah',
    meaning: 'The Opener',
  ),
  NameOfAllah(
    arabic: 'الْعَلِيمُ',
    transliteration: 'Al-Alim',
    meaning: 'The All-Knowing',
  ),
  NameOfAllah(
    arabic: 'الْقَابِضُ',
    transliteration: 'Al-Qabid',
    meaning: 'The Restrainer',
  ),
  NameOfAllah(
    arabic: 'الْبَاسِطُ',
    transliteration: 'Al-Basit',
    meaning: 'The Expander',
  ),
  NameOfAllah(
    arabic: 'الْخَافِضُ',
    transliteration: 'Al-Khafid',
    meaning: 'The Abaser',
  ),
  NameOfAllah(
    arabic: 'الرَّافِعُ',
    transliteration: 'Ar-Rafi\'',
    meaning: 'The Exalter',
  ),
  NameOfAllah(
    arabic: 'الْمُعِزُّ',
    transliteration: 'Al-Mu\'izz',
    meaning: 'The Honorer',
  ),
  NameOfAllah(
    arabic: 'الْمُذِلُّ',
    transliteration: 'Al-Mudhill',
    meaning: 'The Humiliator',
  ),
  NameOfAllah(
    arabic: 'السَّمِيعُ',
    transliteration: 'As-Sami\'',
    meaning: 'The All-Hearing',
  ),
  NameOfAllah(
    arabic: 'الْبَصِيرُ',
    transliteration: 'Al-Basir',
    meaning: 'The All-Seeing',
  ),
  NameOfAllah(
    arabic: 'الْحَكَمُ',
    transliteration: 'Al-Hakam',
    meaning: 'The Judge',
  ),
  NameOfAllah(
    arabic: 'الْعَدْلُ',
    transliteration: 'Al-Adl',
    meaning: 'The Just',
  ),
  NameOfAllah(
    arabic: 'اللَّطِيفُ',
    transliteration: 'Al-Latif',
    meaning: 'The Subtle',
  ),
  NameOfAllah(
    arabic: 'الْخَبِيرُ',
    transliteration: 'Al-Khabir',
    meaning: 'The All-Aware',
  ),
  NameOfAllah(
    arabic: 'الْحَلِيمُ',
    transliteration: 'Al-Halim',
    meaning: 'The Forbearing',
  ),
  NameOfAllah(
    arabic: 'الْعَظِيمُ',
    transliteration: 'Al-Azim',
    meaning: 'The Magnificent',
  ),
  NameOfAllah(
    arabic: 'الْغَفُورُ',
    transliteration: 'Al-Ghafur',
    meaning: 'The Forgiving',
  ),
  NameOfAllah(
    arabic: 'الشَّكُورُ',
    transliteration: 'Ash-Shakur',
    meaning: 'The Appreciative',
  ),
  NameOfAllah(
    arabic: 'الْعَلِيُّ',
    transliteration: 'Al-Aliyy',
    meaning: 'The Most High',
  ),
  NameOfAllah(
    arabic: 'الْكَبِيرُ',
    transliteration: 'Al-Kabir',
    meaning: 'The Greatest',
  ),
  NameOfAllah(
    arabic: 'الْحَفِيظُ',
    transliteration: 'Al-Hafiz',
    meaning: 'The Preserver',
  ),
  NameOfAllah(
    arabic: 'الْمُقِيتُ',
    transliteration: 'Al-Muqit',
    meaning: 'The Sustainer',
  ),
  NameOfAllah(
    arabic: 'الْحَسِيبُ',
    transliteration: 'Al-Hasib',
    meaning: 'The Reckoner',
  ),
  NameOfAllah(
    arabic: 'الْجَلِيلُ',
    transliteration: 'Al-Jalil',
    meaning: 'The Majestic',
  ),
  NameOfAllah(
    arabic: 'الْكَرِيمُ',
    transliteration: 'Al-Karim',
    meaning: 'The Generous',
  ),
  NameOfAllah(
    arabic: 'الرَّقِيبُ',
    transliteration: 'Ar-Raqib',
    meaning: 'The Watchful',
  ),
  NameOfAllah(
    arabic: 'الْمُجِيبُ',
    transliteration: 'Al-Mujib',
    meaning: 'The Responsive',
  ),
  NameOfAllah(
    arabic: 'الْوَاسِعُ',
    transliteration: 'Al-Wasi\'',
    meaning: 'The All-Encompassing',
  ),
  NameOfAllah(
    arabic: 'الْحَكِيمُ',
    transliteration: 'Al-Hakim',
    meaning: 'The Wise',
  ),
  NameOfAllah(
    arabic: 'الْوَدُودُ',
    transliteration: 'Al-Wadud',
    meaning: 'The Loving',
  ),
  NameOfAllah(
    arabic: 'الْمَجِيدُ',
    transliteration: 'Al-Majid',
    meaning: 'The Glorious',
  ),
  NameOfAllah(
    arabic: 'الْبَاعِثُ',
    transliteration: 'Al-Ba\'ith',
    meaning: 'The Resurrector',
  ),
  NameOfAllah(
    arabic: 'الشَّهِيدُ',
    transliteration: 'Ash-Shahid',
    meaning: 'The Witness',
  ),
  NameOfAllah(
    arabic: 'الْحَقُّ',
    transliteration: 'Al-Haqq',
    meaning: 'The Truth',
  ),
  NameOfAllah(
    arabic: 'الْوَكِيلُ',
    transliteration: 'Al-Wakil',
    meaning: 'The Trustee',
  ),
  NameOfAllah(
    arabic: 'الْقَوِيُّ',
    transliteration: 'Al-Qawiyy',
    meaning: 'The Strong',
  ),
  NameOfAllah(
    arabic: 'الْمَتِينُ',
    transliteration: 'Al-Matin',
    meaning: 'The Firm',
  ),
  NameOfAllah(
    arabic: 'الْوَلِيُّ',
    transliteration: 'Al-Waliyy',
    meaning: 'The Protector',
  ),
  NameOfAllah(
    arabic: 'الْحَمِيدُ',
    transliteration: 'Al-Hamid',
    meaning: 'The Praiseworthy',
  ),
  NameOfAllah(
    arabic: 'الْمُحْصِي',
    transliteration: 'Al-Muhsi',
    meaning: 'The Accounter',
  ),
  NameOfAllah(
    arabic: 'الْمُبْدِئُ',
    transliteration: 'Al-Mubdi\'',
    meaning: 'The Originator',
  ),
  NameOfAllah(
    arabic: 'الْمُعِيدُ',
    transliteration: 'Al-Mu\'id',
    meaning: 'The Restorer',
  ),
  NameOfAllah(
    arabic: 'الْمُحْيِي',
    transliteration: 'Al-Muhyi',
    meaning: 'The Giver of Life',
  ),
  NameOfAllah(
    arabic: 'الْمُمِيتُ',
    transliteration: 'Al-Mumit',
    meaning: 'The Taker of Life',
  ),
  NameOfAllah(
    arabic: 'الْحَيُّ',
    transliteration: 'Al-Hayy',
    meaning: 'The Ever-Living',
  ),
  NameOfAllah(
    arabic: 'الْقَيُّومُ',
    transliteration: 'Al-Qayyum',
    meaning: 'The Self-Subsisting',
  ),
  NameOfAllah(
    arabic: 'الْوَاجِدُ',
    transliteration: 'Al-Wajid',
    meaning: 'The Finder',
  ),
  NameOfAllah(
    arabic: 'الْمَاجِدُ',
    transliteration: 'Al-Majid',
    meaning: 'The Noble',
  ),
  NameOfAllah(
    arabic: 'الْوَاحِدُ',
    transliteration: 'Al-Wahid',
    meaning: 'The Unique',
  ),
  NameOfAllah(
    arabic: 'الْأَحَدُ',
    transliteration: 'Al-Ahad',
    meaning: 'The One',
  ),
  NameOfAllah(
    arabic: 'الصَّمَدُ',
    transliteration: 'As-Samad',
    meaning: 'The Eternal',
  ),
  NameOfAllah(
    arabic: 'الْقَادِرُ',
    transliteration: 'Al-Qadir',
    meaning: 'The Able',
  ),
  NameOfAllah(
    arabic: 'الْمُقْتَدِرُ',
    transliteration: 'Al-Muqtadir',
    meaning: 'The Powerful',
  ),
  NameOfAllah(
    arabic: 'الْمُقَدِّمُ',
    transliteration: 'Al-Muqaddim',
    meaning: 'The Expediter',
  ),
  NameOfAllah(
    arabic: 'الْمُؤَخِّرُ',
    transliteration: 'Al-Mu\'akhkhir',
    meaning: 'The Delayer',
  ),
  NameOfAllah(
    arabic: 'الْأَوَّلُ',
    transliteration: 'Al-Awwal',
    meaning: 'The First',
  ),
  NameOfAllah(
    arabic: 'الْآخِرُ',
    transliteration: 'Al-Akhir',
    meaning: 'The Last',
  ),
  NameOfAllah(
    arabic: 'الظَّاهِرُ',
    transliteration: 'Az-Zahir',
    meaning: 'The Manifest',
  ),
  NameOfAllah(
    arabic: 'الْبَاطِنُ',
    transliteration: 'Al-Batin',
    meaning: 'The Hidden',
  ),
  NameOfAllah(
    arabic: 'الْوَالِي',
    transliteration: 'Al-Wali',
    meaning: 'The Governor',
  ),
  NameOfAllah(
    arabic: 'الْمُتَعَالِي',
    transliteration: 'Al-Muta\'ali',
    meaning: 'The Exalted',
  ),
  NameOfAllah(
    arabic: 'الْبَرُّ',
    transliteration: 'Al-Barr',
    meaning: 'The Source of Goodness',
  ),
  NameOfAllah(
    arabic: 'التَّوَّابُ',
    transliteration: 'At-Tawwab',
    meaning: 'The Acceptor of Repentance',
  ),
  NameOfAllah(
    arabic: 'الْمُنْتَقِمُ',
    transliteration: 'Al-Muntaqim',
    meaning: 'The Avenger',
  ),
  NameOfAllah(
    arabic: 'الْعَفُوُّ',
    transliteration: 'Al-Afuw',
    meaning: 'The Pardoner',
  ),
  NameOfAllah(
    arabic: 'الرَّءُوفُ',
    transliteration: 'Ar-Ra\'uf',
    meaning: 'The Kind',
  ),
  NameOfAllah(
    arabic: 'مَالِكُ الْمُلْكِ',
    transliteration: 'Malik-ul-Mulk',
    meaning: 'The Owner of Sovereignty',
  ),
  NameOfAllah(
    arabic: 'ذُو الْجَلَالِ وَالْإِكْرَامِ',
    transliteration: 'Dhu-al-Jalal wa-al-Ikram',
    meaning: 'The Lord of Majesty and Bounty',
  ),
  NameOfAllah(
    arabic: 'الْمُقْسِطُ',
    transliteration: 'Al-Muqsit',
    meaning: 'The Equitable',
  ),
  NameOfAllah(
    arabic: 'الْجَامِعُ',
    transliteration: 'Al-Jami\'',
    meaning: 'The Gatherer',
  ),
  NameOfAllah(
    arabic: 'الْغَنِيُّ',
    transliteration: 'Al-Ghaniyy',
    meaning: 'The Self-Sufficient',
  ),
  NameOfAllah(
    arabic: 'الْمُغْنِي',
    transliteration: 'Al-Mughni',
    meaning: 'The Enricher',
  ),
  NameOfAllah(
    arabic: 'الْمَانِعُ',
    transliteration: 'Al-Mani\'',
    meaning: 'The Preventer',
  ),
  NameOfAllah(
    arabic: 'الضَّارُّ',
    transliteration: 'Ad-Darr',
    meaning: 'The Distresser',
  ),
  NameOfAllah(
    arabic: 'النَّافِعُ',
    transliteration: 'An-Nafi\'',
    meaning: 'The Propitious',
  ),
  NameOfAllah(
    arabic: 'النُّورُ',
    transliteration: 'An-Nur',
    meaning: 'The Light',
  ),
  NameOfAllah(
    arabic: 'الْهَادِي',
    transliteration: 'Al-Hadi',
    meaning: 'The Guide',
  ), 
  NameOfAllah(
    arabic: 'الْبَدِيعُ',
    transliteration: 'Al-Badi',
    meaning: 'The Incomparable',
  ),
  NameOfAllah(
    arabic: 'الْبَاقِي',
    transliteration: 'Al-Baqi',
    meaning: 'The Ever-Enduring',
  ),
  NameOfAllah(
    arabic: 'الْوَارِثُ',
    transliteration: 'Al-Warith',
    meaning: 'The Inheritor',
  ),
  NameOfAllah(
    arabic: 'الرَّشِيدُ',
    transliteration: 'Ar-Rashid',
    meaning: 'The Righteous Teacher',
  ),
  NameOfAllah(
    arabic: 'الصَّبُورُ',
    transliteration: 'As-Sabur',
    meaning: 'The Patient',
  ),
];
   