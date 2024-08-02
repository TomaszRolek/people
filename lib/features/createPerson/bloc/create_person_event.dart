import 'package:equatable/equatable.dart';

abstract class CreatePersonEvent extends Equatable {
  const CreatePersonEvent();

  @override
  List<Object> get props => [];
}

class SubmitPersonEvent extends CreatePersonEvent {
  final String firstName;
  final String lastName;
  final String dateOfBirth;
  final String address;

  const SubmitPersonEvent({
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.address,
  });

  @override
  List<Object> get props => [firstName, lastName, dateOfBirth, address];
}
