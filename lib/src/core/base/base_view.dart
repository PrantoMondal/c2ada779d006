import 'package:device_vitals/src/core/config/build_config.dart';
import 'package:device_vitals/src/core/constants/app_colors.dart';
import 'package:device_vitals/src/core/utils/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseView<T extends BlocBase<S>, S> extends StatelessWidget {
  BaseView({super.key});

  final logger = BuildConfig.instance.envConfig.logger;

  Widget body(BuildContext context);

  PreferredSizeWidget? appBar(BuildContext context) => null;

  Widget? floatingActionButton() => null;

  Widget? bottomNavigationBar() => null;

  Widget? drawer() => null;

  Color pageBackgroundColor() => AppColors.surfaceColor;

  Color statusBarColor() => AppColors.transparentColor;

  bool resizeToAvoidBottomInset() => true;

  FloatingActionButtonLocation? floatingActionButtonLocation() => null;

  bool isLoading(S state) => false;

  String errorMessage(S state) => "";

  void onError(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: AppColors.errorColor,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocBuilder<T, S>(
        builder: (context, state) {
          return Stack(
            children: [
              annotatedRegion(context, state),
              if (isLoading(state)) _showLoading(),
              if (errorMessage(state).isNotEmpty)
                _showErrorSnackBar(context, errorMessage(state)),
            ],
          );
        },
      ),
    );
  }

  Widget annotatedRegion(BuildContext context, S state) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor(),
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Material(color: Colors.transparent, child: pageScaffold(context, state)),
    );
  }

  Widget pageScaffold(BuildContext context, S state) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      backgroundColor: pageBackgroundColor(),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
      appBar: appBar(context),
      body: SafeArea(child: body(context)),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: floatingActionButtonLocation(),
      bottomNavigationBar: bottomNavigationBar(),
      drawer: drawer(),
    );
  }

  Widget _showLoading() {
    return const Loading();
  }

  Widget _showErrorSnackBar(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorColor,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    return Container();
  }
}
