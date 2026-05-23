import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MusicPlayerApp());
}

class MusicPlayerApp extends StatelessWidget {
  const MusicPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: const MusicHomePage(),
    );
  }
}

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  final AudioPlayer _player = AudioPlayer();
  int? playingIndex;

  final List<Map<String, String>> songs = [
    {'title': 'Calm Vibes', 'artist': 'Artist 1', 'file': 'song1.mp3', 'image': 'song1.jpg'},
    {'title': 'Dream Beats', 'artist': 'Artist 2', 'file': 'song2.mp3', 'image': 'song2.jpg'},
    {'title': 'Morning Tune', 'artist': 'Artist 3', 'file': 'song3.mp3', 'image': 'song3.jpg'},
    {'title': 'Evening Flow', 'artist': 'Artist 4', 'file': 'song4.mp3', 'image': 'song4.jpg'},
    {'title': 'Night Chill', 'artist': 'Artist 5', 'file': 'song5.mp3', 'image': 'song5.jpg'},
  ];

  void playPause(int index) async {
    if (playingIndex == index) {
      await _player.pause();
      setState(() => playingIndex = null);
    } else {
      await _player.play(AssetSource('audio/${songs[index]['file']}'));
      setState(() => playingIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('🎵 My Music Player'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset('assets/images/${songs[index]['image']}', width: 50, height: 50, fit: BoxFit.cover),
              ),
              title: Text(songs[index]['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(songs[index]['artist']!),
              trailing: IconButton(
                icon: Icon(
                  playingIndex == index ? Icons.pause_circle : Icons.play_circle,
                  color: Colors.blueAccent,
                  size: 35,
                ),
                onPressed: () => playPause(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
