import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/database/database.dart';
import 'package:people/utils/state_status.dart';

import '../../../database/models/group.dart';
import '../../dashboard/bloc/dashboard_bloc.dart';
import 'edit_person_event.dart';
import 'edit_person_state.dart';

class EditPersonBloc extends Bloc<EditPersonEvent, EditPersonState> {
  final DatabaseHandler _databaseHandler;
  final DashboardBloc _dashboardBloc;

  EditPersonBloc(this._databaseHandler, this._dashboardBloc) : super(const EditPersonState()) {
    on<LoadPersonDetailsEvent>(_onLoadPersonDetailsEvent);
    on<UpdatePersonEvent>(_onUpdatePersonEvent);
    on<LoadGroupsEvent>(_onLoadGroupsEvent);
    on<DeletePersonEvent>(_onDeletePersonEvent);
    on<ToggleGroupSelectionEvent>(_onToggleGroupSelectionEvent);
  }

  Future<void> _onLoadPersonDetailsEvent(
    LoadPersonDetailsEvent event,
    Emitter<EditPersonState> emit,
  ) async {
    try {
      final person = await _databaseHandler.readPerson(event.personId);
      final groups = await _databaseHandler.readAllGroups();
      emit(state.copyWith(
        person: person,
        groups: groups,
        selectedGroups: groups.where((group) => person.userGroups.contains(group.id)).toList(),
      ));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onUpdatePersonEvent(
    UpdatePersonEvent event,
    Emitter<EditPersonState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final updatedPerson = state.person!.copy(
        firstName: event.firstName,
        lastName: event.lastName,
        birthDate: event.birthDate,
        address: event.address,
        userGroups: state.selectedGroups.map((group) => group.id!).toList(),
      );

      await _databaseHandler.updatePerson(updatedPerson);
      _dashboardBloc.add(LoadDataEvent()); // Reload dashboard data if necessary
      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onLoadGroupsEvent(
    LoadGroupsEvent event,
    Emitter<EditPersonState> emit,
  ) async {
    try {
      final groups = await _databaseHandler.readAllGroups();
      emit(state.copyWith(groups: groups));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onDeletePersonEvent(DeletePersonEvent event, Emitter<EditPersonState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      await _databaseHandler.deletePerson(event.personId);
      _dashboardBloc.add(LoadDataEvent());
      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failure));
    }
  }

  void _onToggleGroupSelectionEvent(
    ToggleGroupSelectionEvent event,
    Emitter<EditPersonState> emit,
  ) {
    final updatedGroups = List<Group>.from(state.selectedGroups);
    if (updatedGroups.contains(event.group)) {
      updatedGroups.remove(event.group);
    } else {
      updatedGroups.add(event.group);
    }
    emit(state.copyWith(selectedGroups: updatedGroups));
  }
}
