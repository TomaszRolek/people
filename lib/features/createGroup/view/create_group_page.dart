import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/features/createGroup/bloc/create_group_event.dart';
import 'package:people/features/dashboard/bloc/dashboard_bloc.dart';
import '../../../database/database.dart';
import '../bloc/create_group_bloc.dart';
import 'create_group_view.dart';

class CreateGroupPage extends StatelessWidget {
  const CreateGroupPage({super.key, required this.databaseHandler});

  final DatabaseHandler databaseHandler;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateGroupBloc(databaseHandler, context.read<DashboardBloc>())..add(ReadAllPersonsEvent()),
      child: const CreateGroupView(),
    );
  }
}
