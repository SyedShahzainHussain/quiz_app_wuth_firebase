import 'intro.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LinearGradientWidget(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/quiz-logo.png',
                width: MediaQuery.sizeOf(context).width * 0.5,
                color: const Color.fromARGB(150, 255, 255, 255),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
              Text(
                'Learn Flutter the fun way!',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 237, 223, 252),
                  fontSize: 24,
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const SubjectScreen()),
                    (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.arrow_right_alt),
                label: const Text('Start Quiz'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
