import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart' as ja;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuranicVersesScreen extends StatefulWidget {
  final String emotion;
  const QuranicVersesScreen({Key? key, required this.emotion}) : super(key: key);

  @override
  _QuranicVersesScreenState createState() => _QuranicVersesScreenState();
}

class _QuranicVersesScreenState extends State<QuranicVersesScreen> {
  final ja.AudioPlayer _audioPlayer = ja.AudioPlayer();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, bool> likedAyahs = {};

  Map<String, dynamic> getVerses(String emotion) {
    Map<String, List<Map<String, String>>> verses = {
      "Angry": [
        {
          "ayah": "أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ",
          "translation": "I seek protection in Allah from the rejected Shaytan.",
          "reference": "Allah says: “When you recite the Quran, seek refuge with Allah from rejected Shayṭān. (Quran 16:98)",
          "audio": "https://example.com/audio1.mp3"
        },
        {
          "ayah": "رَبِّ أَعُوذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِينِ وَأَعُوذُ بِكَ رَبِّ أَنْ يَحْضُرُونِ",
          "translation": "Rabbi aʿūdhu bika min hamazāti-sh-shayāṭīn. Wa aʿūdhu bika Rabbi ay-yaḥḍurūn.",
          "reference": "My Lord, I seek protection with You from the promptings of the devils; and I seek protection in You, my Lord, from their coming near me. Quran 23:97-98",
          "audio": "https://example.com/audio2.mp3"
        },
{
          "ayah": "اَللّٰهُمَّ رَبَّ مُحَمَّدٍ اغْفِرْ لِيْ ذَنْبِيْ ، وَأَذْهِبْ غَيْظَ قَلْبِيْ ، وَأَعِذْنِيْ مِنْ مُضِلَّاتِ الْفِتَنِ",
          "translation": "Allāhumma Rabba Muḥammad, ighfir lī dhambī, wa adh-hib ghayẓa qalbī, wa aʿidhnī min muḍillāti-l-fitan.",
          "reference": " O Allah, Lord of Muhammad, forgive me my sins, remove the rage of my heart and protect me from the trials that lead astray.",
          "audio": "https://example.com/audio2.mp3"
        },

{
          "ayah": "اَللّٰهُمَّ بِعِلْمِكَ الْغَيْبَ ، وَقُدْرَتِكَ عَلَى الْخَلْقِ ، أَحْيِنِيْ مَا عَلِمْتَ الْحَيَاةَ خَيْرًا لِّيْ ، وَتَوَفَّنِيْ إِذَا عَلِمْتَ الْوَفَاةَ خَيْرًا لِّيْ ، اَللّٰهُمَّ وَأَسْأَلُكَ خَشْيَتَكَ فِي الْغَيْبِ وَالشَّهَادَةِ ، وَأَسْأَلُكَ كَلِمَةَ الْحَقِّ فِي الرِّضَا وَالْغَضَبِ ، وَأَسْأَلُكَ الْقَصْدَ فِي الْفَقْرِ وَالْغِنَىٰ ، وَأَسْأَلُكَ نَعِيْمًا لَّا يَنْفَدُ ، وَأَسْأَلُكَ قُرَّةَ عَيْنٍ لَّا تَنْقَطِعُ ، وَأَسْأَلُكَ الرِّضَا بَعْدَ الْقَضَاءِ ، وَأَسْأَلُكَ بَرْدَ الْعَيْشِ بَعْدَ الْمَوْتِ ، وَأَسْأَلُكَ لَذَّةَ النَّظَرِ إِلَىٰ وَجْهِكَ ، وَالشَّوْقَ إِلَىٰ لِقَائِكَ ، فِيْ غَيْرِ ضَرَّاءَ مُضِرَّةٍ ، وَلَا فِتْنَةٍ مُّضِلَّةٍ ، اَللّٰهُمَّ زَيِّنَّا بِزِيْنَةِ الْإِيْمَانِ ، وَاجْعَلْنَا هُدَاةً مُّهْتَدِيْنَ",
          "translation": "Allāhumma bi-ʿilmika-l-ghayb, wa qudratika ʿala-l-khalq, aḥyinī mā ʿalimta-l-ḥayāta khayra-l-lī, wa tawaffanī idhā ʿalimta-l-wafāta khayra-l-lī, Allāhumma wa as’aluka khashyataka fi-l-ghaybi wa-sh-shahādah, wa as’aluka kalimata-l-ḥaqqi fi-r-riḍā wa-l-ghaḍab, wa as’aluka-l-qaṣda fi-l-faqr wa-l-ghinā, wa as’aluka naʿīma-l-lā yanfad, wa as’aluka qurrata ʿayni-l-lā tanqaṭiʿ, wa as’aluka-r-riḍā baʿda-l-qaḍā, wa as’aluka barda-l-ʿayshi baʿda-l-mawt, wa as’aluka ladh-dhata-n-naẓari ilā wajhik, wa-sh-shawqa ilā liqā’ik, fī ghayri ḍarrā’a muḍirrah, wa lā fitnati-m-muḍillah, Allāhumma zayyinnā bi-zīnati-l-īmān, wa-jʿalnā hudāta-m-muhtadīn.",
          "reference": " O Allah, with Your knowledge of the unseen and Your absolute power over the creation, let me live in this world as long as You know my living is good for me; and give me death when You know death is better for me. O Allah, I ask You for Your fear in private and in public, and for the word of truth in times of joy and anger. I ask You for moderation in poverty and in wealth. I ask You for endless blessings and perpetual delights. I ask You to make me pleased with destiny; for a cool and comfortable life after death; for the pleasure of seeing Your Face; and for the longing to meet You, without any painful ordeals and tribulations that misguide. O Allah, adorn us with the beauty of faith, and make us those who guide others and are guided themselves.",
          "audio": "https://example.com/audio2.mp3"
        },


      ],

      "Anxious": [
        {
          "ayah": "حَسْبِيَ اللّٰهُ لَا إِلٰهَ إِلَّا هُوَ ، عَلَيْهِ تَوَكَّلْتُ ، وَهُوَ رَبُّ الْعَرْشِ الْعَظِيْمِ",
          "translation": "Ḥasbiya-llāhu lā ilāha illā huwa, ʿalayhi tawakkaltu, wa huwa rabbu-l-ʿarshi-l-ʿaẓīm.",
          "reference": "Allah is sufficient for me. There is no god but He. I have placed my trust in Him, He is Lord of the Majestic Throne. (Quran 9:129)",
          
        },
{ "ayah": 'رَبِّ إِنِّيْ لِمَآ أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيْرٌ',
          "translation": "  Rabbī innī limā anzalta ilayya min khayrin faqīr.",
          "reference": "My Lord, I am truly in need of whatever good You may send me.(28:24)",
          },
            {
          "ayah": 'رَبِّ أَعُوْذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِيْنِ ، وَأَعُوذُ بِكَ رَبِّ أَنْ يَّحْضُرُوْنِ',
          "translation": "Rabbi aʿūdhu bika min hamazāti-sh-shayāṭīn. Wa aʿūdhu bika Rabbi ay-yaḥḍurūn.",
          "reference": "My Lord, I seek protection with You from the promptings of the devils; and I seek protection in You, my Lord, from their coming near me. Quran 23:97-98",
          },
          
          
        
{ "ayah": "-رَبِّ- أَنِّيْ مَسَّنِيَ الضُّرُّ وَأَنْتَ أَرْحَمُ الرّٰحِمِيْن",
          "translation": "  Rabbi innī massanīya-ḍ-ḍurru wa anta arḥamu-rraḥimīn.",
          "reference": "My Lord, harm has touched me, and You are the Most Merciful of the merciful. (21:83)",
          },
          { "ayah": "لَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللّٰهِ",
          "translation": "  Lā ḥawla wa lā quwwata illā bi-llāh.",
          "reference": "There is no power and no strength except with Allah.",
          },
          {"ayah":"اَللّٰهُمَّ لَا سَهْلَ إِلَّا مَا جَعَلْتَهُ سَهْلًا ، وَأَنْتَ تَجْعَلُ الْحَزْنَ إِذَا شِئْتَ سَهْلًا",
          "translation":"Allāhumma lā sahla illā mā jaʿaltahu sahlan, wa anta tajʿalu-l-ḥazna idhā shi’ta sahlan.",
          "reference":"O Allah, there is no ease except in that which You have made easy, and You make the difficulty easy when You wish.",
           },




{ "ayah": 'رَبِّ إِنِّيْ لِمَآ أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيْرٌ',
          "translation": "  Rabbī innī limā anzalta ilayya min khayrin faqīr.",
          "reference": "My Lord, I am truly in need of whatever good You may send me.(28:24)",
          },
            
          
          
        
{ "ayah": 'لَا إِلٰهَ إِلَّا اللّٰهُ الْعَظِيْمُ الْحَلِيْمُ ، لَا إِلٰهَ إِلَّا اللّٰهُ رَبُّ الْعَرْشِ الْعَظِيْمِ ، لَا إِلٰهَ إِلَّا اللّٰهُ رَبُّ السَّمٰـوٰتِ وَرَبُّ الْأَرْضِ وَرَبُّ الْعَرْشِ الْكَرِيْمِ',
          "translation":"  Lā ilāha illā-llāhu-l-ʿaẓīmu-l-ḥalīmu, lā ilāha illā-llāhu rabbu-l-ʿarshi-l-ʿaẓīmi, lā ilāha illā-llāhu rabbu-s-samāwāti wa rabbu-l-arḍi wa rabbu-l-ʿarshi-l-karīmi.",
          "reference": "There is no god but Allah, the Mighty, the Forbearing. There is no god but Allah, Lord of the Mighty Throne. There is no god but Allah, Lord of the heavens, Lord of the earth, and Lord of the noble Throne.",
          },
         
          { "ayah": 'حَسْبُنَا اللّٰهُ وَنِعْمَ الْوَكِيْلُ',
          "translation": " Ḥasbunā-llāhu wa niʿma-l-wakīl.",
          "reference": "Allah is sufficient for us, and He is the best Disposer of affairs.",
          },
         
          {"ayah":'لَا إِلٰهَ إِلَّا اللّٰهُ',
          "translation":"Lā ilāha illā-llāh.",
          "reference":"There is no god but Allah.",
           },
          {"ayah":'اَللّٰهُمَّ رَحْمَتَكَ أَرْجُوْ فَلَا تَكِلْنِيْ إِلٰى نَفْسِيْ طَرْفَةَ عَيْنٍ ، وَأَصْلِحْ لِي شَأْنِيْ كُلَّهُ لَا إِلٰهَ إِلَّا أَنْتَ',
          "translation":"Allāhumma raḥmataka arjū falā takilnī ilā nafsī ṭarfata ʿaynin, wa aṣliḥ lī sha’nī kullahu lā ilāha illā anta.",
          "reference":"O Allah, I hope for Your mercy. Do not leave me to myself even for the blinking of an eye. Correct all of my affairs for me. There is none worthy of worship but You.",
           },
          
  
          { "ayah": 'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ ، وَأَعُوْذُ بِكَ مِنَ الْعَجْزِ وَالْكَسَلِ، وَأَعُوْذُ بِكَ مِنَ الْجُبْنِ وَالْبُخْلِ ، وَأَعُوْذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ وَقَهْرِ الرِّجَالِ',
          "translation": "Allāhumma innī aʿūdhu bika mina-l-hammi wa-l-ḥuzni, wa aʿūdhu bika mina-l-ʿajzi wa-l-kasal, wa aʿūdhu bika mina-l-jubni wa-l-bukhl, wa aʿūdhu bika mina-ghalabati-d-dayni wa qahrir-rijāl.",
          "reference": "O Allah, I seek refuge in You from anxiety and sorrow, weakness and laziness, miserliness and cowardice, the burden of debts and from being over",
          },
         
          {"ayah":'اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ ، اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِيْ دِيْنِيْ وَدُنْيَايَ وَأَهْلِيْ وَمَالِيْ ، اَللّٰهُمَّ اسْتُرْ عَوْرَاتِيْ وَآمِنْ رَوْعَاتِيْ ، اَللّٰهُمَّ احْفَظْنِيْ مِنْ بَيْنِ يَدَيَّ ، وَمِنْ خَلْفِيْ ، وَعَنْ يَّمِيْنِيْ ، وَعَنْ شِمَالِيْ ، وَمِنْ فَوْقِيْ ، وَأَعُوْذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِيْ',
          "translation":"Allāhumma innī as’aluka-l-ʿāfiyah fī-d-dunyā wa-l-ākhirah, Allāhumma innī as’aluka-l-ʿafwa wa-l-ʿāfiyah fī dīnī wa-dunyāya wa-ahliya wa-mālī, Allāhumma ustr ʿawrātī wa-āmin rawʿātī, Allāhumma aḥfaẓnī min bayni yadayya, wa min khalfī, wa ʿan yamīnī, wa ʿan shimālī, wa min fawqī, wa aʿūdhu bi-ʿaẓamatika an ughtāla min taḥtī.",
          "reference":"O Allah, I ask You for well-being in this world and in the Hereafter. O Allah, I ask You for forgiveness and well-being in my religious and worldly affairs, and my family and my wealth. O Allah, conceal my faults, calm my fears, and protect me from before me and behind me, from my right and my left, and from above me. I seek refuge in Your greatness from being killed from below me.",
           },
          {"ayah":'اَللّٰهُمَّ إِنِّيْ عَبْدُكَ ، وَابْنُ عَبْدِكَ ، وَابْنُ أَمَتِكَ ، نَاصِيَتِيْ بِيَدِكَ ، مَاضٍ فِيَّ حُكْمُكَ ، عَدْلٌ فِيَّ قَضَاؤُكَ ، أَسْأَلُكَ بِكُلِّ اسْمٍ هُوَ لَكَ ، سَمَّيْتَ بِهِ نَفْسَكَ ، أَوْ عَلَّمْتَهُ أَحَدًا مِنْ خَلْقِكَ ، أَوْ أَنْزَلْتَهُ فِيْ كِتَابِكَ ، أَوِ اسْتَأْثَرْتَ بِهِ فِيْ عِلْمِ الْغَيْبِ عِنْدَكَ ، أَنْ تَجْعَلَ الْقُرْآنَ رَبِيْعَ قَلْبِيْ ، وَنُوْرَ صَدْرِيْ وَجَلَاءَ حُزْنِيْ ، وَذَهَابَ هَمِّيْ',
          "translation":"Allāhumma innī ʿabduka, wa-bnu ʿabdika, wa-bnu amatika, nāṣiyati bi-yadika, māḍin fīya ḥukmuka, ʿadlun fīya qadā’uka, as’aluka bi-kulli is",
          "reference":"O Allah, I am Your servant, son of Your servant, son of Your maidservant. My forelock is in Your hand, Your command over me is forever executed and Your decree over me is just. I ask You by every name belonging to You which You named Yourself with, or revealed in Your Book, or You taught to any of Your creation, or You have preserved in the knowledge of the unseen with You, that You make the Quran the life of my heart and the light of my chest, and a departure for my sorrow and a release for my anxiety.",
           },
      ],
"Bored": [
        {
          "ayah": "رَبِّ إِنِّيْ لِمَآ أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيْرٌ",
          "translation": "  Rabbī innī limā anzalta ilayya min khayrin faqīr.",
          "reference": "My Lord, I am truly in need of whatever good You may send me.(28:24)",
          },
           
{ "ayah": "اَللّٰهُمَّ إنَّا نَسْأَلُكَ مُوْجِبَاتِ رَحْمَتِكَ ، وَعَزَائِمَ مَغْفِرَتِكَ ، وَالسَّلَامَةَ مِنْ كُلِّ إِثْمٍ ، وَالْغَنِِيْمَةَ مِنْ كُلِّ بِرٍّ ، وَالْفَوْزَ بِالْجَنَّةِ ، وَالنَّجَاةَ مِنَ النَّارِ",
          "translation": " Allāhumma innā nas’aluka mujibāti raḥmatika, wa ʿazā’ima maghfiratika, wa-s-salāmata min kulli ithmin, wa-l-ghanīmata min kulli birrin, wa-l-fawza bi-l-jannati, wa-n-najāta mina-n-nār.",
          "reference": "O Allah, we beg You for all that which will necessitate Your mercy and the determination to do all that which will necessitate Your forgiveness; for protection from every sin and accomplishment of every good; for attainment of Paradise and for freedom from Hell-fire.",
          },
            {
          "ayah":"اَللّٰهُمَّ مُصَرِّفَ الْقُلُوْبِ صَرِّفْ قُلُوْبَنَا عَلَىٰ طَاعَتِكَ",
          "translation": "Allāhumma muṣarrifa-l-qulūbi ṣarrif qulūbana ʿalā ṭāʿatika.",
          "reference": "O Allah, Controller of the hearts, direct our hearts to Your obedience.",
          },     
        
{ "ayah": "اَللّٰهُمَّ أَعِنِّيْ عَلَىٰ ذِكْرِكَ وَشُكْرِكَ وَحُسْنِ عِبَادَتِكَ",
          "translation": " Allāhumma aʿinnī ʿalā dhikrika wa-shukrika wa-ḥusni ʿibādatika.",
          "reference": "O Allah, help me to remember You, to thank You, and to worship You in the best of manners.",
          },
          
          { "ayah": "اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ فِعْلَ الْخَيْرَاتِ ، وَتَرْكَ الْمُنْكَرَاتِ ، وَحُبَّ الْمَسَاكِيْنِ ، وَأَنْ تَغْفِرَ لِيْ وَتَرْحَمَنِيْ ، وَإِذَا أَرَدْتَ فِتْنَةَ قَوْمٍ فَتَوَفَّنِيْ غَيْرَ مَفْتُوْنٍ ، وَأَسْأَلُكَ حُبَّكَ ، وَحُبَّ مَنْ يُّحِبُّكَ ، وَحُبَّ عَمَلٍ يُّقَرِّبُنِيْ إِلَىٰ حُبِّكَ",
          "translation": "Allāhumma innī as’aluka fiʿla-l-khayrāti, wa tarka-l-munkarāti, wa ḥubba-l-masākīni, wa an taghfira lī wa tarḥamani, wa idhā aradta fitnata qawmin fa-tawaffanī ghayra maftūnin, wa as’aluka ḥubbak, wa ḥubba ma-y-yuḥibbuk, wa ḥubba ʿamali-y-yuqarribunī ilā ḥubbik.",

          "reference": "O Allah, I ask You to do good, to avoid evil, and to love the poor. I ask You to forgive me and have mercy on me. When You intend to test a people, cause me to die without being put to trial. I ask You for Your love, the love of those who love You, and the love of every action that will bring me closer to Your love.",
          },
        
          {"ayah":"اَللّٰهُمَّ أَلْهِمْنِيْ رُشْدِيْ ، وَأَعِذْنِيْ مِنْ شَرِّ نَفْسِيْ",
          "translation":"Allāhumma alhimnī rushdī, wa aʿidhnī min sharri nafsī.",
          "reference":"O Allah, inspire me with guidance and protect me from the evil of my soul.",
           },
],
"Confident":[



{ "ayah": 'رَبِّ أَوْزِعْنِيْٓ أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِيْٓ أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ ، وَأَدْخِلْنِيْ بِرَحْمَتِكَ فِيْ عِبَادِكَ الصَّالِحِيْنَ',
          "translation": " Rabbi awziʿnī an ashkura niʿmataka allatī anʿamta ʿalayya wa ʿalā walidayya wa an aʿmala ṣāliḥan tarḍāhu, wa adkhilnī bi-raḥmatika fī ʿibādika ṣ-ṣāliḥīn.",
          "reference": "My Lord, enable me to be grateful for Your favor which You have bestowed upon me and upon my parents, and to work righteousness of which You will approve and make righteous for me my offspring. Indeed, I have repented to You, and indeed, I am of the Muslims. (Quran 46:15)",
          },
          
            {
          "ayah": 'رَبِّ أَوْزِعْنِيْٓ أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِيْٓ أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ ، وَأَصْلِحْ لِيْ فِيْ ذُرِّيَّتِيْ ، إِنِّيْ تُبْتُ إِلَيْكَ وَإِنِّيْ مِنَ الْمُسْلِمِيْنَ',
          "translation": "Rabbi awziʿnī an ashkura niʿmataka allatī anʿamta ʿalayya wa ʿalā walidayya wa an aʿmala ṣāliḥan tarḍāhu, wa aṣliḥ lī fī dhurriyyatī, innī tubtu ilayka wa innī mina-l-muslimīn.",
          "referenc": "My Lord, enable me to be grateful for Your favor which You have bestowed upon me and upon my parents, and to work righteousness of which You will approve and make righteous for me my offspring. Indeed, I have repented to You, and indeed, I am of the Muslims. (Quran 46:15)",
          },
          
          
        
],
"Confused": [
          { "ayah": 'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِيْمِ ،\n'
    'اَلْحَمْدُ لِلّٰهِ رَبِّ الْعَالَمِيْنَ ، الرَّحْمٰنِ الرَّحِيْمِ ، مٰلِكِ يَوْمِ الدِّيْنِ ،\n'
    'إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِيْنُ ، اِهْدِنَا الصِّرَاطَ الْمُسْتَقِيْمَ ،\n'
    'صِرَاطَ الَّذِيْنَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوْبِ عَلَيْهِمْ وَلَا الضَّآلِّيْنَ',

          "translation": "Bismi-llāhi r-raḥmāni r-raḥīm. Al-ḥamdu li-llāhi rabbi-l-ʿālamīn. Ar-raḥmāni r-raḥīm. Māliki yawmi-d-dīn. Iyyāka naʿbudu wa iyyāka nastaʿīn. Ihdinā ṣ-ṣirāṭa-l-mustaqīm. Ṣirāṭa-lladhīna anʿamta ʿalayhim ġayri-l-maġḍūbi ʿalayhim walā-ḍ-ḍāllīn.",
          
          "reference": "In the name of Allah, the Entirely Merciful, the Especially Merciful. [All] praise is [due] to Allah, Lord  of the worlds. The Entirely Merciful, the Especially Merciful, Sovereign of the Day of Recompense. It is You we worship and You we ask for help. Guide us to the straight path - The path of those upon whom You have bestowed favor, not of those who have evoked [Your] anger or of those who are astray.",
          },
          
         
          {"ayah":'رَبِّ إِنِّيْ لِمَآ أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيْرٌ',
          "translation":"  Rabbī innī limā anzalta ilayya min khayrin faqīr.",
          "reference":"My Lord, I am truly in need of whatever good You may send me.(28:24)",
           },
           
          {"ayah":'اَللّٰهُمَّ أَحْسِنْ عَاقِبَتَنَا فِي الْأُمُوْرِ كُلِّهَا ، وَأَجِرْنَا مِنْ خِزْيِ الدُّنْيَا وَعَذَابِ الْآخِرَةِ',
          "translation":" Allāhumma aḥsin ʿāqibatana fī-l-umūri kullihā, wa ajirnā min khizyi-d-dunyā wa ʿādābi-l-ākhirah.",
          "reference":"O Allah, make the end of all our actions good, deliver us from disgrace in this world and from the punishment of the Hereafter.",
           },
          
  
          { "ayah":'اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الثَّبَاتَ فِي الْأَمْرِ ، وَالْعَزِيْمَةَ عَلَى الرُّشْدِ ، وَأَسْأَلُكَ مُوْجِبَاتِ رَحْمَتِكَ ، وَعَزَائِمَ مَغْفِرَتِكَ ، وَأَسْأَلُكَ شُكْرَ نِعْمَتِكَ ، وَحُسْنَ عِبَادَتِكَ ، وَأَسْأَلُكَ قَلْبًا سَلِيْمًا ، وَلِسَانًا صَادِقًا ، وَأَسْأَلُكَ مِنْ خَيْرِ مَا تَعْلَمُ ، وَأَعُوْذُ بِكَ مِنْ شَرِّ مَا تَعْلَمُ ، وَأَسْتَغْفِرُكَ لِمَا تَعْلَمُ ، إِنَّكَ أَنْتَ عَلَّامُ الْغُيُوْبِ',
          "translation":"Allāhumma innī as’aluka-th-thabāta fī-l-amr, wa-l-ʿazīmata ʿalā r-rushd, wa as’aluka mujibāti raḥmatika, wa ʿazā’ima maghfiratika, wa as’aluka shukra niʿmatika, wa ḥusna ʿibādatika, wa as’aluka qalban salīman, wa lisānan ṣādiqan, wa as’aluka min khayri mā taʿlamu, wa aʿūdhu bika min sharri mā taʿlamu, wa astaghfiruka limā taʿlamu, innaka anta ʿallāmu-l-ghuyūb.",
        
          "reference": " O Allah, I ask You for steadfastness in affairs, and determination in guidance. I ask You for the ability to do good deeds, to avoid evil deeds, and to love the poor. I ask You to forgive me and have mercy on me. When You intend to test a people, cause me to die without being put to trial. I ask You for Your love, the love of those who love You, and the love of every action that will bring me closer to Your love.",
          },
       
          {"ayah":'اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ مِنَ الْخَيْرِ كُلِّهِ عَاجِلِهِ وَآجِلِهِ ، مَا عَلِمْتُ مِنْهُ وَمَا لَمْ أَعْلَمْ ، وَأَعُوْذُ بِكَ مِنَ الشَّرِّ كُلِّهِ عَاجِلِهِ وَآجِلِهِ ، مَا عَلِمْتُ مِنْهُ وَمَا لَمْ أَعْلَمْ ، اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ مِنْ خَيْرِ مَا سَأَلَكَ عَبْدُكَ وَنَبِيُّكَ ، وَأَعُوْذُ بِكَ مِنْ شَرِّ مَا عَاذَ مِنْهُ عَبْدُكَ وَنَبِيُّكَ ، اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْجَنَّةَ ، وَمَا قَرَّبَ إِلَيْهَا مِنْ قَوْلٍ أَوْ عَمَلٍ ، وَأَعُوْذُ بِكَ مِنَ النَّارِ ، وَمَا قَرَّبَ إِلَيْهَا مِنْ قَوْلٍ أَوْ عَمَلٍ ، وَأَسْأَلُكَ أَنْ تَجْعَلَ كُلَّ قَضَاءٍ قَضَيْتَهُ لِيْ خَيْرًا',
          "translation":"Allāhumma innī as’aluka mina-l-khayri kullihi ʿājilihi wa-ājilihi, mā ʿalimtu minhu wa mā lam aʿlam, wa aʿūdhu bika mina-sh-sharri kullihi ʿājilihi wa-ājilihi, mā ʿalimtu minhu wa mā lam aʿlam, Allāhumma innī as’aluka mina-l-khayri mā sa’alaka ʿabduka wa-nabīyuka, wa aʿūdhu bika mina-sh-sharri mā ʿāḏa minhu ʿabduka wa-nabīyuka, Allāhumma innī as’aluka-l-jannata, wa mā qarraba ilayhā min qawlin aw ʿamalin, wa aʿūdhu bika mina-n-nāri, wa mā qarraba ilayhā min qawlin aw ʿamalin, wa as’aluka an tajʿala kulla qaḍā’in qaḍaytahu lī khayran.",
          "reference":"O Allah, I ask You for all good, both immediate and delayed, that I know of and that I do not know of. I seek refuge in You from all evil, both immediate and delayed, that I know of and that I do not know of. O Allah, I ask You for the good that Your slave and Prophet have asked You for, and I seek refuge in You from the evil from which Your slave and Prophet sought refuge. O Allah, I ask You for Paradise and whatever brings one closer to it in word or deed. I seek refuge in You from the Fire and whatever brings one closer to it in word or deed. I ask You to make every decree that You decree for me good.",
           },
         
          {"ayah":'اَللّٰهُمَّ اهْدِنِيْ وَسَدِّدْنِيْ ، اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْهُدَىٰ وَالسَّدَادَ',
          "translation":"Allāhumma-hdinī wa sadidnī, Allāhumma innī as’aluka-l-hudā wa-s-sadād.",
          "reference":"O Allah, guide me and make me steadfast. O Allah, I ask You for guidance and steadfastness.",
           },
  {"ayah":'اَللّٰهُمَّ رَبَّ جَبْرَائِيْلَ ، وَمِيْكَائِيْلَ ، وإِسْرَافِيْلَ ، فَاطِرَ السَّمٰوَاتِ وَالْأَرْضِ ، عَالِمَ الْغَيْبِ وَالشَّهَادَةِ ، أَنْتَ تَحْكُمُ بَيْنَ عِبَادِكَ فِيْمَا كَانُوْا فِيْهِ يَخْتَلِفُوْنَ ، اِهْدِنِيْ لِمَا اخْتُلِفَ فِيْهِ مِنَ الْحَقِّ بِإِذْنِكَ ، إِنَّكَ تَهْدِيْ مَنْ تَشَاءُ إِلَىٰ صِرَاطٍ مُّسْتَقِيْمٍ',
          "translation":"Allāhumma rabba Jibrā’īla, wa Mīkā’īla, wa Isrāfīla, fāṭira-s-samāwāti wa-l-arḍ, ʿālima-l-ghaybi wa-sh-shahādah, anta taḥkumu bayna ʿibādika fīmā kānū fīhi yakhtalifūn, ihdinī limā ikhtulifa fīhi mina-l-ḥaqqi bi-idhnika innaka tahdī man tashā’u ilā Ṣirāṭi-m-Mustaqīm.", 
          "reference":"O Allah, Lord of Jibril, Mika’il, and Israfil, Creator of the heavens and the earth, Knower of the unseen and the seen, You judge between Your servants concerning that wherein they differ. Guide me to the truth in the matters wherein they differ, by Your permission. Indeed, You guide whom You will to a straight path.",
           },
      ],
      "Content":[
        { "ayah": 'رَبِّ أَوْزِعْنِيْٓ أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِيْٓ أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ ، وَأَدْخِلْنِيْ بِرَحْمَتِكَ فِيْ عِبَادِكَ الصَّالِحِيْنَ',
          "translation": " Rabbi awziʿnī an ashkura niʿmataka allatī anʿamta ʿalayya wa ʿalā walidayya wa an aʿmala ṣāliḥan tarḍāhu, wa adkhilnī bi-raḥmatika fī ʿibādika ṣ-ṣāliḥīn.",
          "reference": "My Lord, enable me to be grateful for Your favor which You have bestowed upon me and upon my parents, and to work righteousness of which You will approve and make righteous for me my offspring. Indeed, I have repented to You, and indeed, I am of the Muslims. (Quran 46:15)",
          },
          { "ayah":'اَللّٰهُمَّ مَا أَصْبَحَ بِيْ مِنْ نِّعْمَةٍ أَوْ بِأَحَدٍ مِّنْ خَلْقِكَ ، فَمِنْكَ وَحْدَكَ لَا شَرِيْكَ لَكَ ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ',
          "translation": "Allāhumma mā aṣbaḥa bī min niʿmatin aw bi-aḥadin min khalqika, faminka waḥdaka lā sharīka laka, falaka-l-ḥamdu wa-laka-sh-shukr.",
          "reference": "O Allah, whatever blessing I or any of Your creation have risen upon, is from You alone, without partner. To You belongs all praise and all thanks.",
          },
          
          { "ayah":'اَللّٰهُمَّ مَا أَمْسَىٰ بِيْ مِنْ نِّعْمَةٍ أَوْ بِأَحَدٍ مِّنْ خَلْقِكَ ، فَمِنْكَ وَحْدَكَ لَا شَرِيْكَ لَكَ ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ',
          "translation": "Allāhumma mā amsā bī min niʿmatin aw bi-aḥadin min khalqika, faminka waḥdaka lā sharīka laka, falaka-l-ḥamdu wa-laka-sh-shukr.",
          "reference": "O Allah, whatever blessing I or any of Your creation have risen upon, is from You alone, without partner. To You belongs all praise and all thanks.",
          },
          
             { "ayah": 'اَلْحَمْدُ لِلّٰهِ الَّذِيْ أَطْعَمَنَا وَسَقَانَا ، وَكَفَانَا ، وَآوَانَا ، فَكَمْ مِّمَّنْ لَا كَافِيَ لَهُ وَلَا مُؤْوِيَ',
          "translation": " Al-ḥamdu li-llāhi-lladhī aṭʿamanā wa-saqānā, wa-kafānā, wa-āwānā, fakam mimman lā kāfiya lahu wa-lā muʾwiya.",
          "reference": "  Praise be to Allah who has fed us and given us drink, and who is sufficient for us and has sheltered us. How many are those who have neither food nor drink, and neither shelter nor sufficiency!",
          },
          
          { "ayah":'اَللّٰهُمَّ يَا- فَاطِرَ السَّمٰوَاتِ وَالْأَرْضِ ، أَنْتَ وَلِـيِّيْ فِي الدُّنْيَا وَالْآخِرَةِ ، تَوَفَّنِيْ مُسْلِمًا وَّأَلْحِقْنِيْ بِالصَّالِحِيْنَ',
          "translation": "Allāhumma yā fāṭira-s-samāwāti wa-l-arḍ, anta waliyyī fī-d-dunyā wa-l-ākhirah, tawaffanī musliman wa-alḥiqnī bi-ṣ-ṣāliḥīn.",
          "reference": "O Allah, Creator of the heavens and the earth, You are my protector in this world and in the Hereafter.Make me",
          },
          
          { "ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنْ زَوَالِ نِعْمَتِكَ ، وَتَحَوُّلِ عَافِيَتِكَ ، وَفُجَاءَةِ نِقْمَتِكَ ، وَجَمِيْعِ سَخَطِكَ',
          "translation": "Allāhumma innī aʿūdhu bika min zawāli niʿmatika, wa taḥawwuli ʿāfiyatika, wa fujāʾati niqmatika, wa jamīʿi sakhaṭika.",
          "reference": " O Allah, I seek refuge in You from the decline of Your favor, the change of Your protection, the suddenness of Your punishment, and all Your displeasure.",
          },
          
          { "ayah":'اَلْحَمْدُ لِلّٰهِ الَّذِيْ كَفَانِيْ وَآوَانِيْ ، اَلْحَمْدُ لِلّٰهِ الَّذِيْ أَطْعَمَنِيْ وَسَقَانِيْ ، اَلْحَمْدُ لِلّٰهِ الَّذِيْ مَنَّ عَلَيَّ فَأَفْضَلَ ، اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ بِعِزَّتِكَ أَنْ تُنَجِّيَنِيْ مِنَ النَّارِ',
          "translation": "Al-ḥamdu li-llāhi-lladhī kafānī wa-āwānī, al-ḥamdu li-llāhi-lladhī aṭʿamanī wa-saqānī, al-ḥamdu li-llāhi-lladhī mann ʿalayya fa-afdala, Allāhumma innī as’aluka bi-ʿizzatika an tunajjiyanī mina-n-nār.",
          
          "reference": "Praise be to Allah who has sufficed me, provided for me, and sheltered me. Praise be to Allah who has fed me and given me drink. Praise be to Allah who has favored me and preferred me. O Allah, I ask You by Your might to save me from the Fire.",
          }
      ],
"Depressed":[
          { "ayah": 'رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
          "translation": "Rabbī innī ẓalamtu nafsī, faghfir lī.",
          "reference": "My Lord, indeed I have wronged myself, so forgive me.",
          },
          
          { "ayah":'رَبِّ إِنِّيْ مَغْلُوبٌ فَانْتَصِرْ',
          "translation":"Rabbī innī maghlūbun fantasir.",
          "reference":"My Lord, indeed I am overpowered, so help me.",
          },
          
          { "ayah":'رَبِّ إِنِّيْ أَعُوْذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِيْنِ ، وَأَعُوْذُ بِكَ رَبِّ أَنْ يَحْضُرُوْنِ',
          "translation":"Rabbī innī aʿūdhu bika min hamazāti-sh-shayāṭīn, wa aʿūdhu bika rabbi an yaḥḍurūn.",
          "reference":"My Lord, I seek refuge in You from the incitements of the devils, and I seek refuge in You, my Lord, lest they be present with me.",
          },
          
          { "ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ ، وَأَعُوْذُ بِكَ مِنَ الْعَجْزِ وَالْكَسَلِ، وَأَعُوْذُ بِكَ مِنَ الْجُبْنِ وَالْبُخْلِ ، وَأَعُوْذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ وَقَهْرِ الرِّجَالِ',
          "translation":"Allāhumma innī aʿūdhu bika mina-l-hammi wa-l-ḥazan, wa aʿūdhu bika mina-l-ʿajzi wa-l-kasal, wa aʿūdhu bika mina-l-jubni wa-l-bukhl, wa aʿūdhu bika min ġalabati-d-dayni wa qahrir-rijāl.",
          
          "reference":"O Allah, I seek refuge in You from anxiety and sorrow, weakness and laziness, miserliness and cowardice, the burden of debts and from being overpowered by men.",
          },
          { "ayah":'اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ ، اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِيْ دِيْنِيْ وَدُنْيَايَ وَأَهْلِيْ وَمَالِيْ ، اَللّٰهُمَّ اسْتُرْ عَوْرَاتِيْ وَآمِنْ رَوْعَاتِيْ ، اَللّٰهُمَّ احْفَظْنِيْ مِنْ بَيْنِ يَدَيَّ ، وَمِنْ خَلْفِيْ ، وَعَنْ يَّمِيْنِيْ ، وَعَنْ شِمَالِيْ ، وَمِنْ فَوْقِيْ ، وَأَعُوْذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِيْ',
          "translation":"Rabbī innī aʿūdhu bika min hamazāti-sh-shayāṭīn, wa aʿūdhu bika rabbi an yaḥḍurūn.",
          "reference":"My Lord, I seek refuge in You from the incitements of the devils, and I seek refuge in You, my Lord, lest they be present with me.",
          },
          
          { "ayah":'حَسْبِيَ اللّٰهُ لَا إِلٰهَ إِلَّا هُوَ ، عَلَيْهِ تَوَكَّلْتُ ، وَهُوَ رَبُّ الْعَرْشِ الْعَظِيْمِ',
          "translation":"Ḥasbiya-llāhu lā ilāha illā huwa, ʿalayhi tawakkaltu, wa huwa rabbu-l-ʿarshi-l-ʿaẓīm.",
          "reference":"Allah is sufficient for me. There is no god but Him. I have placed my trust in Him, and He is the Lord of the Majestic Throne.",
          },
          
          { "ayah":'رَبِّ إِنِّيْ لِمَآ أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيْرٌ',
            "translation":"  Rabbī innī limā anzalta ilayya min khayrin faqīr.",
            "reference":"My Lord, I am truly in need of whatever good You may send me.(28:24)",
             },
             
            { "ayah":'اَللّٰهُمَّ أَحْسِنْ عَاقِبَتَنَا فِي الْأُمُوْرِ كُلِّهَا ، وَأَجِرْنَا مِنْ خِزْيِ الدُّنْيَا وَعَذَابِ الْآخِرَةِ',
             "translation":" Allāhumma aḥsin ʿāqibatana fī-l-umūri kullihā, wa ajirnā min khizyi-d-dunyā wa ʿādābi-l-ākhirah.",
             "reference":"O Allah, make the end of all our actions good, deliver us from disgrace in this world and from the punishment of the Hereafter.",
              },
          
          {
            "ayah":"اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنْ ضِيْقِ الدُّنْيَا وَضِيْقِ يَوْمِ الْقِيَامَةِ",
            "translation":"Allāhumma innī aʿūdhu bika min ḍiqi-d-dunyā wa ḍiqi yawmi-l-qiyāmah.",
            "reference":"O Allah, I seek refuge in You from the distress of this world and the distress of the Day of Resurrection.",

          },
          {
"ayah":'يَا حَيُّ يَا قَيُّوْمُ ، بِرَحْمَتِكَ أَسْتَغِيْثُ ، أَصْلِحْ لِيْ شَأْنِيْ كُلَّهُ ، وَلَا تَكِلْنِيْ إِلَىٰ نَفْسِيْ طَرْفَةَ عَيْنٍ',
"translation":"Yā Ḥayyu yā Qayyūm, bi-raḥmatika astaghīth, aṣliḥ lī shaʾnī kullahu, wa lā takilnī ilā nafsī ṭarfata ʿayn.",
"reference":"O Ever-Living, O Sustainer, in Your mercy I seek relief. Rectify all my affairs and do not entrust me to myself for the blink of an eye.",
        },
        {
          "ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنْ جَهْدِ الْبَلَاءِ ، وَدَرَكِ الشَّقَاءِ ، وَسُوْءِ الْقَضَاءِ ، وَشَمَاتَةِ الْأَعْدَاءِ',
           "translation":"Allāhumma innī aʿūdhu bika min jahdi-l-balāʾ, wa darki-sh-shaqāʾ, wa suʾi-l-qaḍāʾ, wa shamātati-l-aʿdāʾ.",
            "reference":"O Allah, I seek refuge in You from the hardship of trials, the reach of misery, the evil of destiny, and the joy of enemies.",

        },
        {
          "ayah":'اَللّٰهُمَّ إِنِّيْ عَبْدُكَ ، وَابْنُ عَبْدِكَ ، وَابْنُ أَمَتِكَ ، نَاصِيَتِيْ بِيَدِكَ ، مَاضٍ فِيَّ حُكْمُكَ ، عَدْلٌ فِيَّ قَضَاؤُكَ ، أَسْأَلُكَ بِكُلِّ اسْمٍ هُوَ لَكَ ، سَمَّيْتَ بِهِ نَفْسَكَ ، أَوْ عَلَّمْتَهُ أَحَدًا مِنْ خَلْقِكَ ، أَوْ أَنْزَلْتَهُ فِيْ كِتَابِكَ ، أَوِ اسْتَأْثَرْتَ بِهِ فِيْ عِلْمِ الْغَيْبِ عِنْدَكَ ، أَنْ تَجْعَلَ الْقُرْآنَ رَبِيْعَ قَلْبِيْ ، وَنُوْرَ صَدْرِيْ وَجَلَاءَ حُزْنِيْ ، وَذَهَابَ هَمِّيْ',
"translation":'Allāhumma innī ʿabduka, wa-bnu ʿabdika, wa-bnu amatika, nāṣiyati bi-yadika, māḍin fīya ḥukmuka, ʿadlun fīya qaḍāʾuka, as’aluka bi-kulli ism-in huwa laka, sammayta bihi nafsaka, aw ʿallamtahu aḥadan min khalqika, aw anzaltahu fī kitābika, awi-staʾṯarta bihi fī ʿilmi-l-ghaybi ʿindaka, an tajʿala-l-qurʾāna rabīʿa qalbī, wa nūra ṣadri wa jalāʾa ḥuznī, wa ḏahāba hammi.',
"reference":"O Allah, I am Your servant, son of Your servant, son of Your maidservant. My forelock is in Your hand, Your command over me is foreverjust. I ask You by every name belonging to You which You named Yourself with, or revealed in Your Book, or You taught to any of Your creation, or You have preserved in the knowledge of the unseen with You, that You make the Quran the life of my heart and the light of my chest, and a departure for my sorrow and a release for my anxiety.",
       },
        {
          "ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ ، وَالْعَجْزِ وَالْكَسَلِ ، وَالْجُبْنِ وَالْبُخْلِ ، وَضَلَعِ الدَّيْنِ وَغَلَبَةِ الرِّجَالِ',
          "translation":"Allāhumma innī aʿūdhu bika mina-l-hammi wa-l-ḥazan, wa-l-ʿajzi wa-l-kasal, wa-l-jubni wa-l-bukhl, wa ḍalaʿi-d-dayni wa ġalabati-r-rijāl.",
          "reference":"O Allah, I seek refuge in You from anxiety and sorrow, weakness and laziness, miserliness and cowardice, the burden of debts and from being overpowered by me",

        },
        {"ayah":'لَا إِلٰهَ إِلَّا اللّٰهُ الْعَظِيْمُ الْحَلِيْمُ ، لَا إِلٰهَ إِلَّا اللّٰهُ رَبُّ الْعَرْشِ الْعَظِيْمِ ، لَا إِلٰهَ إِلَّا اللّٰهُ رَبُّ السَّمٰـوٰتِ وَرَبُّ الْأَرْضِ وَرَبُّ الْعَرْشِ الْكَرِيْمِ',
          "translation":"Lā ilāha illā-llāhu-l-ʿaẓīmu-l-ḥalīmu, lā ilāha illā-llāhu rabbu-l-ʿarshi-l-ʿaẓīmi, lā ilāha illā-llāhu rabbu-s-samāwāti wa rabbu-l-arḍi wa rabbu-l-ʿarshi-l-karīm.",
          "reference":"There is no god but Allah, the Mighty, the Forbearing. There is no god but Allah, Lord of the Mighty Throne. There is no god but Allah, Lord of the heavens, Lord of the earth, and Lord of the noble Throne.",
        },],
        "Doubtful":[
          { "ayah": 'رَبِّ إِنِّيْ أَعُوْذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِيْنِ ، وَأَعُوْذُ بِكَ رَبِّ أَنْ يَحْضُرُوْنِ',
          "translation": "Rabbī innī aʿūdhu bika min hamazāti-sh-shayāṭīn, wa aʿūdhu bika rabbi an yaḥḍurūn.",
          "reference": "My Lord, I seek refuge in You from the incitements of the devils, and I seek refuge in You, my Lord, lest they be present with me.",
          },
          
          { "ayah":'اللهم إن كان هذا الأمر خيرا لي فَاقْدُرْهُ لِي وَيَسِّرْهُ لِي ثُمَّ بَارِكْ لِي فِيهِ',
          "translation":"Allāhumma in kāna hādha-l-amru khayran lī faqdurhu lī wa yassirhu lī thumma bārik lī fīhi.",
          "reference":"O Allah, if this matter is good for me, then decree it for me, make it easy for me, and bless it for me.",
          },
          
          { "ayah":'اَللّٰهُمَّ جَدِّدِ الْإِيْمَانَ فِيْ قَلْبِيْ',
          "translation":"Allāhumma jaddidil-īmāna fī qalbī.",
          "reference":"O Allah, renew faith in my heart.",
          },
          
          { "ayah":'يَا مُقَلِّبَ الْقُلُوْبِ ثَبِّتْ قَلْبِيْ عَلَىٰ دِيْنِكَ',
          "translation":"Yā Muqallibal-qulūbi thabbit qalbī ʿalā dīnik.",
          "reference":"O Turner of the hearts, make my heart firm upon Your religion.",
          },
          
          { "ayah":'يَا وَلِيَّ الْإسْلَامِ وَأَهْلِهِ ، ثَبِّتْنِيْ بِهِ حَتَّىٰ أَلْقَاكَ',
          "translation":"Yā Walīya-l-Islāmi wa-ahlihi, thabbitnī bihi ḥattā alqāka.",
          "reference":"O Guardian of Islam and its people, make me steadfast in it until I meet You.",
          },
          
          { "ayah":'اَللّٰهُمَّ اهْدِنِيْ وَسَدِّدْنِيْ ، اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْهُدَىٰ وَالسَّدَادَ',
          "translation":"Allāhumma-hdinī wa saddidnī, Allāhumma innī as’aluka-l-hudā wa-s-sadād.",
          "reference":"O Allah, guide me and make me steadfast. O Allah, I ask You for guidance and steadfastness.",
          },
        ],
        "Grateful":[
          { "ayah": 'رَبِّ أَوْزِعْنِيْٓ أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِيْٓ أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ ، وَأَدْخِلْنِيْ بِرَحْمَتِكَ فِيْ عِبَادِكَ الصَّالِحِيْنَ',
          "translation": " Rabbi aw ziʿnī an ashkur niʿmataka allatī anʿamta ʿalayya wa ʿalā walidayya wa an aʿmala ṣāliḥan tarḍāhu, wa adkhilnī bi-raḥmatika fī ʿibādika ṣ-ṣāliḥīn.",
          "reference": "My Lord, enable me to be grateful for Your favor which You have bestowed upon me and upon my parents, and to work righteousness of which You will approve and make righteous for me my offspring. Indeed, I have repented to You, and indeed, I am of the Muslims. (Quran 46:15)",
          },
          
          { "ayah":'اَللّٰهُمَّ مَا أَصْبَحَ بِيْ مِنْ نِّعْمَةٍ أَوْ بِأَحَدٍ مِّنْ خَلْقِكَ ، فَمِنْكَ وَحْدَكَ لَا شَرِيْكَ لَكَ ، فَلَكَ الْحَمْدُ وَلَكَ الشُّكْرُ',
          "translation": "Allāhumma mā aṣbaḥa bī min niʿmatin aw bi-aḥadin min khalqika, faminka waḥdaka lā sharīka laka, falaka-l-ḥamdu wa-laka-sh-shukr.",
          "reference": "Allah, whatever blessing I or any of Your creation have risen upon, is from You alone, without partner. To You belongs all praise and all thanks.",
          },
          
          { "ayah":'اَلْحَمْدُ لِلّٰهِ الَّذِيْ أَطْعَمَنَا وَسَقَانَا ، وَكَفَانَا ، وَآوَانَا ، فَكَمْ مِّمَّنْ لَا كَافِيَ لَهُ وَلَا مُؤْوِيَ.',
          "translation": " Al-ḥamdu li-llāhi-lladhī aṭʿamanā wa-saqānā, wa-kafānā, wa-āwānā, fakam mimman lā kāfiya lahu wa-lā muʾwiya.",
          "reference": "  Praise be to Allah who has fed us and given us drink, and who is sufficient for us and has sheltered us. How many are those who have neither food nor drink, and neither shelter nor sufficiency!",
          },
          
          { "ayah":'رَبِّ أَوْزِعْنِيْٓ أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِيْٓ أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ ، وَأَدْخِلْنِيْ بِرَحْمَتِكَ فِيْ عِبَادِكَ الصَّالِحِيْنَ',
          "translation": " Rabbi aw ziʿnī an ashkur niʿmataka allatī anʿamta ʿalayya wa ʿalā walidayya wa an aʿmala ṣāliḥan tarḍāhu, wa adkhilnī bi-raḥmatika fī ʿibādika ṣ-ṣāliḥīn.",
          "reference": "My Lord, enable me to be grateful for Your favor which You have bestowed upon me and upon my parents, and to work righteousness of which You will approve and make righteous for me my offspring. Indeed, I have repented to You, and indeed, I am of the Muslims. (Quran 46:15)",
          },
          
          
          
          { "ayah":'رَبِّ أَوْزِعْنِيْٓ أَنْ أَشْكُرَ نِعْمَتَكَ الَّتِيْٓ أَنْعَمْتَ عَلَيَّ وَعَلَىٰ وَالِدَيَّ وَأَنْ أَعْمَلَ صَالِحًا تَرْضَاهُ ، وَأَصْلِحْ لِيْ فِيْ ذُرِّيَّتِيْ ، إِنِّيْ تُبْتُ إِلَيْكَ وَإِنِّيْ مِنَ الْمُسْلِمِيْنَ',
              "translation":'Rabbi aw ziʿnī an ashkur niʿmataka allatī anʿamta ʿalayya wa ʿalā walidayya wa an aʿmala ṣāliḥan tarḍāhu, wa aṣliḥ lī fī dhurriyyatī, innī tubtu ilayka wa innī mina-l-muslimīn.',
              "reference":"My Lord,enable me to be grateful for Your favor which You have bestowed upon me and upon my parents, and to work righteousness of which You will approve and make righteous for me my offspring. Indeed, I have repented to You, and indeed, I am of the Muslims. (Quran 46:15)",
               },],
               "Greedy":[
              
              { "ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ ، وَأَعُوْذُ بِكَ مِنَ الْعَجْزِ وَالْكَسَلِ، وَأَعُوْذُ بِكَ مِنَ الْجُبْنِ وَالْبُخْلِ ، وَأَعُوْذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ وَقَهْرِ الرِّجَالِ',
              "translation":"Allāhumma innī aʿūdhu bika mina-l-hammi wa-l-ḥazan, wa aʿūdhu bika mina-l-ʿajzi wa-l-kasal, wa aʿūdhu bika mina-l-jubni wa-l-bukhl, wa aʿūdhu bika min ġalabati-d-dayni wa qahrir-rijāl.",
               "reference":"O Allah, I seek refuge in You from anxiety and sorrow, weakness and laziness, miserliness and cowardice, the burden of debts and from being overpowered by men",
    },
    {
      "ayah":'اَللّٰهُمَّ قَنِّعْنِيْ بِمَا رَزَقْتَنِيْ ، وَبَارِكْ لِيْ فِيْهِ ، وَاخْلُفْ عَلَيٰ كُلِّ غَائِبَةٍ لِّيْ بِخَيْرٍ',
      "translation":"Allāhumma qanniʿnī bimā razaqtanī, wa bārik lī fīhi, wa-ḫluf ʿalayya kulli ġāʾibatin lī bi-khayr.",
      "reference":"O Allah, make me content with what You have provided me, bless it for me, and replace every absent thing with something good for me.",
  },],
  "Guilty":[
  {"ayah":' رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
  "translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
  "reference":'My Lord, indeed I have wronged myself, so forgive me.',
  },
  {"ayah":'رَبِّ اغْفِرْ وَارْحَمْ وَأَنْتَ خَيْرُ الرَّاحِمِيْنَ',
  "translation":"Rabbighfir warḥam wa-anta khayru-r-raḥimīn.",
  "reference":"My Lord, forgive and have mercy, for You are the best of the merciful.",
  },
  {"ayah":'رَبِّ اغْفِرْ لِيْ وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيْمُ',
  "translation":"Rabbighfir lī wa tub ʿalayya innaka anta-t-tawwābu r-raḥīm.",
  "reference":"My Lord, forgive me and accept my repentance. Indeed, You are the Accepting of Repentance, the Merciful.",
  },
  {"ayah":'رَبِّ اغْفِرْ لِيْ وَلِوَالِدَيَّ وَلِمَنْ دَخَلَ بَيْتِيَ مُؤْمِنًا وَلِلْمُؤْمِنِيْنَ وَالْمُؤْمِنَاتِ وَلَا تَزِدِ الظَّالِمِيْنَ إِلَّا تَبَارًا',
  "translation":"Rabbighfir lī wa liwālidayya wa liman dakhala baytiya muʾminan wa lil-muʾminīna wal-muʾmināti wa lā tazidi-ẓ-ẓālimīna illā tabārā.",
    "reference": 'My Lord, forgive me and my parents and whoever enters my house a believer and the believing'
 },
 {
  "ayah":'رَبِّ اغْفِرْ لِيْ وَلِوَالِدَيَّ وَلِلْمُؤْمِنِيْنَ يَوْمَ يَقُوْمُ الْحِسَابُ',
  "translation":"Rabbighfir lī wa liwālidayya wa lil-muʾminīna yawma yaqūmu-l-ḥisāb.",
   "reference":"My Lord, forgive me and my parents and the believers the Day the account is established.",

 },
 {
  "ayah":'لَآ إِلٰهَ إِلَّآ أَنْتَ سُبْحَانَكَ إِنِّيْ كُنْتُ مِنَ الظَّالِمِيْنَ',
  "translation":"Lā ilāha illā anta subḥānaka innī kuntu mina-ẓ-ẓālimīn.",
  "reference":"There is no deity except You; exalted are You. Indeed, I have been of the wrongdoers.",
 },
 {
  "ayah":'اَللّٰهُمَّ اغْفِرْ لِيْ خَطِيْئَتِيْ وَجَهْلِيْ وَإِسْرَافِيْ فِيْ أَمْرِيْ ، وَمَا أَنْتَ أَعْلَمُ بِهِ مِنِّيْ ، اَللّٰهُمَّ اغْفِرْ لِيْ جِدِّيْ وَهَزْلِيْ وَخَطَئِيْ وَعَمْدِيْ وَكُلُّ ذٰلِكَ عِنْدِيْ ، اَللّٰهُمَّ اغْفِرْ لِيْ مَا قَدَّمْتُ وَمَا أَخَّرْتُ ، وَمَا أَسْرَرْتُ وَمَا أَعْلَنْتُ ، وَمَا أَنْتَ أَعْلَمُ بِهِ مِنِّـيْ ، أَنْتَ الْمُقَدِّمُ وَأَنْتَ الْمُؤَخِّرُ ، وَأَنْتَ عَلَىٰ كُلِّ شَيْءٍ قَدِيْرٌ',
  "translation":"Allāhumma-ghfir lī khaṭīʾatī wa-jahlī wa-isrāfī fī amrī, wa mā anta aʿlamu bihi minnī. Allāhumma-ghfir lī jiddī wa-hazlī wa-khaṭāʾī wa-ʿamdī wa-kullu dhālika ʿindī. Allāhumma-ghfir lī mā qaddamtu wa-mā akhkhartu, wa mā asrartu wa-mā aʿlantu, wa mā anta aʿlamu bihi minnī. Anta-l-muqaddimu wa-anta-l-muʾakhkhiru, wa-anta ʿalā kulli shayʾin qadīr.",
  "reference":"O Allah, forgive my errors, ignorance, and extravagance in my affairs, and what You know better than I. O Allah, forgive my seriousness, jesting, and mistakes, whether done deliberately or inadvertently, and all that is with me. O Allah, forgive what I have done in the past and what I will do in the future, what I have concealed and what I have made public, and what You know better than I. You are the Advancer, and You are the Delayer, and You are over all things competent.",
 } ],
 "Happy":[

{
"ayah":'قُلْ بِفَضْلِ اللّٰهِ وَبِرَحْمَتِهِ فَبِذٰلِكَ فَلْيَف',
"translation":"Qul bi-faḍli-llāhi wa-bi-raḥmatihi fabi-dhālika falyafraḥū.",
"reference":"Say, “In the bounty of Allah and in His mercy – in that let them rejoice.”",
},
{"ayah":'فَبِمَا رَحْمَةٍ مِّنَ اللّٰهِ لِنْتَ لَهُمْ ۖ وَلَوْ كُنْتَ فَظًّا غَلِيظَ الْقَلْبِ لَانْفَضُّوا مِنْ حَوْلِكَ ۖ فَاعْفُ عَنْهُمْ وَاسْتَغْفِرْ لَهُمْ وَش',
"translation":"Fabima raḥmatin mina-llāhi linta lahum, wa law kunta faẓẓān ġalīẓa-l-qalbi lanfanḍū min ḥawlika, faʿfu ʿanhum wa-istaghfir lahum wa-shawirhum fī-l-amr.",
"reference":"So by mercy from Allah, [O Muhammad], you were lenient with them. And if you had been rude [in speech] and harsh in heart, they would have disbanded from about you. So pardon them and ask forgiveness for them and consult them in the matter.",
},
{"ayah":'اَللّٰهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ زَوَالِ نِعْمَتِكَ، وَتَحَوُّلِ عَافِيَتِكَ، وَفُجَاءَةِ نِقْمَتِكَ، وَجَمِيعِ سَخَطِكَا',
"translation":"Allāhumma innī aʿūdhu bika min zawāli niʿmatika, wa taḥawwuli ʿāfiyatika, wa fujaāti niqmatika, wa jamīʿi sakhaṭika.",
"reference":"O Allah, I seek refuge in You from the decline of Your favor, the change of Your protection, the suddenness of Your punishment, and all that displeases You.",
},
{"ayah":'اَللّٰهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ',
"translation":"Allāhumma innī as’aluka-l-ʿāfiyat fī d-dunyā wa-l-ākhirah.",
"reference":"O Allah, I ask You for well-being in this world and the Hereafter.",
},
{"ayah":'اَللّٰهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي دِينِي وَدُنْيَايَ وَأَهْلِي وَمَالِي',
"translation":"Allāhumma innī as’aluka-l-ʿāfiyat fī dīnī wa-dunyāy wa-ahliy wa-mālī.",
"reference":"O Allah, I ask You for well-being in my religion, my worldly affairs, my family, and my wealth.",
},
{"ayah":'اَللّٰهُمَّ إِنِّي أَسْأَلُكَ الْعَافِيَةَ فِي جَسَدِي وَعَافِيَةَ فِي سَمْعِي وَعَافِيَةَ فِي بَصَرِي',
"translation":"Allāhumma innī as’aluka-l-ʿāfiyat fī jasadiy wa-ʿāfiyat fī samʿī wa-ʿāfiyat fī baṣarī.",
"reference":"O Allah, I ask You for well-being in my body, well-being in my hearing, and well-being in my sight.",
},
{"ayah":'اَللّٰهُمَّ يَا- فَاطِرَ السَّمٰوَاتِ وَالْأَرْضِ ، أَنْتَ وَلِـيِّيْ فِي الدُّنْيَا وَالْآخِرَةِ ، تَوَفَّنِيْ مُسْلِمًا وَّأَلْحِقْنِيْ بِالصَّالِحِيْنَ',
"translation":"Allāhumma yā fāṭira-s-samāwāti wa-l-arḍi, anta waliyyī fī d-dunyā wa-l-ākhirah, tawaffanī musliman wa-alḥiqnī bi-ṣ-ṣāliḥīn.",
"reference":"O Allah, Creator of the heavens and the earth, You are my protector in this world and in the Hereafter. Make me die a Muslim and join me with the righteous. (12:101)",
},
{"ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنْ زَوَالِ نِعْمَتِكَ ، وَتَحَوُّلِ عَافِيَتِكَ ، وَفُجَاءَةِ نِقْمَتِكَ ، وَجَمِيْعِ سَخَطِكَ',
"translation":"Allāhumma innī aʿūdhu bika min zawāli niʿmatika, wa taḥawwuli ʿāfiyatika, wa fujaāti niqmatika, wa jamīʿi sakhaṭika.",
"reference":"O Allah, I seek refuge in You from the decline of Your favor, the change of Your protection, the suddenness of Your punishment, and all that displeases You.",
},
{"ayah":'لْحَمْدُ لِلّٰهِ الَّذِيْ بِنِعْمَتِهِ تَتِمُّ الصَّالِحَاتُ',
"translation":"Al-ḥamdu li-llāhi-lladhī bi-niʿmatihi tatimmu-ṣ-ṣāliḥāt.",
"reference":"Praise be to Allah, by whose grace good deeds are completed.",
},],
"Hurt":[
{"ayah":'رَبِّ إِنِّيْ مَغْلُوبٌ فَانْتَصِرْ',
"translation":"Rabbī innī maghlūbun fantasir.",
"reference":"My Lord, indeed I am overwhelmed, so help [me].",
},
{"ayah":'رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
"translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
"reference":"My Lord, indeed I have wronged myself, so forgive me.",
},
{"ayah":'رَبِّ اغْفِرْ وَارْحَمْ وَأَنْتَ خَيْرُ الرَّاحِمِيْنَ',
"translation":"Rabbighfir warḥam wa-anta khayru-r-raḥimīn.",
"reference":"My Lord, forgive and have mercy, for You are the best of the merciful.",
},
{"ayah":'رَبِّ اغْفِرْ لِيْ وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيْمُ',
"translation":"Rabbighfir lī wa tub ʿalayya innaka anta-t-tawwābu r-raḥīm.",
"reference":"My Lord, forgive me and accept my repentance. Indeed, You are the Accepting of Repentance, the Merciful.",
},
{"ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ ، وَأَعُوْذُ بِكَ مِنَ الْعَجْزِ وَالْكَسَلِ، وَأَعُوْذُ بِكَ مِنَ الْجُبْنِ وَالْبُخْلِ ، وَأَعُوْذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ وَقَهْرِ الرِّجَالِ',
"translation":"Allāhumma innī aʿūdhu bika mina-l-hammi wa-l-ḥazan, wa aʿūdhu bika mina-l-ʿajzi wa-l-kasal, wa aʿūdhu bika mina-l-jubni wa-l-bukhl, wa aʿūdhu bika min ġalabati-d-dayni wa qahrir-rijāl.",
"reference":"O Allah, I seek refuge in You from anxiety and sorrow, weakness and laziness, miserliness and cowardice, the burden of debts and from being overpowered by men.",

},
{"ayah":'إِنَّا لِلّٰهِ وَإِنَّا إِلَيْهِ رَاجِعُوْنَ ، اَللّٰهُمَّ أْجُرْنِيْ فِيْ مُصِيْبَتِيْ ، وَأَخْلِفْ لِيْ خَيْرًا مِنْهَا',
 "translation":"Innā li-llāhi wa innā ilayhi rājiʿūn, allāhumma ujurnī fī muṣībatī, wa-akhlif lī khayran minhā.",
 "reference":"Indeed, to Allah we belong and to Him we shall return. O Allah, reward me for my affliction and replace it for me with something better.",

},
{"ayah":'اَللّٰهُمَّ رَحْمَتَكَ أَرْجُوْ فَلَا تَكِلْنِيْ إِلٰى نَفْسِيْ طَرْفَةَ عَيْنٍ ، وَأَصْلِحْ لِي شَأْنِيْ كُلَّهُ لَا إِلٰهَ إِلَّا أَنْتَ',
"translation":"Allāhumma raḥmataka arjū, falā takilnī ilā nafsī ṭarfata ʿaynin, wa-aṣliḥ lī shaʾnī kullahu lā ilāha illā anta.",
"reference":"O Allah, I hope for Your mercy. Do not leave me to myself even for the blink of an eye. Correct all of my affairs for me. There is none worthy of worship but You.",
},],
"Hypocritical":[
{"ayah":'رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
"translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
"reference":"My Lord, indeed I have wronged myself, so forgive me.",
},
{"ayah":'رَبِّ اغْفِرْ وَارْحَمْ وَأَنْتَ خَيْرُ الرَّاحِمِيْنَ',
"translation":"Rabbighfir warḥam wa-anta khayru-r-raḥimīn.",
"reference":"My Lord, forgive and have mercy, for You are the best of the merciful.",
},
{"ayah":'رَبِّ اغْفِرْ لِيْ وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيْمُ',
"translation":"Rabbighfir lī wa tub ʿalayya innaka anta-t-tawwābu r-raḥīm.",
"reference":"My Lord, forgive me and accept my repentance. Indeed, You are the Accepting of Repentance, the Merciful.",
},
{"ayah":'يَا مُقَلِّبَ الْقُلُوْبِ ثَبِّتْ قَلْبِيْ عَلَىٰ دِيْنِكَ',
"translation":"Yā muqalliba-l-qulūbi, thabbit qalbī ʿalā dīnik.",
"reference":"O Turner of the hearts, make my heart firm upon Your religion.",
},
{"ayah":'آمَنْتُ بِاللهِ وَرُسُلِهِ',
"translation":"Āmantu bi-llāhi wa-rusulihi.",
"reference":"I believe in Allah and His messengers.",},
{"ayah":'هُوَ الْأَوَّلُ وَالْآخِرُ وَالظَّاهِرُ وَالْبَاطِنُ ، وَهُوَ بِكُلِّ شَيْءٍ عَلِيْمٌ',
"translation":"Huwa-l-ʾawwalu wa-l-ʾākhiru wa-ẓ-ẓāhiru wa-l-bāṭinu, wa-huwa bi-kulli shayʾin ʿalīm.",
"reference":"He is the First and the Last, the Ascendant and the Intimate, and He is, of all things, Knowing.",
},
{"ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ أَنْ أُشْرِكَ بِكَ وَأَنَا أَعْلَمُ ، وَأَسْتَغْفِرُكَ لِمَا لَا أَعْلَمُ',
"translation":"Allāhumma innī aʿūdhu bika an ushrika bika wa-anā aʿlamu, wa-astaghfiruka limā lā aʿlamu.",
"reference":"O Allah, I seek refuge in You from knowingly associating partners with You, and I seek Your forgiveness for what I do unknowingly.",
},
{"ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنْ أَنْ أُشْرِكَ بِكَ شَيْئًا وَأَنَا أَعْلَمُ ، وَأَسْتَغْفِرُكَ لِمَا لَا أَعْلَمُ',
"translation":"Allāhumma innī aʿūdhu bika min an ushrika bika shayʾan wa-anā aʿlamu, wa-astaghfiruka limā lā aʿlamu.",
"reference":"O Allah, I seek refuge in You from knowingly associating partners with You, and I seek Your forgiveness for what I do unknowingly.",
},],
"Indecisive":[
{"ayah":'يَا حَيُّ يَا قَيُّوْمُ ، بِرَحْمَتِكَ أَسْتَغِيْثُ ، أَصْلِحْ لِيْ شَأْنِيْ كُلَّهُ ، وَلَا تَكِلْنِيْ إِلَىٰ نَفْسِيْ طَرْفَةَ عَيْنٍ',
"translation":'Yā ḥayyu yā qayyūmu, bi-raḥmatika astaghīthu, aṣliḥ lī shaʾnī kullahu, wa lā takilnī ilā nafsī ṭarfata ʿaynin.',
"reference":"O Ever-Living, O Sustainer, I seek help in Your mercy. Correct all my affairs and do not entrust me to myself for the blink of an eye.",
},
{"ayah":'يَا مُقَلِّبَ الْقُلُوْبِ ثَبِّتْ قَلْبِيْ عَلَىٰ دِيْنِكَ',
"translation":"Yā muqalliba-l-qulūbi, thabbit qalbī ʿalā dīnik.",
"reference":"O Turner of the hearts, make my heart firm upon Your religion.",
},
{"ayah":'اَللّٰهُمَّ اهْدِنِيْ وَسَدِّدْنِيْ ، اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْهُدَىٰ وَالسَّدَادَ',
"translation":"Allāhumma-hdinī wa-saddidnī, allāhumma innī as’aluka-l-hudā wa-s-sadād.",
"reference":"O Allah, guide me and make me steadfast. O Allah, I ask You for guidance and steadfastness.",
},
{"ayah":'اَللّٰهُمَّ أَلْهِمْنِيْ رُشْدِيْ ، وَأَعِذْنِيْ مِنْ شَرِّ نَفْسِيْ',
"translation":"Allāhumma alhimnī rushdī, wa-aʿiḏnī min šarri nafsī.",
"reference":"O Allah, inspire me with guidance and protect me from the evil of my soul.",
},],
" Jealous":[
{"ayah":'رَبِّ أَعُوذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِيْنِ ، وَأَعُوذُ بِكَ رَبِّ أَنْ يَحْضُرُوْنِ',
"translation":"Rabbī aʿūdhu bika min hamazāti-sh-shayāṭīn, wa-aʿūdhu bika rabbi an yaḥḍūrūn.",
"reference":"My Lord, I seek refuge in You from the incitements of the devils, and I seek refuge in You, my Lord, lest they be present with me.",
},
{"ayah":'اللهم طهر قلبي من كل سوء ، اللهم طهر قلبي من كل ما يبغضك، اللهم طهر قلبي من كل غلٍ وحقدٍ وحسد وكبر',
"translation":"Allāhumma ṭahhir qalbī min kulli suūʾ, allāhumma ṭahhir qalbī min kulli mā yabġiduka, allāhumma ṭahhir qalbī min kulli ġalin wa-ḥiqdin wa-ḥasad wa-kibr.",
"reference":"O Allah, purify my heart from all evil. O Allah, purify my heart from everything that displeases You. O Allah, purify my heart from all envy, hatred, and pride.",
},

{"ayah":'اَللّٰهُمَّ قَنِّعْنِيْ بِمَا رَزَقْتَنِيْ ، وَبَارِكْ لِيْ فِيْهِ ، وَاخْلُفْ عَلَيٰ كُلِّ غَائِبَةٍ لِّيْ بِخَيْرٍ',
"translation":"Allāhumma qanniʿnī bimā razaqtanī, wa bārik lī fīhi, wa-ḫluf ʿalayya kulli ġāʾibatin lī bi-khayr.",
"reference":"O Allah, make me content with what You have provided me, bless it for me, and replace every absent thing with something good for me.",
},],
"Lazy":[
{"ayah":'رَبِّ زِدْنِيْ عِلْمًا',
"translation":"Rabbī zidnī ʿilmā.",
"reference":"My Lord, increase me in knowledge.",
},
{"ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ ، وَأَعُوْذُ بِكَ مِنَ الْعَجْزِ وَالْكَسَلِ، وَأَعُوْذُ بِكَ مِنَ الْجُبْنِ وَالْبُخْلِ ، وَأَعُوْذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ وَقَهْرِ الرِّجَالِ',
"translation":"Allāhumma innī aʿūdhu bika mina-l-hammi wa-l-ḥazan, wa aʿūdhu bika mina-l-ʿajzi wa-l-kasal, wa aʿūdhu bika mina-l-jubni wa-l-bukhl, wa aʿūdhu bika min ġalabati-d-dayni wa qahrir-rijāl.",
"reference":"O Allah, I seek refuge in You from anxiety and sorrow, weakness and laziness, miserliness and cowardice, the burden of debts and from being overpowered by men.",

},
{"ayah":'اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْهُدَىٰ وَالتُّقَىٰ وَالْعَفَافَ وَالْغِنَىٰ',
"translation":"Allāhumma innī as’aluka-l-hudā wa-t-tuqā wa-l-ʿafāfa wa-l-ġinā.",
"reference":"O Allah, I ask You for guidance, piety, chastity, and self-sufficiency.",},
{
  "ayah":'اَللّٰهُمَّ إِنّيْ أَعُوْذُ بِكَ مِنَ الْبُخْلِ ، وَأَعُوْذُ بِكَ مِنَ الْجُبْنِ ، وَأَعُوْذُ بِكَ أَنْ أُرَدَّ إِلَىٰ أَرْذَلِ الْعُمُرِ ، وَأَعُوْذُ بِكَ مِنْ فِتْنَةِ الدُّنْيَا ، وَأَعُوْذُ بِكَ مِنْ عَذَابِ الْقَبْرِ',
  "translation":"Allāhumma innī aʿūdhu bika mina-l-bukhl, wa aʿūdhu bika mina-l-jubn, wa aʿūdhu bika an uradda ilā arḍali-l-ʿumur, wa aʿūdhu bika min fitnati-d-dunyā, wa aʿūdhu bika min ʿadhābi-l-qabr.",
  "reference":"O Allah, I seek refuge in You from miserliness, cowardice, the decline of old age, the trials of this world, and the punishment of the grave.",

},
{
"ayah":'يَا حَيُّ يَا قَيُّوْمُ ، بِرَحْمَتِكَ أَسْتَغِيْثُ ، أَصْلِحْ لِيْ شَأْنِيْ كُلَّهُ ، وَلَا تَكِلْنِيْ إِلَىٰ نَفْسِيْ طَرْفَةَ عَيْنٍ',
"translation":'Yā ḥayyu yā qayyūmu, bi-raḥmatika astaghīthu, aṣliḥ lī shaʾnī kullahu, wa lā takilnī ilā nafsī ṭarfata ʿaynin.',
"reference":"O Ever-Living, O Sustainer, I seek help in Your mercy. Correct all my affairs and do not entrust me to myself for the blink of an eye.",
},
{
  "ayah":'اَللّٰهُمَّ عَافِنِيْ فِيْ بَدَنِيْ ، اَللّٰهُمَّ عَافِنِيْ فِيْ سَمْعِيْ ، اَللّٰهُمَّ عَافِنِيْ فِيْ بَصَرِيْ ، لَا إِلٰهَ إِلَّا أَنْتَ ، اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، وأَعُوْذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلٰهَ إِلَّا أَنْتَ',
  "translation":"Allāhumma ʿāfinī fī badanī, allāhumma ʿāfinī fī samʿī, allāhumma ʿāfinī fī baṣarī, lā ilāha illā anta, allāhumma innī aʿūdhu bika mina-l-kufr wa-l-faqr, wa-aʿūdhu bika min ʿadhābi-l-qabr, lā ilāha illā anta.",
  "reference":"O Allah, grant me health in my body. O Allah, grant me health in my hearing. O Allah, grant me health in my sight. There is no god but You. O Allah, I seek refuge in You from disbelief and poverty, and I seek refuge in You from the punishment of the grave. There is no god but You.",
},],
"Lonely":[
{
  "ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ ، وَأَعُوْذُ بِكَ مِنَ الْعَجْزِ وَالْكَسَلِ، وَأَعُوْذُ بِكَ مِنَ الْجُبْنِ وَالْبُخْلِ ، وَأَعُوْذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ وَقَهْرِ الرِّجَالِ',
  "translation":"Allāhumma innī aʿūdhu bika mina-l-hammi wa-l-ḥazan, wa aʿūdhu bika mina-l-ʿajzi wa-l-kasal, wa aʿūdhu bika mina-l-jubni wa-l-bukhl, wa aʿūdhu bika min ġalabati-d-dayni wa qahrir-rijāl.",
  "reference":"O Allah, I seek refuge in You from anxiety and sorrow, weakness and laziness, miserliness and cowardice, the burden of debts and from being over powered by men",
},{
"ayah":'حَسْبِيَ اللّٰهُ لَا إِلٰهَ إِلَّا هُوَ ، عَلَيْهِ تَوَكَّلْتُ ، وَهُوَ رَبُّ الْعَرْشِ الْعَظِيْمِ',
"translation":"Ḥasbīya-llāhu lā ilāha illā huwa, ʿalayhi tawakkaltu, wa-huwa rabbu-l-ʿarshi-l-ʿaẓīm.",
"reference":"Allah is sufficient for me. There is no god but Him. I have placed my trust in Him, and He is the Lord of the Majestic Throne.",
},
{
"ayah":'اللهُمَّ رَحْمَتَكَ أرجُو، فَلا تَكِلْنِي إلى نَفْسي طَرْفَةَ عَيْنٍ، وأصْلِحْ لي شَأني كُلَّهُ، لا إله إلا أنْتَ',
"translation":"Allāhumma raḥmataka arjū, falā takilnī ilā nafsī ṭarfata ʿaynin, wa-aṣliḥ lī shaʾnī kullahu, lā ilāha illā anta.",
"reference":"O Allah, I hope for Your mercy. Do not leave me to myself even for the blink of an eye. Correct all of my affairs for me. There is none worthy of worship but You.",
},],
"Lost":[
{"ayah":'حَسْبِيَ اللّٰهُ لَا إِلٰهَ إِلَّا هُوَ ، عَلَيْهِ تَوَكَّلْتُ ، وَهُوَ رَبُّ الْعَرْشِ الْعَظِيْمِ',
"translation":"Ḥasbīya-llāhu lā ilāha illā huwa, ʿalayhi tawakkaltu, wa-huwa rabbu-l-ʿarshi-l-ʿaẓīm.",
"reference":"Allah is sufficient for me. There is no god but Him. I have placed my trust in Him, and He is the Lord of the Majestic Throne.",
},
{"ayah":'رَبِّ إِنِّيْ لِمَآ أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيْرٌ',
"translation":"Rabbī innī limā anzalta ilayya min khayrin faqīr.",
"reference":"My Lord, indeed I am, for whatever good You would send down to me, in need.",
},
{"ayah":'رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
"translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
"reference":"My Lord, indeed I have wronged myself, so forgive me.",
},
{"ayah":'رَبِّ اغْفِرْ وَارْحَمْ وَأَنْتَ خَيْرُ الرَّاحِمِيْنَ',
"translation":"Rabbighfir warḥam wa-anta khayru-r-raḥimīn.",
"reference":"My Lord, forgive and have mercy, for You are the best of the merciful.",
},
{"ayah":'رَبِّ اغْفِرْ لِيْ وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيْمُ',
"translation":"Rabbighfir lī wa tub ʿalayya innaka anta-t-tawwābu r-raḥīm.",
"reference":"My Lord, forgive me and accept my repentance. Indeed, You are the Accepting of Repentance, the Merciful.",
},
{"ayah":'يَا حَيُّ يَا قَيُّوْمُ ، بِرَحْمَتِكَ أَسْتَغِيْثُ ، أَصْلِحْ لِيْ شَأْنِيْ كُلَّهُ ، وَلَا تَكِلْنِيْ إِلَىٰ نَفْسِيْ طَرْفَةَ عَيْنٍ',
"translation":'Yā ḥayyu yā qayyūmu, bi-raḥmatika astaghīthu, aṣliḥ lī shaʾnī kullahu, wa lā takilnī ilā nafsī ṭarfata ʿaynin.',
"reference":"O Ever-Living, O Sustainer, I seek help in Your mercy. Correct all my affairs and do not entrust me to myself for the blink of an eye.",
},],
"Nervous":[
{"ayah":'رَبِّ إِنِّيْ مَغْلُوبٌ فَانْتَصِرْ',
"translation":"Rabbī innī maghlūbun fantasir.",
"reference":"My Lord, indeed I am overwhelmed, so help [me].",},
{
"ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ ، وَأَعُوْذُ بِكَ مِنَ الْعَجْزِ وَالْكَسَلِ، وَأَعُوْذُ بِكَ مِنَ الْجُبْنِ وَالْبُخْلِ ، وَأَعُوْذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ وَقَهْرِ الرِّجَالِ',
"translation":"Allāhumma innī aʿūdhu bika mina-l-hammi wa-l-ḥazan, wa aʿūdhu bika mina-l-ʿajzi wa-l-kasal, wa aʿūdhu bika mina-l-jubni wa-l-bukhl, wa aʿūdhu bika min ġalabati-d-dayni wa qahrir-rijāl.",
"reference":"O Allah, I seek refuge in You from anxiety and sorrow, weakness and laziness, miserliness and cowardice, the burden of debts and from being overpowered by men."
},
{
"ayah":'رَبِّ اغْفِرْ وَارْحَمْ وَأَنْتَ خَيْرُ الرَّاحِمِيْنَ',
"translation":"Rabbighfir warḥam wa-anta khayru-r-raḥimīn.",
"reference":"My Lord, forgive and have mercy, for You are the best of the merciful.",
},
{"ayah": 'اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ ، اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِيْ دِيْنِيْ وَدُنْيَايَ وَأَهْلِيْ وَمَالِيْ ، اَللّٰهُمَّ اسْتُرْ عَوْرَاتِيْ وَآمِنْ رَوْعَاتِيْ ، اَللّٰهُمَّ احْفَظْنِيْ مِنْ بَيْنِ يَدَيَّ ، وَمِنْ خَلْفِيْ ، وَعَنْ يَّمِيْنِيْ ، وَعَنْ شِمَالِيْ ، وَمِنْ فَوْقِيْ ، وَأَعُوْذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِيْ',
"translation":"Allāhumma innī as’aluka-l-ʿāfiya fī d-dunyā wa-l-ākhirah, allāhumma innī as’aluka-l-ʿafwa wa-l-ʿāfiya fī dīnī wa-dunyāya wa-ahliya wa-mālī, allāhumma ustr ʿawrātī wa-āmin rawʿātī, allāhumma iḥfaẓnī min bayni yadayya, wa-min khalfī, wa-ʿan yamīnī, wa-ʿan šimālī, wa-min fawqī, wa-aʿūdhu bi-ʿaẓamatika an uġtāla min taḥtī.",
"reference":"O Allah, I ask You for well-being in this world and the Hereafter. O Allah, I ask You for forgiveness and well-being in my religion, my worldly affairs, my family, and my wealth. O Allah, conceal my faults, calm my fears, and protect me from before me, from behind me, from my right, from my left, from above me, and I seek refuge in Your greatness from being taken unaware from beneath me.",
},
{"ayah":'حَسْبِيَ اللّٰهُ لَا إِلٰهَ إِلَّا هُوَ ، عَلَيْهِ تَوَكَّلْتُ ، وَهُوَ رَبُّ الْعَرْشِ الْعَظِيْمِ',
"translation":"Ḥasbīya-llāhu lā ilāha illā huwa, ʿalayhi tawakkaltu, wa-huwa rabbu-l-ʿarshi-l-ʿaẓīm.",
"reference":"Allah is sufficient for me. There is no god but Him. I have placed my trust in Him, and He is the Lord of the Majestic Throne.",
},
 ],
 "Overwhelmed":[
{"ayah":'اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ ، اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِيْ دِيْنِيْ وَدُنْيَايَ وَأَهْلِيْ وَمَالِيْ ، اَللّٰهُمَّ اسْتُرْ عَوْرَاتِيْ وَآمِنْ رَوْعَاتِيْ ، اَللّٰهُمَّ احْفَظْنِيْ مِنْ بَيْنِ يَدَيَّ ، وَمِنْ خَلْفِيْ ، وَعَنْ يَّمِيْنِيْ ، وَعَنْ شِمَالِيْ ، وَمِنْ فَوْقِيْ ، وَأَعُوْذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِيْ',
"translation":"Allāhumma innī as’aluka-l-ʿāfiya fī d-dunyā wa-l-ākhirah, allāhumma innī as’aluka-l-ʿafwa wa-l-ʿāfiya fī dīnī wa-dunyāya wa-ahliya wa-mālī, allāhumma ustr ʿawrātī wa-āmin rawʿātī, allāhumma iḥfaẓnī min bayni yadayya, wa-min khalfī, wa-ʿan yamīnī, wa-ʿan šimālī, wa-min fawqī, wa-aʿūdhu bi-ʿaẓamatika an uġtāla min taḥtī.",
"reference":"O Allah, I ask You for well-being in this world and the Hereafter. O Allah, I ask You for forgiveness and well-being in my religion, my worldly affairs, my family, and my wealth. O Allah, conceal my faults, calm my fears, and protect me from before me, from behind me, from my right, from my left, from above me, and I seek refuge in Your greatness from being taken unaware from beneath me.",
},
{
  "ayah" : ' رَبِّ إِنِّيْ مَغْلُوبٌ فَانْتَصِرْ',
  "translation":"Rabbī innī maghlūbun fantasir.",
  "reference": "My Lord, indeed I am overwhelmed, so help [me].",
},
{
  "ayah":'حَسْبِيَ اللّٰهُ لَا إِلٰهَ إِلَّا هُوَ ، عَلَيْهِ تَوَكَّلْتُ ، وَهُوَ رَبُّ الْعَرْشِ الْعَظِيْمِ',
  "translation":"Ḥasbīya-llāhu lā ilāha illā huwa, ʿalayhi tawakkaltu, wa-huwa rabbu-l-ʿarshi-l-ʿaẓīm.",
  "reference":"Allah is sufficient for me. There is no god but Him. I have placed my trust in Him, and He is the Lord of the Majestic Throne.",
}
 ],
 "Regret":[
  {
    "ayah":'رَبِّ اغْفِرْ وَارْحَمْ وَأَنْتَ خَيْرُ الرَّاحِمِيْنَ',
    "translation":"Rabbighfir warḥam wa-anta khayru-r-raḥimīn.",
    "reference":"My Lord, forgive and have mercy, for You are the best of the merciful.",
  },
  {
    "ayah":'رَبِّ اغْفِرْ لِيْ وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيْمُ',
    "translation":"Rabbighfir lī wa tub ʿalayya innaka anta-t-tawwābu r-raḥīm.",
    "reference":"My Lord, forgive me and accept my repentance. Indeed, You are the Accepting of Repentance, the Merciful.",
  },
  {
    "ayah":'رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
    "translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
    "reference":"My Lord, indeed I have wronged myself, so forgive me.",
  },
  {
    "ayah":'رَبِّ إِنِّيْ لِمَآ أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيْرٌ',
    "translation":"Rabbī innī limā anzalta ilayya min khayrin faqīr.",
    "reference":"My Lord, indeed I am, for whatever good You would send down to me, in need.",
  },
  {
    "ayah":'رَبِّ إِنِّيْ أَسْأَلُكَ الْهُدَىٰ وَالتُّقَىٰ وَالْعَفَافَ وَالْغِنَىٰ',
    "translation":"Rabbī innī as’aluka-l-hudā wa-t-tuqā wa-l-ʿafāfa wa-l-ġinā.",
    "reference":"O Allah, I ask You for guidance, piety, chastity, and self-sufficiency.",
  },
  {
    "ayah":'رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
    "translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
    "reference":"My Lord, indeed I have wronged myself, so forgive me.",
  },{
    "ayah":'لَآ إِلٰهَ إِلَّآ أَنْتَ سُبْحَانَكَ إِنِّيْ كُنْتُ مِنَ الظَّالِمِيْنَ',
    "translation":"Lā ilāha illā anta subḥānaka innī kuntu mina-ẓ-ẓālimīn.",
    "reference":"There is no deity except You; exalted are You. Indeed, I have been of the wrongdoers.",
  },
  {
    "ayah":'أَنْتَ وَلِيُّنَا فَاغْفِرْ لَنَا وَارْحَمْنَا ۖ وَأَنْتَ خَيْرُ الْغَافِرِيْنَ',
    "translation":"Anta waliyyunā faghfir lanā warḥamnā, wa-anta khayru-l-ghāfirīn.",
    "reference":"You are our protector, so forgive us and have mercy upon us, and You are the best of forgivers.",
  },
  {
    "ayah":'رَبَّنَآ إِنَّنَآ اٰمَنَّا فَاغْفِرْ لَنَا ذُنُوْبَنَا وَقِنَا عَذَابَ النَّارِ',
    "translation":"Rabbana innanā āmannā faghfir lanā dhunūbanā wa-qinā ʿadhāba-n-nār.",
    "reference":"Our Lord, indeed we have believed, so forgive us our sins and protect us from the punishment of the Fire.",
  },
  {
    "ayah":'رَبِّ اغْفِرْ وَارْحَمْ وَأَنْتَ خَيْرُ الرّٰحِمِيْنَ',
    "translation":"Rabbighfir warḥam wa-anta khayru-r-raḥimīn.",
    "reference":"My Lord, forgive and have mercy, for You are the best of the merciful.",
  },],
  "Sad":[
    {
      "ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ ، وَأَعُوْذُ بِكَ مِنَ الْعَجْزِ وَالْكَسَلِ، وَأَعُوْذُ بِكَ مِنَ الْجُبْنِ وَالْبُخْلِ ، وَأَعُوْذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ وَقَهْرِ الرِّجَالِ',
      "translation":"Allāhumma innī aʿūdhu bika mina-l-hammi wa-l-ḥazan, wa aʿūdhu bika mina-l-ʿajzi wa-l-kasal, wa aʿūdhu bika mina-l-jubni wa-l-bukhl, wa aʿūdhu bika min ġalabati-d-dayni wa qahrir-rijāl.",
      "reference":"O Allah, I seek refuge in You from anxiety and sorrow, weakness and laziness, miserliness and cowardice, the burden of debts and from being over powered by men",
    },
    {
      "ayah":'رَبِّ إِنِّيْ لِمَآ أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيْرٌ',
      "translation":"Rabbī innī limā anzalta ilayya min khayrin faqīr.",
      "reference":"My Lord, indeed I am, for whatever good You would send down to me, in need.",
    },
    {
       "ayah":'رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
      "translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
      "reference":"My Lord, indeed I have wronged myself, so forgive me.",
    },
    {
      "ayah":'رَبِّ اغْفِرْ وَارْحَمْ وَأَنْتَ خَيْرُ الرَّاحِمِيْنَ',
      "translation":"Rabbighfir warḥam wa-anta khayru-r-raḥimīn.",
      "reference":"My Lord, forgive and have mercy, for You are the best of the merciful.",
    },
    {
      "ayah":'رَبِّ اغْفِرْ لِيْ وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيْمُ',
      "translation":"Rabbighfir lī wa tub ʿalayya innaka anta-t-tawwābu r-raḥīm.",
      "reference":"My Lord, forgive me and accept my repentance. Indeed, You are the Accepting of Repentance, the Merciful.",
    },
    {
      "ayah":'يَا حَيُّ يَا قَيُّوْمُ ، بِرَحْمَتِكَ أَسْتَغِيْثُ ، أَصْلِحْ لِيْ شَأْنِيْ كُلَّهُ ، وَلَا تَكِلْنِيْ إِلَىٰ نَفْسِيْ طَرْفَةَ عَيْنٍ',
      "translation":'Yā ḥayyu yā qayyūmu, bi-raḥmatika astaghīthu, aṣliḥ lī shaʾnī kullahu, wa lā takilnī ilā nafsī ṭarfata ʿaynin.',
      "reference":"O Ever-Living, O Sustainer, I seek help in Your mercy. Correct all my affairs and do not entrust me to myself for the blink of an eye.",
    },
    {
      "ayah":'اَللّٰهُمَّ عَافِنِيْ فِيْ بَدَنِيْ ، اَللّٰهُمَّ عَافِنِيْ فِيْ سَمْعِيْ ، اَللّٰهُمَّ عَافِنِيْ فِيْ بَصَرِيْ ، لَا إِلٰهَ إِلَّا أَنْتَ ، اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، وأَعُوْذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلٰهَ إِلَّا أَنْتَ',
      "translation":"Allāhumma ʿāfinī fī badanī, allāhumma ʿāfinī fī samʿī, allāhumma ʿāfinī fī baṣarī, lā ilāha illā anta, allāhumma innī aʿūdhu bika mina-l-kufr wa-l-faqr, wa-aʿūdhu bika min ʿadhābi-l-qabr, lā ilāha illā anta.",
      "reference":"O Allah, grant me health in my body. O Allah, grant me health in my hearing. O Allah, grant me health in my sight. There is no god but You. O Allah, I seek refuge in You from disbelief and poverty, and I seek refuge in You from the punishment of the grave. There is no god but You.",
    },
    {
      "ayah":'للّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنْ ضِيْقِ الدُّنْيَا وَضِيْقِ يَوْمِ الْقِيَامَةِ',
      "translation":"Allāhumma innī aʿūdhu bika min ḍiqi-d-dunyā wa-ḍiqi yawmi-l-qiyāmah.",
      "reference":"O Allah, I seek refuge in You from the distress of this world and the distress of the Day of Resurrection.",
    },],
    "Scared":[
      {
        "ayah":'أَعُوْذُ بِكَلِمَاتِ اللّٰهِ التَّامَّاتِ مِنْ غَضَبِهِ وَعِقَابِهِ ، وَشَرِّ عِبَادِهِ ، وَمِنْ هَمَزَاتِ الشَّيَاطِيْنِ وَأَنْ يَّحْضُرُوْنِ',
        "translation":"Aʿūdhu bi-kalimāti-llāhi-t-tāmmāti min ġaḍabihi wa-ʿiqābihi, wa-šarri ʿibādihi, wa-min ḥamzāti š-šayāṭīn wa-an yaḥḍurūn.",
        "reference":"I seek refuge in the perfect words of Allah from His anger and punishment, from the evil of His servants, from the taunts of devils and from their presence.",
      },
      {"ayah":'اَللّٰهُمَّ اكْفِنِيْهِمْ بِمَا شِئْتَ'
      ,"translation":"Allāhumma kfinīhim bimā šiʾta.",
      "reference":"O Allah, suffice [i.e., protect] me against them however You wish.",
      },
    {
      "ayah":'اَللّٰهُمَّ إِنَّا نَجْعَلُكَ فِيْ نُحُوْرِهِمْ ، وَنَعُوْذُ بِكَ مِنْ شُرُوْرِهِمْ',
      "translation":"Allāhumma innā najʿaluka fī nuḥūrihim, wa-naʿūdhu bika min šurūrihim.",
      "reference":"O Allah, we place you in front of them, and we seek refuge in You from their evil.",
    },
    {
      "ayah":'اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنْ عَذَابِ الْقَبْرِ ، وَمِنْ عَذَابِ جَهَنَّمَ ، وَمِنْ فِتْنَةِ الْمَحْيَا وَالْمَمَاتِ ، وَمِنْ شَرِّ فِتْنَةِ الْمَسِيْحِ الدَّجَّالِ',
      "translation":"Allāhumma innī aʿūdhu bika min ʿadhābi-l-qabr, wa-min ʿadhābi jahannama, wa-min fitnati-l-mahyā wa-l-mamāti, wa-min šarri fitnati-l-masīḥi d-dajjāl.",
      "reference":"O Allah, I seek refuge in You from the punishment of the grave, from the torment of Hell, from the trials of life and death, and from the evil trial of the False Messiah.",
    },
    {
      "ayah":'اَللّٰهُمَّ إِنَّا نَجْعَلُكَ فِيْ نُحُوْرِهِمْ ، وَنَعُوْذُ بِكَ مِنْ شُرُوْرِهِمْ'
      ,"translation":"Allāhumma innā najʿaluka fī nuḥūrihim, wa-naʿūdhu bika min šurūrihim.",
      "reference":"O Allah, we place you in front of them, and we seek refuge in You from their evil.",
   },
   {
    "ayah":'اَللّٰهُمَّ إِنَّا نَجْعَلُكَ فِيْ نُحُوْرِهِمْ ، وَنَعُوْذُ بِكَ مِنْ شُرُوْرِهِمْ',
      "traslation":'Allāhumma innā najʿaluka fī nuḥūrihim, wa naʿūdhu bika min shurūrihim.',
      "reference":'O Allah, we make You our shield against them and we seek refuge in You from their evil. '
   },
{
  "ayah":'  اَللّٰهُمَّ أنْتَ عَضُدِيْ وَأَنْتَ نَصِيْرِيْ ، بِكَ أَحُوْلُ ، وبِكَ أصُوْلُ ، وَبِكَ أُقَاتِلُ ',
  "translation":'Allāhumma Anta Aḍudī wa Anta Naṣīrī, Bika aḥūlu, wa bika aṣūlu, wa bika uqātil.',
  "reference":'O Allah, You are my aid and helper; by You I move, by You I attack, and by You I fight.',
},],
"Suicidal":[
{
  "ayah":' اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ ، وَأَعُوْذُ بِكَ مِنَ الْعَجْزِ وَالْكَسَلِ، وَأَعُوْذُ بِكَ مِنَ الْجُبْنِ وَالْبُخْلِ ، وَأَعُوْذُ بِكَ مِنْ غَلَبَةِ الدَّيْنِ وَقَهْرِ الرِّجَالِ',
  "translation":"Allāhumma innī aʿūdhu bika mina-l-hammi wa-l-ḥazan, wa aʿūdhu bika mina-l-ʿajzi wa-l-kasal, wa aʿūdhu bika mina-l-jubni wa-l-bukhl, wa aʿūdhu bika min ġalabati-d-dayni wa qahrir-rijāl.",
  "reference":"O Allah, I seek refuge in You from anxiety and sorrow, weakness and laziness, miserliness and cowardice, the burden of debts and from being overpowered by men",

},
{
  "ayah":'رَبِّ أَعُوْذُ بِكَ مِنْ هَمَزَاتِ الشَّيَاطِيْنِ ، وَأَعُوذُ بِكَ رَبِّ أَنْ يَّحْضُرُوْنِ',
  "translation":"Rabbī aʿūdhu bika min hamazāti š-šayāṭīn, wa aʿūdhu bika rabbi an yaḥḍurūn.",
  "reference":"My Lord, I seek refuge in You from the incitements of devils, and I seek refuge in You, my Lord, lest they be present with me.",
},
{
  "ayah":'رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
  "translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
  "reference":'My Lord, indeed I have wronged myself, so forgive me.',

},{
  "ayah":'-رَبِّ- أَنِّيْ مَسَّنِيَ الضُّرُّ وَأَنْتَ أَرْحَمُ الرّٰحِمِيْن',
  "translation":"Rabbi innī massanīya-ḍ-ḍurru wa-anta arḥamu-r-raḥimīn.",
  "reference": 'My Lord, indeed I have been touched by hardship, and You are the Most Merciful of the merciful.',
},
{
  "ayah":'اَللّٰهُمَّ أَحْيِنِيْ مَا كَانَتِ الْحَيَاةُ خَيْرًا لِيْ ، وَتَوَفَّنِيْ إِذَا كَانَتِ الْوَفَاةُ خَيْرًا لِيْ',
  "translation":"Allāhumma aḥyinī mā kānatil-ḥayātu ḫayran lī, wa-tawaffanī idhā kānatil-wafātu ḫayran lī.",
  "reference":"O Allah, let me live as long as life is better for me, and give me death when death is better for me.",
},

    ],
    "Tired":[
      {
        "ayah":'اَللّٰهُمَّ عَافِنِيْ فِيْ بَدَنِيْ ، اَللّٰهُمَّ عَافِنِيْ فِيْ سَمْعِيْ ، اَللّٰهُمَّ عَافِنِيْ فِيْ بَصَرِيْ ، لَا إِلٰهَ إِلَّا أَنْتَ ، اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، وأَعُوْذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلٰهَ إِلَّا أَنْتَ',
        "translation":"Allāhumma ʿāfinī fī badanī, allāhumma ʿāfinī fī samʿī, allāhumma ʿāfinī fī baṣarī, lā ilāha illā anta, allāhumma innī aʿūdhu bika mina-l-kufr wa-l-faqr, wa-aʿūdhu bika min ʿadhābi-l-qabr, lā ilāha illā anta.",
        "reference":"O Allah, grant me health in my body. O Allah, grant me health in my hearing. O Allah, grant me health in my sight. There is no god but You. O Allah, I seek refuge in You from disbelief and poverty, and I seek refuge in You from the punishment of the grave. There is no god but You.",
      },
      {
        "ayah":'اَللّٰهُمَّ إِنَّا نَجْعَلُكَ فِيْ نُحُوْرِهِمْ ، وَنَعُوْذُ بِكَ مِنْ شُرُوْرِهِمْ',
        "translation":"Allāhumma innā najʿaluka fī nuḥūrihim, wa-naʿūdhu bika min šurūrihim.",
        "reference":"O Allah, we place you in front of them, and we seek refuge in You from their evil.",
      }
    ],
    "Unloved":[
      {
        "ayah": 'رَبِّ إِنِّيْ مَغْلُوبٌ فَانْتَصِرْ',
        "translation":"Rabbī innī maghlūbun fantasir.",
        "reference":"My Lord, indeed I am overwhelmed, so help [me].",
      },
      {
        "ayah":'حَسْبُنَا اللّٰهُ وَنِعْمَ الْوَكِيْلُ',
        "translation":"Ḥasbunā-llāhu wa-niʿma-l-wakīl.",
        "reference":"Allah is sufficient for us, and He is the best Disposer of affairs.",
      },
      {
        "ayah":'حَسْبِيَ اللّٰهُ لَا إِلٰهَ إِلَّا هُوَ ، عَلَيْهِ تَوَكَّلْتُ ، وَهُوَ رَبُّ الْعَرْشِ الْعَظِيْمِ',
        "translation":"Ḥasbīya-llāhu lā ilāha illā huwa, ʿalayhi tawakkaltu, wa-huwa rabbu-l-ʿarshi-l-ʿaẓīm.",
        "reference":"Allah is sufficient for me. There is no god but Him. I have placed my trust in Him, and He is the Lord of the Majestic Throne.",
      },
      {
        "ayah":'رَبِّ إِنِّيْ لِمَآ أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيْرٌ'
        ,"translation":"Rabbī innī limā anzalta ilayya min khayrin faqīr.",
        "reference":"My Lord, indeed I am, for whatever good You would send down to me, in need.",
      },
      {
        "ayah":'اَللّٰهُمَّ ارْزُقْـنِيْ حُبَّكَ ، وَحُبَّ مَنْ يَّنْفَعُنِيْ حُبُّهُ عِنْدَكَ ، اَللّٰهُمَّ مَا رَزَقْتَنِيْ مِمَّا أُحِبُّ فَاجْعَلْهُ قُوَّةً لِّيْ فِيْمَا تُحِبُّ ، اَللّٰهُمَّ مَا زَوَيْتَ عَنِّيْ مِمَّا أُحِبُّ فَاجْعَلْهُ فَرَاغًا لِّيْ فِيْمَا تُحِبُ',
        "translation":"Allāhumma rzūqnī ḥubbaka, wa ḥubba ma-y-yanfaʿunī ḥubbuhu ʿindak, Allāhumma mā razaqtanī mim-mā uḥibbu fa-jʿalhu quwwata-l-lī fīmā tuḥibb, Allāhumma mā zawayta ʿannī mim-mā uḥibbu fa-jʿalhu farāgha-l-lī fīmā tuḥibb.",
      },
      {
        "ayah":'اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْعَافِيَةَ فِي الدُّنْيَا وَالْآخِرَةِ ، اَللّٰهُمَّ إِنِّيْ أَسْأَلُكَ الْعَفْوَ وَالْعَافِيَةَ فِيْ دِيْنِيْ وَدُنْيَايَ وَأَهْلِيْ وَمَالِيْ ، اَللّٰهُمَّ اسْتُرْ عَوْرَاتِيْ وَآمِنْ رَوْعَاتِيْ ، اَللّٰهُمَّ احْفَظْنِيْ مِنْ بَيْنِ يَدَيَّ ، وَمِنْ خَلْفِيْ ، وَعَنْ يَّمِيْنِيْ ، وَعَنْ شِمَالِيْ ، وَمِنْ فَوْقِيْ ، وَأَعُوْذُ بِعَظَمَتِكَ أَنْ أُغْتَالَ مِنْ تَحْتِيْ',
        "translation":"Allāhumma innī as’aluka-l-ʿāfiyata fī-d-dunyā wa-l-ākhirah, Allāhumma innī as’aluka-l-ʿafwa wa-l-ʿāfiyata fī dīnī wa-dunyāy wa-ahliy wa-mālī, Allāhumma ustr ʿawrātī wa-āmin rawʿātī, Allāhumma iḥfaẓnī min bayni yadayya, wa-min khalfī, wa-ʿan yamīnī, wa-ʿan šimālī, wa-min fawqī, wa-aʿūdhu bi-ʿaẓamatika an uġtāla min taḥtī.",
        "reference":"O Allah, I ask You for well-being in this world and the Hereafter. O Allah, I ask You for forgiveness and well-being in my religion, my worldly affairs, my family, and my wealth. O Allah, conceal my faults, calm my fears, and protect me from before me and behind me, from my right and my left, and from above me. I seek refuge in Your greatness from being killed from below me.",
      },

    ],
    "Weak":[
      {
        "ayah":'اَللّٰهُمَّ عَافِنِيْ فِيْ بَدَنِيْ ، اَللّٰهُمَّ عَافِنِيْ فِيْ سَمْعِيْ ، اَللّٰهُمَّ عَافِنِيْ فِيْ بَصَرِيْ ، لَا إِلٰهَ إِلَّا أَنْتَ ، اَللّٰهُمَّ إِنِّيْ أَعُوْذُ بِكَ مِنَ الْكُفْرِ وَالْفَقْرِ، وأَعُوْذُ بِكَ مِنْ عَذَابِ الْقَبْرِ، لَا إِلٰهَ إِلَّا أَنْتَ',
        "translation":"Allāhumma ʿāfinī fī badanī, allāhumma ʿāfinī fī samʿī, allāhumma ʿāfinī fī baṣarī, lā ilāha illā anta, allāhumma innī aʿūdhu bika mina-l-kufr wa-l-faqr, wa-aʿūdhu bika min ʿadhābi-l-qabr, lā ilāha illā anta.",
        "reference":"O Allah, grant me health in my body. O Allah, grant me health in my hearing. O Allah, grant me health in my sight. There is no god but You. O Allah, I seek refuge in You from disbelief and poverty, and I seek refuge in You from the punishment of the grave. There is no god but You.",
      },
      {
        "ayah":'رَبِّ إِنِّيْ لِمَآ أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيْرٌ',
        "translation":"Rabbī innī limā anzalta ilayya min khayrin faqīr.",
        "reference":"My Lord, indeed I am, for whatever good You would send down to me, in need.",
      },
      {
        "ayah":'اَللّٰهُمَّ لَا سَهْلَ إِلَّا مَا جَعَلْتَهُ سَهْلًا ، وَأَنْتَ تَجْعَلُ الْحَزْنَ إِذَا شِئْتَ سَهْلًا',
        "translation":"Allāhumma lā sahla illā mā jaʿaltahu sahlan, wa-anta tajʿalu-l-ḥazna idhā šiʾta sahlan.",
        "reference":"O Allah, there is no ease except in that which You have made easy, and You make the difficulty, if You wish, easy.",

      },
      {
        "ayah":'رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
        "translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
        "reference":"My Lord, indeed I have wronged myself, so forgive me.",
      }
    ],
    "Anticipation":[
      {"ayah":'اللهم إن كان هذا الأمر خيرا لي فَاقْدُرْهُ لِي وَيَسِّرْهُ لِي ثُمَّ بَارِكْ لِي فِيهِ',
      "translation":"Allāhumma in kāna hādha-l-amru ḫayran lī fa-qdurhu lī wa yassirhu lī, ṯumma bārik lī fīhi.",
      "reference":"O Allah, if this matter is good for me, then decree it for me, make it easy for me, and bless it for me.",
      },
      {
        "ayah":'رَبِّ إِنِّيْ لِمَآ أَنْزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيْرٌ',
        "translation":"Rabbī innī limā anzalta ilayya min khayrin faqīr.",
        "reference":"My Lord, indeed I am, for whatever good You would send down to me, in need.",
      },
      {
        "ayah":'رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
        "translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
        "reference":"My Lord, indeed I have wronged myself, so forgive me.",
      },
      {
        "ayah":'رَبِّ اغْفِرْ وَارْحَمْ وَأَنْتَ خَيْرُ الرَّاحِمِيْنَ',
        "translation":"Rabbighfir warḥam wa-anta khayru-r-raḥimīn.",
        "reference":"My Lord, forgive and have mercy, for You are the best of the merciful.",
      },
      {
        "ayah":'رَبِّ اغْفِرْ لِيْ وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الرَّحِيْمُ',
        "translation":"Rabbighfir lī wa tub ʿalayya innaka anta-t-tawwābu r-raḥīm.",
        "reference":"My Lord, forgive me and accept my repentance. Indeed, You are the Accepting of Repentance, the Merciful.",
      },
    
    ],
    "Aroused":[
      {
        "ayah":'اللهم غض بصرى و حصن فرجى و طهر قلبى',
        "translation":"Allahumma ghad bṣarī wa ḥaṣin farjī wa ṭahhir qalbī.",
        "reference":"O Allah, lower my gaze, protect my chastity, and purify my heart.",
      },
      {
        "ayah":' رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
        "translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
        "reference":"My Lord, indeed I have wronged myself, so forgive me.",
      }
    ],
    "Curious":[
      {
        "ayah":"اللهم إني أعوذ بك من شر سمعي، ومن شر بصري، ومن شر لساني، ومن شر قلبي، ومن شر منيي",
        "translation":"Allāhumma innī aʿūdhu bika min šarri samʿī, wa min šarri baṣarī, wa min šarri lisānī, wa min šarri qalbī, wa min šarri manīyī.",
        "reference":"O Allah, I seek refuge in You from the evil of my hearing, the evil of my sight, the evil of my tongue, the evil of my heart, and the evil of my semen.",
      },
      {
        "ayah":'رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
        "translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
        "reference":"My Lord, indeed I have wronged myself, so forgive me.",
      }
    ],
    "Defeated":[
      {
        "ayah":'اللهمّ إنّي ظلمت نفسي ظلماً كثيراً، ولا يغفر الذّنوب إلا أنت فاغفر لي مغفرة من عندك، وارحمني إنّك أنت الغفور الرّحيم',
        "translation":"Allāhumma innī ẓalamtu nafsī ẓulman kathīrā, wa lā yaghfiru-ḏ-ḏunūba illā anta faghfir lī maghfiratan min ʿindika, wa-irḥamnī innaka anta-l-ġafūru r-raḥīm.",
        "reference":"O Allah, I have greatly wronged myself and no one forgives sins but You. So, grant me forgiveness from You and have mercy on me. Surely, You are the Most-Forgiving, Most-Merciful.",
      },
      {
        "ayah":' رَبِّ إِنِّيْ ظَلَمْتُ نَفْسِيْ فَاغْفِرْ لِيْ',
        "translation":"Rabbī innī ẓalamtu nafsī, faghfir lī.",
        "reference":"My Lord, indeed I have wronged myself, so forgive me.",
      },
      {
        "ayah":"رَبِّ إِنِّي لِمَا أَنزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقِيرٌ",
        "translation":"Rabbī innī limā anzalta ilayya min khayrin faqīr.",
        "reference":"My Lord, indeed I am, for whatever good You would send down to me, in need.",
      }
    ],
    "Desire":[
      {
        "ayah":'اللهم اطفئ نار الشهوات من قلبى ، واصرف عنه كل شئ لا يرضيك عنى',
        "translation":"Allāhumma iṭfiʾ nāraš-šahawāti min qalbī, waṣrif ʿanhu kulla šayʾin lā yardīka ʿannī.",
        "reference":"O Allah, extinguish the fire of my desires in my heart, and turn away from it everything that does not please You.",
      }
    ],
    " Desperate":[
      {
        "ayah":'اللهم إليك أشكو ضعف قوتي وقلة حيلتي وهواني على الناس يا أرحم الراحمين أنت ربُّ المستضعفين وانت ربّي ',
        "translation":"Allāhumma ilayka ašku ḍaʿfa quwwatī wa qillata ḥīlatī wa hawānī ʿalā-n-nāsi yā arḥama-r-raḥimīn, anta rabbu-l-mustaḍʿafīn wa anta rabbī",
        "reference":"O Allah, to You I complain of my weakness, my lack of resources, and my lowliness before people. O Most Merciful, You are the Lord of the weak, and You are my Lord.",
      }  ,
      {
        "ayah":'رَبِّ اغْفِرْ وَارْحَمْ وَأَنْتَ خَيْرُ الرَّاحِمِيْنَ',
        "translation":"Rabbighfir warḥam wa-anta khayru-r-raḥimīn.",
        "reference":"My Lord, forgive and have mercy, for You are the best of the merciful.",
      }
    ],
    "Determined":
    [
      {
        "ayah":'اللهم امنحني القوة لأقاوم نفسي، والشجاعة لأواجه ضعفي، واليقين لأتقبل قدري، والرضا ليرتاح عقلي، والفهم ليطمئن قلبي',
        "translation":"Allāhumma amnīni-l-quwwata li-aqāwim nafsī, wa-š-šujāʿata li-awāǧih ḍaʿfī, wa-lyaqīna li-atqabil qadarī, wa-r-riḍā li-yartāḥ ʿaqlī, wa-l-fahma li-yatmaʾin qalbī.",
        "reference":"O Allah, grant me the strength to resist my self, the courage to face my weakness, the certainty to accept my fate, the satisfaction to rest my mind, and the understanding to calm my heart.",
      }
    ],
    "Disbelief":[
      {
        "ayah":'اللهم املأ قلبى بحبك',
        "translation":"Allāhumma amla qalbī biḥubbik.",
        "reference":"O Allah, fill my heart with Your love.",
      },

    ],
    "Envious":[
      {
        "ayah":'اللهم طهر قلبي من كل سوء ، اللهم طهر قلبي من كل ما يبغضك، اللهم طهر قلبي من كل غلٍ وحقدٍ وحسد وكبر',
        "translation":"Allāhumma ṭahhir qalbī min kulli suwʾ, allāhumma ṭahhir qalbī min kulli mā yubġidhuk, allāhumma ṭahhir qalbī min kulli ġilin wa ḥaqqin wa ḥasad wa kabr.",
        "reference":"O Allah, purify my heart from all evil. O Allah, purify my heart from everything that displeases You. O Allah, purify my heart from all envy, hatred, and arrogance.",
      }
      ,

    ],
    "Hatred":[
      {
        "ayah":'اللهم إني أعوذ بك من البغض والحسد',
        "translation":"Allāhumma innī aʿūdhu bika mina-l-buġḍi wa-l-ḥasad.",
        "reference":"O Allah, I seek refuge in You from hatred and envy.",
      },
      {
        "ayah":'اللهم لا تجعل في قلبي كراهية لأحد',
        "translation":"Allāhumma lā tajʿal fī qalbī karāhatan li-aḥadin.",
        "reference":"O Allah, do not place in my heart hatred for anyone.",
      }
    ],
"Humiliated":[
  {
    "ayah":'اللهم إليك أشكو ضعف قوتي وقلة حيلتي وهواني على الناس يا أرحم الراحمين أنت ربُّ المستضعفين وانت ربّي',
    "translation":"Allāhumma ilayka ašku ḍaʿfa quwwatī wa qillata ḥīlatī wa hawānī ʿalā-n-nāsi yā arḥama-r-raḥimīn, anta rabbu-l-mustaḍʿafīn wa anta rabbī",
    "reference":"O Allah, to You I complain of my weakness, my lack of resources, and my lowliness before people. O Most Merciful, You are the Lord of the weak, and You are my Lord.",
  },
 
  {
    "ayah":"رَبِّ إِنِّي لِمَا أَنزَلْتَ إِلَيَّ مِنْ خَيْرٍ فَقيرٌ",
    "translation":"Rabbī innī limā anzalta ilayya min khayrin faqīr.",
    "reference":"My Lord, indeed I am, for whatever good You would send down to me, in need.",
  }
],
"Impatient":[
  {
    "ayah":' اللهم إني أعوذ بك من العجز والكسل والجبن والبخل والهرم وغلبة الدين وقهر الرجال',
    "translation":"Allāhumma innī aʿūdhu bika mina-l-ʿajzi wa-l-kasal wa-l-ǧubni wa-l-bukhl wa-l-ḥaram wa ġalabati-d-dayni wa qahrir-rijāl.",
    "reference":"O Allah, I seek refuge in You from helplessness, laziness, cowardice, miserliness, overwhelming debt, and the oppression of men",

  },
  {
  "ayah":'يا صبور صبّرني على ما بلوتني وامتحنتني',
  "translation":"Yā ṣabūr ṣabbarnī ʿalā mā balawtanī wa-imtaḥantnī.",
  "reference":"O Most Patient, make me patient with what You have tested me with and tried me with.",}],
   "Insecure":[
    {
      "ayah":"اللهم اجعلني أرى المواهب و نقاط قوت الذين وضعته في نفسي",
      "translation":"Allāhumma iǧʿalnī ʾarā-l-mawāhib wa nuqāṭ quwwati-l-laḏīna waḍaʿtahu fī nafsī.",
      "reference":"O Allah, make me see the talents and strengths of those You have placed within me.",
    }
   ],
   "Irritated":[
    {
      "ayah":' اللهم طهر قلبي من كل سوء ، اللهم طهر قلبي من كل ما يبغضك، اللهم طهر قلبي من كل غلٍ وحقدٍ وحسد وكبر ',
       "translation":'Allahumma Tahhir Qalbee min kulli suu, Allahumma Tahhir Qalbee min kulli maa yubaGGiDuk. Allahumma Tahhir Qalbee min kulli Gillin wa HiQdin wa Hasadin wa kibr. ',
        "reference":"O Allah, purify my heart from all evil. O Allah, purify my heart from everything that displeases You. O Allah, purify my heart from all envy, hatred, and arrogance.",
    },{
       "ayah":'اللهم إني أعوذ بك من البغض والحسد',
        "translation":"Allāhumma innī aʿūdhu bika mina-l-buġḍi wa-l-ḥasad.",
        "reference":"O Allah, I seek refuge in You from hatred and envy.",},
    {
      "ayah":'اللهم لا تجعل في قلبي كراهية لأحد',
      "translation":"Allāhumma lā tajʿal fī qalbī karāhatan li-aḥadin.",
      "reference":"O Allah, do not place in my heart hatred for anyone.",
    }
    ],
    "Love":[
      {
        "ayah":"اللهم اجعلني من الطيبات وارزقني الطيبين",
        "translation":" ( FOR HER ) Allāhumma iǧʿalnī mina-ṭ-ṭayyibāti wa-rzuqnī-ṭ-ṭayyibīn.",
        "reference":"O Allah, make me among the righteous and provide me with righteous people.",
      },
      {
        "ayah":'اللهم اجعلني من الطيبين وارزقني الطيبات',
        "translation":" (FOR HIM ) Allāhumma iǧʿalnī mina-ṭ-ṭayyibīn wa-rzuqnī-ṭ-ṭayyibāt.",
        "reference":"O Allah, make me among the righteous and provide me with righteous people.",
      },
      {
        "ayah":'اللهم امنحني القوة لأقاوم نفسي، والشجاعة لأواجه ضعفي، واليقين لأتقبل قدري، والرضا ليرتاح عقلي، والفهم ليطمئن قلبي',
        "translation":"Allāhumma amnīni-l-quwwata li-aqāwim nafsī, wa-š-šujāʿata li-awāǧih ḍaʿfī, wa-lyaqīna li-atqabil qadarī, wa-r-riḍā li-yartāḥ ʿaqlī, wa-l-fahma li-yatmaʾin qalbī.",
        "reference":"O Allah, grant me the strength to resist my self, the courage to face my weakness, the certainty to accept my fate, the satisfaction to rest my mind, and the understanding to calm my heart.",
      }
    ],
    "Nostalgic":
    [
      {
        "ayah":'اللهم لَا تُعَلِّقْ قَلْبِي الضِّعِيفِ بِمَا لَيسَ لِي',
        "translation":"Allāhumma lā tuʿalliq qalbī aḍ-ḍiʿīfi bimā laysa lī.",
        "reference":"O Allah, do not attach my weak heart to what is not for me.",
      },
      {
        "ayah":'اللهم اجعلني أرى المواهب و نقاط قوت الذين وضعته في نفسي',
        "translation":"Allāhumma iǧʿalnī ʾarā-l-mawāhib wa nuqāṭ quwwati-l-laḏīna waḍaʿtahu fī nafsī.",
        "reference":"O Allah, make me see the talents and strengths of those You have placed within me.",
      },
      {
        "ayah":'اللهم امنحني القوة لأقاوم نفسي، والشجاعة لأواجه ضعفي، واليقين لأتقبل قدري، والرضا ليرتاح عقلي، والفهم ليطمئن قلبي',
        "translation":"Allāhumma amnīni-l-quwwata li-aqāwim nafsī, wa-š-šujāʿata li-awāǧih ḍaʿfī, wa-lyaqīna li-atqabil qadarī, wa-r-riḍā li-yartāḥ ʿaqlī, wa-l-fahma li-yatmaʾin qalbī.",
        "reference":"O Allah, grant me the strength to resist my self, the courage to face my weakness, the certainty to accept my fate, the satisfaction to rest my mind, and the understanding to calm my heart.",
      },
      
    ],
    "Offended":
    [
      {
        "ayah":'اللهم اجعلني أرى المواهب و نقاط قوت الذين وضعته في نفسي',
        "translation":"Allāhumma iǧʿalnī ʾarā-l-mawāhib wa nuqāṭ quwwati-l-laḏīna waḍaʿtahu fī nafsī.",
        "reference":"O Allah, make me see the talents and strengths of those You have placed within me.",
      },
       {
        "ayah": 'ْاللهم إنِّي أَعُوْذُ بِكَ مِنْ هَمِّ يَحْزُنُنِي وَمِنْ فِكْرِ يُقْلِقُنِيْ وَعِلْمَا يُتْعِبُنِيْ وَشَخْصَا يَحْمِلُ خُبْثَا لِي',
        "translation":"Allāhumma innī aʿūdhu bika min hammi yaḥzununī wa min fikri yuqliqunī wa ʿilman yutʿibunī wa šaḫṣan yaḥmilu ḫubṯan lī.",
        "reference":"O Allah, I seek refuge in You from worry that distresses me, from thoughts that disturb me, from knowledge that tires me, and from a person who carries evil towards me.",
       }
    ],
    "Peaceful":[
      {
        "ayah":'اللهم إني أعوذ بك من الهم والحزن والعجز والكسل والبخل والجبن وضلع الدين وغلبة الرجال',
        "translation":"Allāhumma innī aʿūdhu bika mina-l-hammi wa-l-ḥuzni wa-l-ʿajzi wa-l-kasli wa-l-bukhli wa-l-ǧubni wa-ḍalaʿi-d-dayni wa ġalabati-r-rijāl.",
        "reference":"O Allah, I seek refuge in You from worry and grief, from helplessness and laziness, from miserliness and cowardice, from the burden of debt and from being overpowered by men",

      },
      {
        "ayah":'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ زَوَالِ نِعْمَتِكَ، وَتَحَوُّلِ عَافِيَتِكَ، وَفُجَاءَةِ نِقْمَتِكَ، وَجَمِيعِ سَخَطِكَ',
        "translation":"Allāhumma innī aʿūdhu bika min zawāli niʿmatika, wa taḥawwuli ʿāfiyatika, wa fuǧāʾati niqmatika, wa ǧamīʿi sakhaṭika.",
        "reference":"O Allah, I seek refuge in You from the decline of Your blessings, the change of Your protection, the suddenness of Your punishment, and all Your displeasure.",
      },],
      "Rage":[
        {
          "ayah":'اللَّهُمَّ أَذْهِبْ غَيْظَ قَلْبِي',
          "translation":"Allāhumma aḏhib ġayḍa qalbī.",
          "reference":"O Allah, remove the rage from my heart.",
        },
        {
          "ayah":'اللهم اجعلني أرى المواهب و نقاط قوت الذين وضعته في نفسي',
          "translation":"Allāhumma iǧʿalnī ʾarā-l-mawāhib wa nuqāṭ quwwati-l-laḏīna waḍaʿtahu fī nafsī.",
          "reference":"O Allah, make me see the talents and strengths of those You have placed within me.",
        },
        {
          "ayah":'اللهم امنحني القوة لأقاوم نفسي، والشجاعة لأواجه ضعفي، واليقين لأتقبل قدري، والرضا ليرتاح عقلي، والفهم ليطمئن قلبي',
          "translation":"Allāhumma amnīni-l-quwwata li-aqāwim nafsī, wa-š-šujāʿata li-awāǧih ḍaʿfī, wa-lyaqīna li-atqabil qadarī, wa-r-riḍā li-yartāḥ ʿaqlī, wa-l-fahma li-yatmaʾin qalbī.",
          "reference":"O Allah, grant me the strength to resist my self, the courage to face my weakness, the certainty to accept my fate, the satisfaction to rest my mind, and the understanding to calm my heart.",
        }
      ],
      "Satisfied":[
        {"ayah":'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنْ زَوَالِ نِعْمَتِكَ، وَتَحَوُّلِ عَافِيَتِكَ، وَفُجَاءَةِ نِقْمَتِكَ، وَجَمِيعِ سَخَطِكَ',
        "translation":"Allāhumma innī aʿūdhu bika min zawāli niʿmatika, wa taḥawwuli ʿāfiyatika, wa fuǧāʾati niqmatika, wa ǧamīʿi sakhaṭika.",
        "reference":"O Allah, I seek refuge in You from the decline of Your blessings, the change of Your protection, the suddenness of Your punishment, and all Your displeasure.",
        
        }
      ],
      "Uncertain":[
        {
          "ayah":'اللهم اغسلني من السلبية',
          "translation":"Allāhumma ighsilnī mina-s-salbīya.",
          "reference":"O Allah, cleanse me of negativity.",
        },
          {
            "ayah":'اللهم اجعلني أرى المواهب و نقاط قوت الذين وضعته في نفسي',
            "translation":"Allāhumma iǧʿalnī ʾarā-l-mawāhib wa nuqāṭ quwwati-l-laḏīna waḍaʿtahu fī nafsī.",
            "reference":"O Allah, make me see the talents and strengths of those You have placed within me.",
          },
          
      ],
      "Uneasy":[
        {
          "ayah":'اللهم أنزِل عليّ سكينة من عندك تشرح بها صدري و تحفظُ بها قلبي',
          "translation":"Allāhumma anzil ʿalayya sakīnatan min ʿindika tašraḥu bihā ṣadrī wa taḥfaẓu bihā qalbī.",
          "reference":"O Allah, send down tranquility upon me from You, with which to expand my chest and to calm my heart.",
        },
        {
          "ayah":'اللهم اجعلني أرى المواهب و نقاط قوت الذين وضعته في نفسي',
          "translation":"Allāhumma iǧʿalnī ʾarā-l-mawāhib wa nuqāṭ quwwati-l-laḏīna waḍaʿtahu fī nafsī.",
          "reference":"O Allah, make me see the talents and strengths of those You have placed within me.",
        },
        {
          "ayah":'اللهم امنحني القوة لأقاوم نفسي، والشجاعة لأواجه ضعفي، واليقين لأتقبل قدري، والرضا ليرتاح عقلي، والفهم ليطمئن قلبي',
          "translation":"Allāhumma amnīni-l-quwwata li-aqāwim nafsī, wa-š-šujāʿata li-awāǧih ḍaʿfī, wa-lyaqīna li-atqabil qadarī, wa-r-riḍā li-yartāḥ ʿaqlī, wa-l-fahma li-yatmaʾin qalbī.",
          "reference":"O Allah, grant me the strength to resist my self, the courage to face my weakness, the certainty to accept my fate, the satisfaction to rest my mind, and the understanding to calm my heart.",
        }
      ],
'Jealous':[
        {
          "ayah":'اللهم طهر قلبي من كل سوء ، اللهم طهر قلبي من كل ما يبغضك، اللهم طهر قلبي من كل غلٍ وحقدٍ وحسد وكبر',
          "translation":"Allāhumma ṭahhir qalbī min kulli suwʾ, allāhumma ṭahhir qalbī min kulli mā yubġidhuk, allāhumma ṭahhir qalbī min kulli ġilin wa ḥaqqin wa ḥasad wa kibr.",
          "reference":"O Allah, purify my heart from all evil. O Allah, purify my heart from everything that displeases You. O Allah, purify my heart from all envy, hatred, and arrogance.",
        },
        {
          "ayah":'اللهم املأ قلبى بحبك',
          "translation":"Allāhumma amla qalbī biḥubbik.",
          "reference":"O Allah, fill my heart with Your love.",
        },
      ],


    };
       return {
      "emotion": emotion,
      "verses": verses[emotion] ?? []
    };
  }

