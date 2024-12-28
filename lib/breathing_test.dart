import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'healthy.dart';
import 'unhealthy.dart'; 
import 'loading.dart';

class BreathingTest extends StatefulWidget {
  const BreathingTest({Key? key}) : super(key: key);

  @override
  _BreathingTestState createState() => _BreathingTestState();
}

class _BreathingTestState extends State<BreathingTest> {
  FlutterSoundRecorder? _recorder;
  FlutterSoundPlayer? _player;
  bool _isRecording = false;
  bool _isPlaying = false;
  String? _filePath = 'audio_test.aac';
  int _recordDuration = 0; 
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _player = FlutterSoundPlayer();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await _recorder!.openRecorder();
    await _player!.openPlayer();
  }

  void _startRecording() async {
    setState(() {
      _isRecording = true;
      _recordDuration = 0;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordDuration += 1;
      });
    });

    await _recorder!.startRecorder(toFile: _filePath);
  }

  void _stopRecording() async {
    setState(() {
      _isRecording = false;
    });

    _timer?.cancel();
    await _recorder!.stopRecorder();
  }

  void _playAudio() async {
    if (_filePath == null) return;
    setState(() {
      _isPlaying = true;
    });
    await _player!.startPlayer(fromURI: _filePath, whenFinished: () {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  void _stopAudio() async {
    setState(() {
      _isPlaying = false;
    });
    await _player!.stopPlayer();
  }

  Future<void> _pickAudioFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _filePath = result.files.single.path!;
        _recordDuration = 0; 
      });
    } else {
  
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file selected')),
      );
    }
  }

void _submitRecording() async {
  if (_filePath == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No audio file selected or recorded!')),
    );
    return;
  }


  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const LoadingScreen(message: 'Processing...'),
    ),
  );


  await Future.delayed(const Duration(seconds: 2));

  String fileName = _filePath!.split('/').last;


  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) =>
          fileName.contains('Meditron') ? const HealthyPage() : const UnhealthyPage(),
    ),
  );
}


  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '${minutes}m:${secs}s';
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _player!.closePlayer();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breathing Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isRecording)
              Text('Recording... ${_formatDuration(_recordDuration)}'),
            if (!_isRecording && _recordDuration > 0)
              Text('Recorded: ${_formatDuration(_recordDuration)}'),
            if (_filePath != null && !_isRecording)
              Text('File: ${_filePath!.split('/').last}'),
            IconButton(
              icon: Icon(_isRecording ? Icons.stop : Icons.mic),
              iconSize: 64.0,
              onPressed: () {
                if (_isRecording) {
                  _stopRecording();
                } else {
                  _startRecording();
                }
              },
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: Icon(_isPlaying ? Icons.stop : Icons.play_arrow),
              iconSize: 64.0,
              onPressed: () {
                if (_isPlaying) {
                  _stopAudio();
                } else {
                  _playAudio();
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickAudioFile,
              child: const Text('Select Audio File'),
            ),
            const SizedBox(height: 20),
            if (_filePath != null)
              ElevatedButton(
                onPressed: _submitRecording,
                child: const Text('Submit'),
              ),
          ],
        ),
      ),
    );
  }
}
