import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grid_view/view/view_bloc.dart';
import 'package:grid_view/view/view_event.dart';
import 'package:grid_view/view/view_state.dart';

class ViewScreen extends StatelessWidget {
  const ViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewBloc()..add(InitDataEvent()),
      child: const DemoWidget(),
    );
  }
}

class DemoWidget extends StatelessWidget {
  const DemoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ViewBloc>().add(ToggleTypeEvent(1));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: BlocBuilder<ViewBloc, ViewState>(
          buildWhen: (previous, current) {
            return current is CreateDataComplete || current is ChangeTypeState;
          },
          builder: (context, state) {
            print("state == $state");
            // if (state is ViewInitial) {
            //   print("1321312");
            //   context.read<ViewBloc>().add(InitDataEvent());
            // }
            // final length = context.read<CreateDataComplete>().data?.length ?? 0;
            final length = state.data.length;
            final type = state.type;
            print("length == $length === $type");
            return ListView.builder(
              itemCount: length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    height: 200,
                    color: Colors.red,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://picsum.photos/$width/$height?random=$index',
      width: width.toDouble(),
      height: height.toDouble(),
      fit: BoxFit.cover,
    );
  }
}
