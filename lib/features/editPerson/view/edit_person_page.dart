import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/features/dashboard/bloc/dashboard_bloc.dart';
import '../../../database/database.dart';
import '../bloc/edit_person_bloc.dart';
import '../bloc/edit_person_event.dart';
import 'edit_person_view.dart';

class EditPersonPage extends StatelessWidget {
  const EditPersonPage({super.key, required this.databaseHandler, required this.personId});

  final DatabaseHandler databaseHandler;
  final int personId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditPersonBloc(databaseHandler, context.read<DashboardBloc>())
        ..add(LoadPersonDetailsEvent(personId: personId))
        ..add(LoadGroupsEvent()),
      child: EditPersonView(personId: personId),
    );
  }
}
