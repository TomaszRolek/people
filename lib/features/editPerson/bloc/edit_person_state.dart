import 'package:equatable/equatable.dart';
import 'package:people/utils/state_status.dart';
import '../../../database/models/group.dart';
import '../../../database/models/person.dart';

class EditPersonState extends Equatable {
  final StateStatus status;
  final Person? person;
  final List<Group> groups;
  final List<Group> selectedGroups;
  final String? error;

  const EditPersonState({
    this.status = StateStatus.initial,
    this.person,
    this.groups = const [],
    this.selectedGroups = const [],
    this.error,
  });

  EditPersonState copyWith({
    StateStatus? status,
    Person? person,
    List<Group>? groups,
    List<Group>? selectedGroups,
    String? error,
  }) {
    return EditPersonState(
      status: status ?? this.status,
      person: person ?? this.person,
      groups: groups ?? this.groups,
      selectedGroups: selectedGroups ?? this.selectedGroups,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, person, groups, selectedGroups, error];
}