  @override
  void initState() {
    super.initState();
    _loadLikedAyahs();
  }

  Future<void> _loadLikedAyahs() async {
    final user = _auth.currentUser;
    if (user == null) return;
    
    final snapshot = await _firestore.collection('users').doc(user.uid).collection('likedAyahs').get();
    final liked = {for (var doc in snapshot.docs) doc['ayah'] as String: true};
    setState(() => likedAyahs = liked);
  }

Future<void> _toggleLike(String ayah) async {
  final user = _auth.currentUser;
  if (user == null) return;

  final ayahRef = _firestore
      .collection('users')
      .doc(user.uid)
      .collection('likedAyahs')
      .doc(ayah);

  if (likedAyahs[ayah] == true) {
    await ayahRef.delete();
    setState(() {
      likedAyahs[ayah] = false;
    });
  } else {
    await ayahRef.set({"ayah": ayah});
    setState(() {
      likedAyahs[ayah] = true;
    });
  }

  print("Liked Ayahs: $likedAyahs"); // Debugging
}


  @override
  Widget build(BuildContext context) {
    final String emotion = widget.emotion;
    final data = getVerses(emotion);
    final versesList = data["verses"];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Quranic Verses for ${data['emotion']}", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: versesList.isEmpty
          ? Center(child: Text("No verses found for this emotion", style: TextStyle(color: Colors.black, fontSize: 18)))
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: versesList.length,
              itemBuilder: (context, index) {
                final verse = versesList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Text("#${index + 1}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                    SizedBox(height: 10),
                    Center(child: Text(verse["ayah"]!, style: GoogleFonts.amiri(fontSize: 20), textAlign: TextAlign.center)),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.format_quote, size: 40, color: Colors.pink.shade200),
                            Text(verse["translation"]!, style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic), textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                          Container(),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                                  width: 550,
                              child: SingleChildScrollView(
                            
                                child: Center(
                                  child: Text(
                                    "${verse["reference"]}",
                                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.w100,fontStyle: FontStyle.normal),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            await _audioPlayer.setUrl(verse["audio"]!);
                            await _audioPlayer.play();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Failed to play audio.")),
                            );
                          }
                        },
                        icon: Icon(Icons.play_arrow),
                        label: Text("Listen to Recitation"),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        likedAyahs[verse["ayah"]] == true ? Icons.favorite : Icons.favorite_border,
                        color: likedAyahs[verse["ayah"]] == true ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => _toggleLike(verse["ayah"]!),
                    ),
                    SizedBox(height: 30),
                  ],
                );
              },
            ),
    );
  }
}