import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/database/models/group.dart';
import 'package:people/utils/state_status.dart';
import '../../../database/database.dart';
import '../../dashboard/bloc/dashboard_bloc.dart';
import 'create_group_event.dart';
import 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  final DatabaseHandler _databaseHandler;
  final DashboardBloc _dashboardBloc;

  CreateGroupBloc(this._databaseHandler, this._dashboardBloc) : super(const CreateGroupState()) {
    on<SubmitGroupEvent>(_onSubmitGroupEvent);
    on<ReadAllPersonsEvent>((event, emit) async {
      await _readAllPersons(emit);
    });
  }

  Future<void> _onSubmitGroupEvent(SubmitGroupEvent event, Emitter<CreateGroupState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final group = Group(name: event.name, persons: event.persons);
      await _databaseHandler.createGroup(group);
      _dashboardBloc.add(LoadDataEvent());
      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failure));
    }
  }

  Future<void> _readAllPersons(Emitter<CreateGroupState> emit) async {
    try {
      final persons = await _databaseHandler.readAllPersons();
      emit(state.copyWith(persons: persons));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failure));
    }
  }
}
