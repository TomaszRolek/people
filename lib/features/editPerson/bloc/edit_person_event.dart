import 'package:equatable/equatable.dart';
import '../../../database/models/group.dart';

abstract class EditPersonEvent extends Equatable {
  const EditPersonEvent();

  @override
  List<Object?> get props => [];
}

class LoadPersonDetailsEvent extends EditPersonEvent {
  final int personId;

  const LoadPersonDetailsEvent({required this.personId});

  @override
  List<Object?> get props => [personId];
}

class UpdatePersonEvent extends EditPersonEvent {
  final String firstName;
  final String lastName;
  final String birthDate;
  final String address;

  const UpdatePersonEvent({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.address,
  });

  @override
  List<Object?> get props => [firstName, lastName, birthDate, address];
}

class LoadGroupsEvent extends EditPersonEvent {}

class DeletePersonEvent extends EditPersonEvent {
  final int personId;

  const DeletePersonEvent({required this.personId});

  @override
  List<Object> get props => [personId];
}

class ToggleGroupSelectionEvent extends EditPersonEvent {
  final Group group;

  const ToggleGroupSelectionEvent({required this.group});

  @override
  List<Object?> get props => [group];
}
