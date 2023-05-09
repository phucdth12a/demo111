import 'package:audio_service/audio_service.dart';
import 'package:black_hole/model/music_model.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MediaState {
  final MusicModel? item;
  final Duration position;

  MediaState(this.item, this.position);
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}

class QueueState {
  static const QueueState empty =
      QueueState([], 0, [], AudioServiceRepeatMode.none);

  final List<MediaItem> queue;
  final int? queueIndex;
  final List<int>? shuffleIndices;
  final AudioServiceRepeatMode repeatMode;

  const QueueState(
      this.queue, this.queueIndex, this.shuffleIndices, this.repeatMode);

  bool get hasPrevious =>
      repeatMode != AudioServiceRepeatMode.none || (queueIndex ?? 0) > 0;
  bool get hasNext =>
      repeatMode != AudioServiceRepeatMode.none ||
      (queueIndex ?? 0) + 1 < queue.length;

  List<int> get indices =>
      shuffleIndices ?? List.generate(queue.length, (index) => index);
}

class ControlButtons extends StatelessWidget {
  const ControlButtons({
    super.key,
    required this.audioHandler,
    required this.shuffe,
    required this.miniplayer,
    required this.buttons,
    this.dominantColor,
  });

  final AudioPlayerHandler audioHandler;
  final bool shuffe;
  final bool miniplayer;
  final List buttons;
  final Color? dominantColor;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

abstract class AudioPlayerHandler implements AudioHandler {
  Stream<QueueState> get queueState;
  Future<void> moveQueueItem(int currentIndex, int newIndex);
  ValueStream<double> get volume;
  Future<void> setVolume(double volume);
  ValueStream<double> get speed;
}
