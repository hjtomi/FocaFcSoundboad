import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

// Tedd be a hangfileokat az assets mappába,
// majd írd be az alábbi listába és automatikusan megjelentik az appban
final List<String>files = [
  "Doma-Úristen.mp3",
  "Miksa-Mi a fasz.mp3"
];

class SoundboardPage extends StatefulWidget {
  const SoundboardPage({super.key});

  @override
  State<SoundboardPage> createState() => _SoundboardPageState();
}

class _SoundboardPageState extends State<SoundboardPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TitleCard(theme: theme),
            ),
            Soundboard(),
            SizedBox(height: 25)
          ],
        ),
      )
    );
  }
}

class TitleCard extends StatelessWidget {
  const TitleCard({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final fntStyle = theme.textTheme.headlineMedium!.copyWith(
      color: theme.colorScheme.onPrimary
    );

    return Card(
      elevation: 5,
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "FOCA FC SOUNDBOARD",
          style: fntStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}


class Soundboard extends StatelessWidget {
  const Soundboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black, // Middle part fully visible
              Colors.black,
              Colors.transparent,
            ],
            stops: [0.0, 0.05, 0.95, 1.0], // Adjust fade regions
          ).createShader(bounds);
        },
        blendMode: BlendMode.dstIn,
        child: GridView.count(
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 40,
          ),
          crossAxisCount: 2,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          children: [
            for (var file in files)
              SoundboardButton(file: file),
            for (var file in files)
              SoundboardButton(file: file),
            for (var file in files)
              SoundboardButton(file: file),
            for (var file in files)
              SoundboardButton(file: file),
            for (var file in files)
              SoundboardButton(file: file),
            for (var file in files)
              SoundboardButton(file: file),
          ]
        ),
      ),
    );
  }
}

class SoundboardButton extends StatelessWidget {
  const SoundboardButton({
    super.key,
    required this.file,
  });

  final String file;

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer();
    final btnStyle = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );

    return ElevatedButton(
      style: btnStyle,
      onPressed: () {
        audioPlayer.play(AssetSource(file));
      },
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: file.replaceAll("assets/", "").replaceAll(".mp3", "").split("-")[0],
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            TextSpan(text: "\n"),
            TextSpan(
              text: file.replaceAll("assets/", "").replaceAll(".mp3", "").split("-")[1],
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ]
        )
      ),
    );
  }
}