import 'package:equatable/equatable.dart';
import 'package:people/utils/state_status.dart';
import '../../../database/models/group.dart';
import '../../../database/models/person.dart';

class EditGroupState extends Equatable {
  final StateStatus status;
  final Group? group;
  final List<Person> persons;
  final Set<int> selectedPersons;

  const EditGroupState({
    this.status = StateStatus.initial,
    this.group,
    this.persons = const [],
    this.selectedPersons = const {},
  });

  EditGroupState copyWith({
    StateStatus? status,
    Group? group,
    List<Person>? persons,
    Set<int>? selectedPersons,
  }) {
    return EditGroupState(
      status: status ?? this.status,
      group: group ?? this.group,
      persons: persons ?? this.persons,
      selectedPersons: selectedPersons ?? this.selectedPersons,
    );
  }

  @override
  List<Object> get props => [status, group ?? '', persons, selectedPersons];
}
