import 'package:flutter/material.dart';

class ChemistryHomePage extends StatelessWidget {
  final List<Map<String, String>> lectures = [
    {
      'title': 'Introduction to Atomic Structure',
      'description':
          'Learn about atoms, subatomic particles, and the history of atomic models.'
    },
    {
      'title': 'Chemical Bonding Basics',
      'description':
          'Understand ionic, covalent, and metallic bonding with examples.'
    },
    {
      'title': 'Periodic Table Trends',
      'description':
          'Explore periodicity in properties such as electronegativity and ionization energy.'
    },
    {
      'title': 'Acids, Bases, and pH',
      'description':
          'Study acid-base reactions and how to calculate pH levels in solutions.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chemistry Lectures'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search feature coming soon!')),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: lectures.length,
        itemBuilder: (context, index) {
          final lecture = lectures[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 4,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal.shade200,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                lecture['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(lecture['description']!),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LectureDetailPage(lecture: lecture),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add new lecture feature coming soon!')),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}

class LectureDetailPage extends StatelessWidget {
  final Map<String, String> lecture;

  const LectureDetailPage({required this.lecture, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lecture['title']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Detailed notes and study materials for:\n\n${lecture['title']}\n\n${lecture['description']}\n\n'
          'Example content:\n- Definitions and key formulas\n- Concept explanations\n- Practice problems\n- Real-world applications',
          style: const TextStyle(fontSize: 16, height: 1.5),
        ),
      ),
    );
  }
}
