part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.people = const [],
    this.groups = const [],
    this.status = StateStatus.initial,
    this.error,
  });

  final List<Person> people;
  final List<Group> groups;
  final StateStatus status;
  final String? error;

  DashboardState copyWith({
    List<Person>? people,
    List<Group>? groups,
    StateStatus? status,
    String? error,
  }) {
    return DashboardState(
      people: people ?? this.people,
      groups: groups ?? this.groups,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, people, groups, error];
}
