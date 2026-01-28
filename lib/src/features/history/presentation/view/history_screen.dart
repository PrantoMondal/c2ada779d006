import 'package:device_vitals/src/core/base/base_view.dart';
import 'package:device_vitals/src/core/constants/app_colors.dart';
import 'package:device_vitals/src/core/utils/extensions.dart';
import 'package:device_vitals/src/features/history/presentation/bloc/history_bloc.dart';
import 'package:device_vitals/src/features/history/presentation/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryScreen extends BaseView<HistoryBloc, HistoryState> {
  HistoryScreen({super.key});

  @override
  bool isLoading(HistoryState state) => state.isLoading;

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text('History', style: TextStyle(color: AppColors.textPrimary)),
      backgroundColor: AppColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.items.length,
          itemBuilder: (_, index) {
            final item = state.items[index];
            return HistoryCard(
              battery: item.battery,
              memory: item.usedMemory.toString(),
              temperature: item.temperature,
              time: item.timestamp.formattedTime,
            );
          },
        );
      },
    );
  }
}
