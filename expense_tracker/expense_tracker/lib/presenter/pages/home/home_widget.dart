import 'package:expense_tracker/core/router/app_router.dart';
import 'package:expense_tracker/core/router/route_names.dart';
import 'package:expense_tracker/data/model/ui_model/home_dashboard_ui_model.dart';
import 'package:expense_tracker/presenter/pages/home/bloc/home_bloc.dart';
import 'package:expense_tracker/presenter/pages/home/section/home_dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:kiwi/kiwi.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final HomeBloc homeBloc = KiwiContainer().resolve<HomeBloc>();
  HomeDashboardUiModel _uiModel = HomeDashboardUiModel.empty();

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onVisibilityGained: () {
        homeBloc.add(LoadHomeDataEvent());
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            'Expense Tracker',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          bloc: homeBloc,
          listenWhen: (previous, current) => current is HomeActionState,
          buildWhen: (previous, current) => current is! HomeActionState,
          listener: (context, state) {
            if (state is UiModelLoadedState) {
              setState(() {
                _uiModel = state.uiModel;
              });
            }
          },
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(
                  child: CircularProgressIndicator(color: Colors.white));
            } else {
              return HomeDashboardWidget(uiModel: _uiModel);
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AppRouter.navigate(RouteNames.createWallet);
          },
          backgroundColor: Colors.lightGreen,
          elevation: 6.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60.0),
          ),
          tooltip: "Create Wallet",
          heroTag: "create_wallet_fab",
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28.0,
          ),
        ),
      ),
    );
  }
}
