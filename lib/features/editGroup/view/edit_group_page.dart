import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/features/editGroup/bloc/edit_group_event.dart';
import 'package:people/features/dashboard/bloc/dashboard_bloc.dart';
import '../../../database/database.dart';
import '../bloc/edit_group_bloc.dart';
import 'edit_group_view.dart';

class EditGroupPage extends StatelessWidget {
  const EditGroupPage({super.key, required this.databaseHandler, required this.groupId});

  final DatabaseHandler databaseHandler;
  final int groupId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditGroupBloc(databaseHandler, context.read<DashboardBloc>())
        ..add(LoadGroupDetailsEvent(groupId: groupId))
        ..add(LoadPersonsEvent()),
      child: EditGroupView(groupId: groupId),
    );
  }
}
