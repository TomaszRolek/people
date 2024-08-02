import 'package:equatable/equatable.dart';
import 'package:people/utils/state_status.dart';

import '../../../database/models/person.dart';

class CreateGroupState extends Equatable {
  final StateStatus status;
  final List<Person> persons;

  const CreateGroupState({
    this.status = StateStatus.initial,
    this.persons = const [],
  });

  CreateGroupState copyWith({StateStatus? status, List<Person>? persons}) {
    return CreateGroupState(
      status: status ?? this.status,
      persons: persons ?? this.persons,
    );
  }

  @override
  List<Object> get props => [status];
}
