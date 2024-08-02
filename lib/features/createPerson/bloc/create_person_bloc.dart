import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:people/utils/state_status.dart';
import '../../../database/database.dart';
import '../../../database/models/person.dart';
import '../../dashboard/bloc/dashboard_bloc.dart';
import 'create_person_event.dart';
import 'create_person_state.dart';

class CreatePersonBloc extends Bloc<CreatePersonEvent, CreatePersonState> {
  final DatabaseHandler _databaseHandler;
  final DashboardBloc _dashboardBloc;

  CreatePersonBloc(this._databaseHandler, this._dashboardBloc) : super(const CreatePersonState()) {
    on<SubmitPersonEvent>(_onSubmitPersonEvent);
  }

  Future<void> _onSubmitPersonEvent(SubmitPersonEvent event, Emitter<CreatePersonState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final person = Person(
        firstName: event.firstName,
        lastName: event.lastName,
        birthDate: event.dateOfBirth,
        address: event.address,
        userGroups: [],
      );
      await _databaseHandler.createPerson(person);
      _dashboardBloc.add(LoadDataEvent());
      emit(state.copyWith(status: StateStatus.success));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.failure));
    }
  }
}
