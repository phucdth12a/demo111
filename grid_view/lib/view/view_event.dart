abstract class ViewEvent {}

class ToggleTypeEvent extends ViewEvent {
  final int type;

  ToggleTypeEvent(this.type);
}

class InitDataEvent extends ViewEvent {}
