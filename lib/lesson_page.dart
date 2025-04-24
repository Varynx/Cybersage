import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb

// 📚 Cybersecurity lessons with images and optional audio
final List<Map<String, String>> cybersecurityLessons = [
  {
    'title': 'What is Phishing?',
    'content':
        'Phishing attacks trick victims—often elderly—by impersonating trusted institutions like the SSA or IRS. These scams create fear, claiming benefits may be lost or legal trouble is imminent. (American Bar Association)'
    'Identity fraud targets victims by stealing personal information through phishing or social engineering. Attackers may then open accounts or loans in the victim’s name.'
        '\n\nAvoid Suspicious emails:\nClues, such as grammatical errors, or misspelled emails are common telltale signs of an email that you should lookout for. If'
        'they still truly believe that this may be a real problem, they should instead contact the organization or company directly via official telephone numbers or by visiting'
         'their official site and avoid using any phone numbers or links embedded within the suspicious email. If the email or text is offering a too good to be true offer, then '
         'it also is likely a phishing attempt as well, and the elderly should not interact with the email and instead report the email to the Federal Trade Commission (FTC). (Senior Consulting Advisors)',
           'top_image': 'Phishing_Fischer.png',
  },
  {
    'title': 'Phishing Example',
    'content':
        'Look closely at this phishing email. Common red flags include:\n\t ⦁A long recipient list\n ⦁\tBlank subject line\n ⦁\tImages or attachments referencing unfamiliar transactions',
    'bot1_image': 'Phishing_Example1.png',
    'bot2_image': 'Phishing_Example2.png',
  },
  {
    'title': 'What is Identity Fraud?',
    'content':
        'Identity fraud targets victims by stealing personal information through phishing or social engineering. Attackers may then open accounts or loans in the victim’s name.'
        '\n\nDo not answer unknown phone calls:\nAccording to the FTC, Medicare will not call you uninvited and will instead first send written statements in the mail instead, before calling you.'
        'This means that any phone call that are random or unexpected claim to be a Medicare associate, then it is likely a scam (Federal Trade Commission). This means that the elderly should' 
        'never give up personal information, such as their Medicare number or Social Security number, to anyone that threatens to cut off their benefits. Instead, the victim should immediately'
        'hang up the call. If the victim wishes to verify the authenticity of the phone call, they should call the association via official means, such as visiting the official site, and using the contact information found there.',

    'top_image': 'assets/Identity_Theft.png',
  },
  {
    'title': 'Identity Fraud Example',
    'content':
        'Example: Similarly, due to the lack of knowledge with technology, the elderly are very susceptible to identity fraud, as social engineering tactics or the use of phishing emails can lead to attackers gaining personal'
        'information about the victim that allows attackers to impersonate the victim for their personal gain, such as taking loans out in their name.',
        'bot1_image': 'Identity_Theft_Examples.png',
  },
  {
    'title': 'What is a Tech Support Scam?',
    'content':
        'Without the proper understanding of electronics, elderly people are also susceptible to the many tech scams that claim to find viruses on the victim’s device and are willing to remove them. These types of scams are often used to gain access to the victim’s device in order'
        'to steal banking information, passwords, or to have the elderly victim pay an exorbitant price to solve a problem that did not exist. (Senior Consulting Advisors)'
        '\n\nNever allow remote access to your devices:\nOften in tech scams, the attacker tricks the elderly victim into giving access to their devices, by installing malicious software that allows'
        'the attacker to access their devices remotely and allows full access to all information stored within the device, under the pretense that they'
        'need access to eliminate the virus. The victim should never give any remote access to unknown companies or people. Instead, if the victim is'
        'suffering from a problem, they should directly reach out the manufacturer of the device, or the store in which they bought it from. This will'
        'ensure that they are getting the actual help they need. The elderly should also avoid pop-ups that claim to perform virus cleaning or claim that'
        'the device is infected (Senior Consulting Advisors).',
    'top_image': 'assets/TechSupportScam_Skull.png',
  },
  {
    'title': 'Tech Support Scam Example',
    'content':
        'Example: A pop-up claims your computer is at risk. You call the number, and a scammer asks for remote access—then steals bank info or installs spyware.',
    'audio_web': 'web/assets/scam_audio2.mp3', // 🎧 Audio file for Web
    'audio_mobile': 'assets/scam_audio2.mp3', // 🎧 Audio file for Mobile
  },
];

// 🧠 Main lesson screen with lesson progression, audio, and images
class LessonPage extends StatefulWidget {
  const LessonPage({super.key});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  int currentLessonIndex = 0; // 🎯 Tracks current lesson index
  final AudioPlayer _audioPlayer = AudioPlayer(); // 🔉 Manages audio playback
  bool isPlaying = false; // 🔁 Audio state toggle

  // Clean up the audio player
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  // ▶ Move to the next lesson and stop any active audio
  void nextLesson() async {
    if (currentLessonIndex < cybersecurityLessons.length - 1) {
      await _audioPlayer.stop();
      setState(() {
        currentLessonIndex++;
        isPlaying = false;
      });
    }
  }

  // ◀ Return to the previous lesson and stop audio
  void previousLesson() async {
    if (currentLessonIndex > 0) {
      await _audioPlayer.stop();
      setState(() {
        currentLessonIndex--;
        isPlaying = false;
      });
    }
  }

  // 🎧 Toggle between playing and pausing audio
  void toggleAudio(String audioPathWeb, String audioPathMobile) async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      if (kIsWeb) {
        await _audioPlayer.play(UrlSource(audioPathWeb)); // Web audio
      } else {
        await _audioPlayer.play(AssetSource(audioPathMobile)); // Mobile audio
      }
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentLesson = cybersecurityLessons[currentLessonIndex];
    final hasAudio = currentLesson['audio_web'] != null || currentLesson['audio_mobile'] != null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CyberSage Lessons', style: TextStyle(fontSize: 22)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 🎨 Lesson header with image and title
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.secondary,
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  if (currentLesson['top_image'] != null)
                    Image.asset(
                      currentLesson['top_image']!,
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  const SizedBox(height: 16),
                  Text(
                    currentLesson['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lesson ${currentLessonIndex + 1} of ${cybersecurityLessons.length}',
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 📖 Main content area with optional image and audio button
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (currentLesson['bot1_image'] != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Center(
                            child: Image.asset(
                              currentLesson['bot1_image']!,
                              height: 500,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        if (currentLesson['bot2_image'] != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Center(
                            child: Image.asset(
                              currentLesson['bot2_image']!,
                              height: 500,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        if (currentLesson['bot3_image'] != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Center(
                            child: Image.asset(
                              currentLesson['bot3_image']!,
                              height: 500,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      Text(
                        currentLesson['content'] ?? '',
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 24),
                      if (hasAudio)
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () => toggleAudio(
                              currentLesson['audio_web'] ?? '', // Web Audio Path
                              currentLesson['audio_mobile'] ?? '', // Mobile Audio Path
                            ),
                            icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                            label: Text(isPlaying ? 'Pause Audio' : 'Play Audio'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              foregroundColor: Theme.of(context).colorScheme.onPrimary,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔄 Navigation controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: currentLessonIndex > 0 ? previousLesson : null,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text(
                      'Previous',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: currentLessonIndex < cybersecurityLessons.length - 1 ? nextLesson : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Next', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
