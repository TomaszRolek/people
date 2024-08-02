import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/database/models/group.dart';
import 'package:people/utils/state_status.dart';
import '../../../database/database.dart';
import '../../dashboard/bloc/dashboard_bloc.dart';
import 'edit_group_event.dart';
import 'edit_group_state.dart';

class EditGroupBloc extends Bloc<EditGroupEvent, EditGroupState> {
  final DatabaseHandler _databaseHandler;
  final DashboardBloc _dashboardBloc;

  EditGroupBloc(this._databaseHandler, this._dashboardBloc) : super(const EditGroupState()) {
    on<SubmitEditedGroupEvent>(_onSubmitEditedGroupEvent);
    on<LoadGroupDetailsEvent>(_onLoadGroupDetailsEvent);
    on<LoadPersonsEvent>(_onLoadPersonsEvent);
    on<DeleteGroupEvent>(_onDeleteGroupEvent);
    on<TogglePersonSelectionEvent>(_onTogglePersonSelectionEvent);
  }

  Future<void> _onSubmitEditedGroupEvent(SubmitEditedGroupEvent event, Emitter<EditGroupState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final updatedGroup = Group(
        id: event.groupId,
        name: event.name,
        persons: event.persons,
      );
      await _databaseHandler.updateGroup(updatedGroup);
      _dashboardBloc.add(LoadDataEvent());
      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failure));
    }
  }

  Future<void> _onLoadGroupDetailsEvent(LoadGroupDetailsEvent event, Emitter<EditGroupState> emit) async {
    try {
      final group = await _databaseHandler.readGroup(event.groupId);
      final persons = await _databaseHandler.readAllPersons();
      final selectedPersons = group.persons.toSet();
      emit(state.copyWith(group: group, persons: persons, selectedPersons: selectedPersons));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failure));
    }
  }

  Future<void> _onLoadPersonsEvent(LoadPersonsEvent event, Emitter<EditGroupState> emit) async {
    try {
      final persons = await _databaseHandler.readAllPersons();
      emit(state.copyWith(persons: persons));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failure));
    }
  }

  Future<void> _onDeleteGroupEvent(DeleteGroupEvent event, Emitter<EditGroupState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      await _databaseHandler.deleteGroup(event.groupId);
      _dashboardBloc.add(LoadDataEvent());
      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failure));
    }
  }

  void _onTogglePersonSelectionEvent(TogglePersonSelectionEvent event, Emitter<EditGroupState> emit) {
    final updatedSelectedPersons = Set<int>.from(state.selectedPersons);
    if (updatedSelectedPersons.contains(event.personId)) {
      updatedSelectedPersons.remove(event.personId);
    } else {
      updatedSelectedPersons.add(event.personId);
    }
    emit(state.copyWith(selectedPersons: updatedSelectedPersons));
  }
}
