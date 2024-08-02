import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/database/models/person.dart';

import '../../../database/database.dart';
import '../../../database/models/group.dart';
import '../../../utils/state_status.dart';


part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(this._databaseHandler) : super(const DashboardState()) {
    on<LoadDataEvent>((event, emit) async {
      await _loadData(emit);
    });
  }
  final DatabaseHandler _databaseHandler;


  Future<void> _loadData(Emitter<DashboardState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final people = await _databaseHandler.readAllPersons();
      final groups = await _databaseHandler.readAllGroups();
      emit(state.copyWith(people: people, groups: groups, status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith( error: e.toString()));
    }
  }
}
