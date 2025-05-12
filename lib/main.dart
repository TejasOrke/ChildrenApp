import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kids Learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: const Icon(Icons.school, size: 100, color: Colors.blue),
              ),
              const SizedBox(height: 20),
              const Text(
                "Kids Learning App",
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Kids Learning App"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Practice"),
              Tab(text: "Quiz"),
              Tab(text: "Leaderboard"),
              Tab(text: "Profile"),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.school, size: 60, color: Colors.white),
                    Text("Learning App", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.book),
                title: const Text("Practice"),
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const HomeScreen())),
              ),
              ListTile(
                leading: const Icon(Icons.quiz),
                title: const Text("Quiz"),
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const HomeScreen())),
              ),
              ListTile(
                leading: const Icon(Icons.leaderboard),
                title: const Text("Leaderboard"),
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const HomeScreen())),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const HomeScreen())),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PracticeScreen(),
            QuizScreen(),
            LeaderboardScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}

// Practice Screen
class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  _PracticeScreenState createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Numbers',
      'icon': Icons.looks_one,
      'color': Colors.blue,
      'items': [
        {'title': '1', 'subtitle': 'One'},
        {'title': '2', 'subtitle': 'Two'},
        {'title': '3', 'subtitle': 'Three'},
        {'title': '4', 'subtitle': 'Four'},
        {'title': '5', 'subtitle': 'Five'},
      ]
    },
    {
      'title': 'Alphabets',
      'icon': Icons.abc,
      'color': Colors.green,
      'items': [
        {'title': 'A', 'subtitle': 'Apple'},
        {'title': 'B', 'subtitle': 'Ball'},
        {'title': 'C', 'subtitle': 'Cat'},
        {'title': 'D', 'subtitle': 'Dog'},
        {'title': 'E', 'subtitle': 'Elephant'},
      ]
    },
    // Update the Colors category in _categories list
{
  'title': 'Colors',
  'icon': Icons.color_lens,
  'color': Colors.orange,
  'items': [
    {
      'title': 'Red',
      'subtitle': 'Like an Apple',
      'color': Colors.red,
      'example': '🍎'
    },
    {
      'title': 'Blue',
      'subtitle': 'Like the Sky',
      'color': Colors.blue,
      'example': '🌥️'
    },
    {
      'title': 'Green',
      'subtitle': 'Like Leaves',
      'color': Colors.green,
      'example': '🌿'
    },
    {
      'title': 'Yellow',
      'subtitle': 'Like the Sun',
      'color': Colors.yellow,
      'example': '☀️'
    },
    {
      'title': 'Purple',
      'subtitle': 'Like Grapes',
      'color': Colors.purple,
      'example': '🍇'
    },
  ]
},
    {
  'title': 'Shapes',
  'icon': Icons.category,
  'color': Colors.purple,
  'items': [
    {
      'title': 'Circle',
      'subtitle': 'Like a Ball',
      'shape': (BuildContext context, Color color) => Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    },
    {
      'title': 'Square',
      'subtitle': 'Like a Box',
      'shape': (BuildContext context, Color color) => Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    },
    {
      'title': 'Triangle',
      'subtitle': 'Like a Pizza Slice',
      'shape': (BuildContext context, Color color) => CustomPaint(
        size: const Size(50, 50),
        painter: TrianglePainter(color),
      ),
    },
    {
      'title': 'Rectangle',
      'subtitle': 'Like a Door',
      'shape': (BuildContext context, Color color) => Container(
        width: 70,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    },
    {
      'title': 'Star',
      'subtitle': 'Like in the Sky',
      'shape': (BuildContext context, Color color) => CustomPaint(
        size: const Size(50, 50),
        painter: StarPainter(color),
      ),
    },
  ]
},
];


  void _showLessonDetails(BuildContext context, Map<String, dynamic> category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category['title'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: category['items'].length,
                  itemBuilder: (context, index) {
                    final item = category['items'][index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: // Update the ListTile in _showLessonDetails method
ListTile(
  leading: CircleAvatar(
    backgroundColor: category['title'] == 'Colors' 
        ? item['color'] 
        : category['color'].withOpacity(0.2),
    child: category['title'] == 'Colors'
        ? Text(
            item['example'],
            style: const TextStyle(fontSize: 20),
          )
        : Text(
            item['title'],
            style: TextStyle(
              color: category['color'],
              fontWeight: FontWeight.bold,
            ),
          ),
  ),
  title: Text(
    item['title'],
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: category['title'] == 'Colors' ? item['color'] : Colors.black,
    ),
  ),
  subtitle: Text(
    item['subtitle'],
    style: const TextStyle(fontSize: 16),
  ),
  onTap: () {
    // Optional: Add color-specific animation or sound
  },
),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, color: Colors.white, size: 32),
              SizedBox(width: 8),
              Text(
                "Let's Learn!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return GestureDetector(
                onTap: () => _showLessonDetails(context, category),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        colors: [
                          category['color'],
                          category['color'].withOpacity(0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          category['icon'],
                          size: 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
// Quiz Screen
// Replace the existing QuizScreen and QuizScreenState with this improved version
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      "question": "What comes after number 3?",
      "options": ["2", "4", "5", "6"],
      "answer": "4",
      "image": Icons.looks_4,
    },
    {
      "question": "Which letter starts the word 'Apple'?",
      "options": ["B", "C", "A", "D"],
      "answer": "A",
      "image": Icons.apple,
    },
    {
      "question": "What color is a banana?",
      "options": ["Red", "Yellow", "Blue", "Green"],
      "answer": "Yellow",
      "image": Icons.color_lens,
    },
    {
      "question": "How many sides does a triangle have?",
      "options": ["2", "3", "4", "5"],
      "answer": "3",
      "image": Icons.change_history,
    },
    {
      "question": "Which animal says 'Meow'?",
      "options": ["Dog", "Cat", "Duck", "Cow"],
      "answer": "Cat",
      "image": Icons.pets,
    },
  ];

  int _currentIndex = 0;
  int _score = 0;
  bool _showResult = false;
  Color _selectedColor = Colors.blue;

  void _checkAnswer(String selectedOption) {
    bool isCorrect = selectedOption == _questions[_currentIndex]["answer"];
    
    setState(() {
      if (isCorrect) {
        _score++;
        _selectedColor = Colors.green;
      } else {
        _selectedColor = Colors.red;
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (_currentIndex < _questions.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedColor = Colors.blue;
        });
      } else {
        setState(() {
          _showResult = true;
        });
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _showResult = false;
      _selectedColor = Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showResult) {
      return _buildResultScreen();
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentIndex + 1) / _questions.length,
            backgroundColor: Colors.blue.shade100,
            color: Colors.blue,
          ),
          const SizedBox(height: 20),
          Text(
            "Question ${_currentIndex + 1}/${_questions.length}",
            style: const TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Icon(
                    _questions[_currentIndex]["image"],
                    size: 80,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _questions[_currentIndex]["question"],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: _questions[_currentIndex]["options"].map<Widget>((option) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: () => _checkAnswer(option),
                    child: Text(
                      option,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Text(
            "Score: $_score",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildResultScreen() {
    String message = _score > 3 ? "Great Job! 🎉" : "Keep Practicing! 💪";
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.emoji_events,
            size: 100,
            color: Colors.amber,
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "You scored: $_score out of ${_questions.length}",
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _restartQuiz,
            icon: const Icon(Icons.replay),
            label: const Text(
              "Try Again",
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// Leaderboard Screen
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  final List<Map<String, dynamic>> _leaderboardData = const [
    {
      "name": "Alice",
      "score": 95,
      "level": "Expert",
      "avatar": "👧",
    },
    {
      "name": "Bob",
      "score": 88,
      "level": "Advanced",
      "avatar": "👦",
    },
    {
      "name": "Charlie",
      "score": 82,
      "level": "Intermediate",
      "avatar": "👦",
    },
    {
      "name": "Diana",
      "score": 78,
      "level": "Beginner",
      "avatar": "👧",
    },
    {
      "name": "Eric",
      "score": 75,
      "level": "Beginner",
      "avatar": "👦",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade300, Colors.blue.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.emoji_events, color: Colors.amber, size: 32),
              SizedBox(width: 8),
              Text(
                "Top Learners",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _leaderboardData.length,
            itemBuilder: (context, index) {
              final data = _leaderboardData[index];
              final isTop3 = index < 3;
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: isTop3 ? 8 : 2,
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isTop3 
                          ? [Colors.amber, Colors.grey.shade300, Colors.brown][index]
                          : Colors.blue.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        data["avatar"],
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(
                        data["name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          data["level"],
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: LinearProgressIndicator(
                    value: data["score"] / 100,
                    backgroundColor: Colors.grey.shade200,
                    color: isTop3 
                        ? [Colors.amber, Colors.grey.shade400, Colors.brown.shade300][index]
                        : Colors.blue,
                  ),
                  trailing: Text(
                    "${data["score"]}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isTop3 
                          ? [Colors.amber.shade800, Colors.grey.shade700, Colors.brown][index]
                          : Colors.blue,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}



class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StarPainter extends CustomPainter {
  final Color color;

  StarPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width * 0.62, size.height * 0.38);
    path.lineTo(size.width, size.height * 0.38);
    path.lineTo(size.width * 0.68, size.height * 0.62);
    path.lineTo(size.width * 0.82, size.height);
    path.lineTo(size.width / 2, size.height * 0.76);
    path.lineTo(size.width * 0.18, size.height);
    path.lineTo(size.width * 0.32, size.height * 0.62);
    path.lineTo(0, size.height * 0.38);
    path.lineTo(size.width * 0.38, size.height * 0.38);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  String _name = "Guest";
  int _totalScore = 0;
  int _quizzesTaken = 0;
  String _currentLevel = "Beginner";
  List<String> _achievements = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString("username") ?? "Guest";
      _totalScore = prefs.getInt("totalScore") ?? 0;
      _quizzesTaken = prefs.getInt("quizzesTaken") ?? 0;
      _currentLevel = prefs.getString("currentLevel") ?? "Beginner";
      _achievements = prefs.getStringList("achievements") ?? [];
    });
  }

  Future<void> _saveName() async {
    if (_nameController.text.trim().isEmpty) return;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", _nameController.text);
    
    setState(() {
      _name = _nameController.text;
      _nameController.clear();
    });
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Header
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        _name[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _currentLevel,
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Stats Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Statistics",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildStatItem(Icons.star, "Total Score", "$_totalScore points"),
                    _buildStatItem(Icons.quiz, "Quizzes Taken", "$_quizzesTaken"),
                    _buildStatItem(
                      Icons.trending_up,
                      "Average Score",
                      "${_quizzesTaken > 0 ? (_totalScore / _quizzesTaken).round() : 0}%",
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Edit Profile Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(``
                        labelText: "Change Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _saveName,
                      icon: const Icon(Icons.save),
                      label: const Text("Save Changes"),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildStatItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}