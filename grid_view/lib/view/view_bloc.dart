import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/view/view_event.dart';
import 'package:grid_view/view/view_state.dart';

class ViewBloc extends Bloc<ViewEvent, ViewState> {
  ViewBloc() : super(ViewInitial()) {
    print("ViewInitial");

    on<ViewEvent>(
      (event, emit) async {
        if (event is InitDataEvent) {
          state.data = [1, 2, 3];
          state.type = 1;
          emit(CreateDataComplete());
          // emit(ChangeTypeState());
        } else if (event is ToggleTypeEvent) {
          state.type = 2;
          state.data = [1, 2, 3];
          emit(ChangeTypeState());
        }
      },
    );

    // on<ViewState>((event, emit) => null);
  }
}
