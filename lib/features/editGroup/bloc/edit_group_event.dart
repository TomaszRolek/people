import 'package:equatable/equatable.dart';

abstract class EditGroupEvent extends Equatable {
  const EditGroupEvent();

  @override
  List<Object> get props => [];
}

class SubmitEditedGroupEvent extends EditGroupEvent {
  final int groupId;
  final String name;
  final List<int> persons;

  const SubmitEditedGroupEvent({
    required this.groupId,
    required this.name,
    required this.persons,
  });

  @override
  List<Object> get props => [groupId, name, persons];
}

class LoadGroupDetailsEvent extends EditGroupEvent {
  final int groupId;

  const LoadGroupDetailsEvent({required this.groupId});

  @override
  List<Object> get props => [groupId];
}

class LoadPersonsEvent extends EditGroupEvent {}

class DeleteGroupEvent extends EditGroupEvent {
  final int groupId;

  const DeleteGroupEvent({required this.groupId});

  @override
  List<Object> get props => [groupId];
}

class TogglePersonSelectionEvent extends EditGroupEvent {
  final int personId;

  const TogglePersonSelectionEvent({required this.personId});

  @override
  List<Object> get props => [personId];
}
