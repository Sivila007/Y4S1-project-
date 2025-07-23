import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import '../../../data/datasources/mock_movies.dart';
import '../services/video_player_service.dart';
import '../widgets/video_controls.dart';
import '../widgets/video_seek_overlay.dart';
import '../widgets/video_progress_bar.dart';

class VideoPlayScreen extends StatefulWidget {
  final String movieId;
  const VideoPlayScreen({super.key, required this.movieId});

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerService _service;
  bool _showControls = true;
  bool _isFullscreen = false;
  Timer? _hideTimer;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeIn;
  bool _showSeekOverlay = false;
  bool _seekForward = true;
  int _seekSeconds = 10;

  @override
  void initState() {
    super.initState();
    _service = VideoPlayerService();
    mockMovies.firstWhere(
      (m) => m.id == widget.movieId,
      orElse: () => mockMovies.first,
    );
    _service
        .initialize(
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
        .then((_) {
      setState(() {});
      _service.play();
    });
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeIn = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();
    _startHideTimer();
  }

  @override
  void dispose() {
    _service.dispose();
    _fadeController.dispose();
    _hideTimer?.cancel();
    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) _startHideTimer();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  void _seekRelative(int seconds) {
    final newPosition =
        _service.controller.value.position + Duration(seconds: seconds);
    _service.seekTo(newPosition);
    setState(() {
      _showSeekOverlay = true;
      _seekForward = seconds > 0;
      _seekSeconds = seconds.abs();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _showSeekOverlay = false);
    });
  }

  void _toggleFullscreen() {
    setState(() {
      _isFullscreen = !_isFullscreen;
    });
    if (_isFullscreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final movie = mockMovies.firstWhere((m) => m.id == widget.movieId,
        orElse: () => mockMovies.first);
    final controller = _service.controller;
    final isReady = _service.isInitialized && controller.value.isInitialized;
    final isEnded = isReady &&
        controller.value.position >= controller.value.duration &&
        controller.value.duration != Duration.zero;
    final percent = isReady && controller.value.duration.inSeconds > 0
        ? controller.value.position.inSeconds /
            controller.value.duration.inSeconds
        : 0.0;
    return Scaffold(
      backgroundColor: Colors.black,
      body: FadeTransition(
        opacity: _fadeIn,
        child: Stack(
          children: [
            if (_service.hasError)
              Center(
                child: Text(_service.errorMessage ?? 'Failed to load video.',
                    style: const TextStyle(color: Colors.white, fontSize: 18)),
              )
            else ...[
              GestureDetector(
                onTap: _toggleControls,
                onDoubleTapDown: (details) {
                  final width = MediaQuery.of(context).size.width;
                  if (details.localPosition.dx < width / 2) {
                    _seekRelative(-10);
                  } else {
                    _seekRelative(10);
                  }
                },
                child: Center(
                  child: isReady
                      ? AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: Stack(
                            children: [
                              VideoPlayer(controller),
                              if (controller.value.isBuffering)
                                const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white)),
                              VideoSeekOverlay(
                                  show: _showSeekOverlay,
                                  forward: _seekForward,
                                  seconds: _seekSeconds),
                            ],
                          ),
                        )
                      : const CircularProgressIndicator(color: Colors.white),
                ),
              ),
              // Top bar with back and title
              if (_showControls)
                Positioned(
                  top: 40,
                  left: 16,
                  right: 16,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => context.pop(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              // Controls overlay
              if (_showControls && isReady)
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: VideoControls(
                    isPlaying: controller.value.isPlaying,
                    isEnded: isEnded,
                    isFullscreen: _isFullscreen,
                    position: controller.value.position,
                    duration: controller.value.duration,
                    playbackSpeed: _service.playbackSpeed,
                    onPlayPause: () {
                      setState(() {
                        controller.value.isPlaying
                            ? _service.pause()
                            : _service.play();
                      });
                      _startHideTimer();
                    },
                    onReplay: () {
                      _service.seekTo(Duration.zero);
                      _service.play();
                      _startHideTimer();
                    },
                    onSkipForward: () => _seekRelative(10),
                    onSkipBackward: () => _seekRelative(-10),
                    onFullscreen: _toggleFullscreen,
                    onSeek: (val) {
                      _service.seekTo(Duration(seconds: val.toInt()));
                      _startHideTimer();
                    },
                    onSpeed: (speed) {
                      setState(() {
                        _service.setSpeed(speed);
                      });
                      _startHideTimer();
                    },
                  ),
                ),
              // Mini progress bar (always visible)
              if (isReady) VideoProgressBar(percent: percent),
            ],
          ],
        ),
      ),
    );
  }
}
