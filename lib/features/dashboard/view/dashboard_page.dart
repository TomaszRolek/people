import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/database.dart';
import '../bloc/dashboard_bloc.dart';
import 'dashboard_view.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required this.databaseHandler});

  final DatabaseHandler databaseHandler;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      key: key,
      value: context.read<DashboardBloc>(),
      child: const DashboardView(),
    );
  }
}
