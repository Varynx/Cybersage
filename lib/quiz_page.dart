import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// List of cybersecurity quiz questions for seniors
final List<Map<String, dynamic>> quizQuestions = [
  {
    'question': 'A pop-up window appears on your device while browsing the internet, claiming that your device is infected with a virus,' 
    ' and to call the number on your screen to help remove the virus. Should you:',
    'options': [
      'Call the number and follow their directions to help you remove the virus.', 
      'Ignore and close the message. This is how scam callers find victims.', 
      'A computer virus that damages your files', 
      'A method of fixing computer problems remotely'
    ],
    'correctAnswerIndex': 1,
  },
  {
    'question': '15.	What should you do if you suspect that you may have given sensitive information to a potential scammer?',
    'options': [
      'Ignore it and assume there will be no consquences.', 
      'Contact the proper authorities based on the information you have given.', 
      'Alert the scammer that you are aware of the situation.', 
      'Give false information to the scammer to trick them.'
    ],
    'correctAnswerIndex': 1,
  },
  {
    'question': 'What should you do if someone calls claiming to be from Microsoft claiming there\'s a problem with your computer?',
    'options': [
      'Give them remote access to your computer', 
      'Provide your credit card to pay for their support', 
      'Hang up immediately - this is a common scam', 
      'Tell them your computer\'s password'
    ],
    'correctAnswerIndex': 2,
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
    'question': 'The following email is sent to you claiming that an unknown user has accessed your Facebook account. How should you respond? ',
    'options': [
      'Forward the email to your friends and family to warn them of possible messages from an impostor using your account.', 
      'Click Report the User to report on this suspicious activity', 
      'Ignore the email, and verify the activity by logging into Facebook using the official website or app.', 
      'Reply to the email for further support from the support team.'
    ],
    'correctAnswerIndex': 2,
    'image': 'assets/cybersage_no_person.png',//replace with actual image found in doc
  },
  {
    'question': 'The following email has been sent to your inbox claiming that an invoice of'
    ' \$320 has been charged on your PayPal account. How could you verify the validity of the email?',
    'options': [
      'Click on the View and Pay button within the email to quickly get more details about the charge.', 
      'Manually head to PayPal\'s official website or app to check if the invoice is legitimate.', 
      'Reply to the email asking for more information about the invoice.', 
      'Call the number given in the notes for more information.'
    ],
    'correctAnswerIndex': 1,
    //add image
  },
  {
    'question': '10.	What is a key sign that an email might be a phishing attempt?',
    'options': [
      'The email is vague and creates a sense of urgency.', 
      'The email contains a phone number for customer service', 
      'The email is lengthy and well written with a proper email address.', 
      'The email contains an attachment.'
    ],
    'correctAnswerIndex': 0,
  },
  {
    'question': 'Look at the following email. What are some signs that this is a phishing attempt?',
    'options': [
      'There is little explanation about the attachment.', 
      'The sender email address is a random combination of letters', 
      'A sense of urgency is made with the claim of your service being suspended.', 
      'All of the above.'
    ],
    'correctAnswerIndex': 3,
    //add image
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
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text('Return to Home', style: TextStyle(fontSize: 18)),
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
              child: const Text('Try Again.', style: TextStyle(fontSize: 18)),
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
               // Question text
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
              child: Column(
              children: [
              Text(
              currentQuestion['question'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            if (currentQuestion.containsKey('image') && currentQuestion['image'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Image.asset(
                  currentQuestion['image'],
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
                /*
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
                */
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