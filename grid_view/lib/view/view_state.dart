abstract class ViewState {
  int type = 1;
  List<int> data = [];
}

class ViewInitial extends ViewState {}

class CreateDataComplete extends ViewState {}

class ChangeTypeState extends ViewState {}
