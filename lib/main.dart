import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app_with_firebase/admin/view_model/upload_subject_view_model.dart';
import 'package:quiz_app_with_firebase/config/colors.dart';
import 'package:quiz_app_with_firebase/firebase_options.dart';
import 'package:quiz_app_with_firebase/view/intro/intro_screen.dart';
import 'package:quiz_app_with_firebase/view/levels/level.dart';

import 'package:quiz_app_with_firebase/view_model/question_view_model.dart';
import 'package:quiz_app_with_firebase/view_model/subject_view_model.dart';
import 'package:quiz_app_with_firebase/view_model/unlocked_level_view_model.dart';

import 'admin/view_model/upload_quiz_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UnlockedLevelsModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => QuestionViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UploadSubjectViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UploadQuizViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SubjectViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quiz App Firebase',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.purple,
          ),
          textTheme: GoogleFonts.latoTextTheme(),
          useMaterial3: true,
        ),
        home: const IntroScreen(),
      ),
    );
  }
}
