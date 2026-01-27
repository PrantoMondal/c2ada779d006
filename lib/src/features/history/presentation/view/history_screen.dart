import 'package:device_vitals/src/core/base/base_view.dart';
import 'package:device_vitals/src/features/history/presentation/bloc/history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends BaseView<HistoryBloc, HistoryState> {
  HistoryScreen({super.key});

  @override
  bool isLoading(HistoryState state) => state.isLoading;

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: state.items.length,
          itemBuilder: (_, index) {
            final item = state.items[index];
            return ListTile(
              title: Text("Battery: ${item.battery}%"),
              subtitle: Text(
                "Temp: ${item.temperature}°C • ${item.timestamp}",
              ),
            );
          },
        );
      },
    );

  }
}
