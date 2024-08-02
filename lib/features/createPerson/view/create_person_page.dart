import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/features/dashboard/bloc/dashboard_bloc.dart';
import '../../../database/database.dart';
import '../bloc/create_person_bloc.dart';
import 'create_person_view.dart';

class CreatePersonPage extends StatelessWidget {
  const CreatePersonPage({super.key, required this.databaseHandler});

  final DatabaseHandler databaseHandler;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreatePersonBloc(databaseHandler, context.read<DashboardBloc>()),
      child: const CreatePersonView(),
    );
  }
}
