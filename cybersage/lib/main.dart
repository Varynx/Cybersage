import 'package:flutter/material.dart';
import 'login_page.dart';
import 'quiz_page.dart'; 
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
     
    // Initialize Firebase
    options: DefaultFirebaseOptions.currentPlatform,);
    
    //Runs app
    runApp(const MyApp());

}
class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  //  Root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme(
          primary: const Color(0xFF006B53),      // FGCU Green
          onPrimary: Colors.white,
          secondary: const Color(0xFF00287A),    // FGCU Blue
          onSecondary: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black87,
          error: Colors.red.shade700,       
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        
        // ENHANCED TEXT THEME FOR ELDERLY READABILITY
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.black87),
          displayMedium: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: Colors.black87),
          displaySmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
          headlineMedium: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black87),
          bodyLarge: TextStyle(fontSize: 20.0, color: Colors.black87),
          bodyMedium: TextStyle(fontSize: 18.0, color: Colors.black87),
        ),
        
        // INCREASED BUTTON SIZE FOR BETTER ACCESSIBILITY
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(fontSize: 18),
            minimumSize: const Size(100, 50),
          ),
        ),
        
        // INCREASED INPUT FIELD SIZE FOR BETTER ACCESSIBILITY
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: 2.0),
          ),
          labelStyle: const TextStyle(fontSize: 18.0),
          hintStyle: const TextStyle(fontSize: 18.0),
          errorStyle: const TextStyle(fontSize: 16.0, color: Colors.red),
        ),
      ),
      
      // REPLACED 'home' PROPERTY WITH ROUTES
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/quiz': (context) => const QuizPage(),
      },
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     // Initialize Firebase
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue.shade200),
//       ),

//       home: const MyHomePage(title: 'Flutter Demo Home Page Modified'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   // Add Data to Firestore
//   void _addDataToFirestore() async {
//     FirebaseFirestore firestore =
//         FirebaseFirestore.instance; // Get Firestore instance

//     // Add data to a collection
//     await firestore.collection('Usernames').add({
//       'count': _counter, // The counter value you want to save
//       'timestamp': FieldValue.serverTimestamp(), // Timestamp of the save
//     });
//   }

//   // Retrieve Data from Firestore
//   Future<void> _getDataFromFirestore() async {
//     FirebaseFirestore firestore =
//         FirebaseFirestore.instance; // Get Firestore instance

//     // Retrieve data from the collection
//     QuerySnapshot querySnapshot = await firestore.collection('Usernames').get();

//     // Print each document's data
//     querySnapshot.docs.forEach((doc) {
//       print(doc.data()); // Output the document data to the console
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,

//           children: <Widget>[
//             const Text('You have pushed the button this many times:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),

//             ElevatedButton(
//               onPressed: _addDataToFirestore,
//               child: const Text('Save Data to Firestore'),
//             ),

//             ElevatedButton(
//               onPressed: _getDataFromFirestore,
//               child: const Text('Get Data from Firestore'),
//             ),
//           ],
//         ),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
