import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// List of cybersecurity quiz questions for seniors
final List<Map<String, dynamic>> quizQuestions = [
  {
    'question': 'A pop-up window appears on your device while browsing the internet, claiming that your device is infected with a virus,' 
    ' and to call the number on your screen to help remove the virus. Should you:',
    'options': [
      'Call the number and follow their directions to help you remove the virus.', 
      'Ignore and close the message.', 
      'A computer virus that damages your files', 
      'A method of fixing computer problems remotely'
    ],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'You received an email claiming that you have won free healthcare as part of a giveaway run by your insurance company. '
    ' To claim the offer, you must log in to your account and click accept. Below the message contains a login button. Should you:',
    'options': [
      'Click on the login button and log in to your account.', 
      'Reply to the email to confirm its legitimacy.', 
      'Do not click the link, and delete the email.', 
      'Forward the email to friends to let them know of your prize.'
    ],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'Which of these is a sign that an email might be a scam?',
    'options': [
      'It\'s from someone you know and contains normal conversation', 
      'It has urgent language demanding immediate action', 
      'It has the company\'s correct logo', 
      'It addresses you by your full name'
    ],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'You notice a suspicious charge on your credit card statement from an unknown online store. How should you respond?',
    'options': [
      'Ignore the charge, and assume it is a mistake and will be corrected', 
      'Make a payment to avoid any late payment fees and investigate at a later time.', 
      'Call the company that issued the charge and report the charge.', 
      'Ask a family member if they made the purchase.'
    ],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'What should you do if someone calls claiming to be from Microsoft or Apple saying there\'s a problem with your computer?',
    'options': [
      'Give them remote access to your computer', 
      'Provide your credit card to pay for their support', 
      'Hang up immediately - this is a common scam', 
      'Tell them your computer\'s password'
    ],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'Which of these is a safe way to share sensitive documents?',
    'options': [
      'Posting them on social media', 
      'Using secure, encrypted email or file-sharing services', 
      'Sending them as email attachments to everyone', 
      'Using public WiFi to send them quickly'
    ],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'What is "two-factor authentication"?',
    'options': [
      'Having two different passwords for the same account', 
      'An extra security step that requires both a password and a temporary code', 
      'Logging in twice to make sure the system recognizes you', 
      'Having two people verify your identity'
    ],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'If a loved one sends you a message saying they\'re stranded overseas and need money urgently, what should you do first?',
    'options': [
      'Send money immediately through wire transfer', 
      'Purchase gift cards and send the codes as requested', 
      'Contact them directly through a different method to verify it\'s really them', 
      'Share your bank account details so they can access your funds'
    ],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'What information is generally safe to share on social media?',
    'options': [
      'Your full birth date including year', 
      'When you\'re going on vacation and your home will be empty', 
      'General hobbies and interests', 
      'Your home address and phone number'
    ],
    'correctAnswerIndex': 2,
  },
  {
    'question': 'If you receive a text message saying you\'ve won a prize and need to click a link to claim it, what should you do?',
    'options': [
      'Click the link immediately to claim your prize', 
      'Delete the message - this is likely a scam', 
      'Reply with your personal information', 
      'Forward it to everyone in your contacts'
    ],
    'correctAnswerIndex': 1,
  },
];

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  // Track current question index
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  int? selectedAnswerIndex;
  bool isAnswerSubmitted = false;
  int score = 0;

  void nextQuestion() {
    if (currentQuestionIndex < quizQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        selectedAnswerIndex = null;
        isAnswerSubmitted = false;
      });
    } else {
      // Show quiz completion dialog
      showQuizCompletionDialog();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedAnswer = null;
        selectedAnswerIndex = null;
        isAnswerSubmitted = false;
      });
    }
  }

  void showQuizCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        //this sets up the alert Dialog pop-up when the user has completed the quiz
        return AlertDialog(
          title: const Text('Quiz Completed!', 
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your Score: $score out of ${quizQuestions.length}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              const Text(
                'Thank you for completing the cybersecurity quiz!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Return to Login', style: TextStyle(fontSize: 18)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  currentQuestionIndex = 0;
                  selectedAnswer = null;
                  selectedAnswerIndex = null;
                  isAnswerSubmitted = false;
                  score = 0;
                });
              },
              child: const Text('Try Again', style: TextStyle(fontSize: 18)),
            ),
          ],
        );
      },
    );
  }

  void submitAnswer() {
    if (selectedAnswerIndex != null && !isAnswerSubmitted) {
      setState(() {
        isAnswerSubmitted = true;
        if (selectedAnswerIndex == quizQuestions[currentQuestionIndex]['correctAnswerIndex']) {
          score++;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get current question data
    final currentQuestion = quizQuestions[currentQuestionIndex];
    final List<String> options = List<String>.from(currentQuestion['options']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CyberSage Survey', style: TextStyle(fontSize: 22)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Question number indicator
                Container(
                 padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    'Question ${currentQuestionIndex + 1} of ${quizQuestions.length}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Question text with larger font
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    currentQuestion['question'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Instructions for elderly users
                const Text(
                  'Select one answer below:',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 20),
                
                // Options with larger buttons and enhanced contrast
                ...options.asMap().entries.map((entry) {
                  int index = entry.key;
                  String option = entry.value;
                  
                  Color backgroundColor = Theme.of(context).colorScheme.surface;
                  Color textColor = Theme.of(context).colorScheme.onSurface;
                  Color borderColor = Colors.grey.shade300;
                  
                  if (selectedAnswerIndex == index) {
                    backgroundColor = Theme.of(context).colorScheme.secondary;
                    textColor = Theme.of(context).colorScheme.onSecondary;
                    borderColor = Theme.of(context).colorScheme.secondary;
                  }
                  
                  // If answer is submitted, show correct/incorrect indication
                  if (isAnswerSubmitted) {
                    if (index == currentQuestion['correctAnswerIndex']) {
                      backgroundColor = Colors.green;
                      textColor = Colors.white;
                      borderColor = Colors.green;
                    } else if (selectedAnswerIndex == index) {
                      backgroundColor = Colors.red;
                      textColor = Colors.white;
                      borderColor = Colors.red;
                    }
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ElevatedButton(
                      onPressed: isAnswerSubmitted ? null : () {
                        setState(() {
                          selectedAnswer = option;
                          selectedAnswerIndex = index;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor,
                        foregroundColor: textColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: borderColor,
                          width: 2,
                        ),
                        disabledBackgroundColor: backgroundColor,
                        disabledForegroundColor: textColor,
                      ),
                      child: Text(
                        option,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                }),
                
                const SizedBox(height: 30),
                
                // Navigation and Submit buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Previous Question button
                    TextButton.icon(
                      onPressed: currentQuestionIndex > 0 ? previousQuestion : null,
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Previous', style: TextStyle(fontSize: 18)),
                    ),
                    
                    // Submit or Next button
                    if (!isAnswerSubmitted)
                      ElevatedButton(
                        onPressed: selectedAnswerIndex != null ? submitAnswer : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: const Text('Submit Answer', style: TextStyle(fontSize: 18)),
                      )
                    else
                      ElevatedButton(
                        onPressed: nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        child: Text(
                          currentQuestionIndex < quizQuestions.length - 1 
                            ? 'Next Question' 
                            : 'See Results',
                          style: const TextStyle(fontSize: 18)
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}