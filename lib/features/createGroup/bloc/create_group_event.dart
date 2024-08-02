import 'package:equatable/equatable.dart';

abstract class CreateGroupEvent extends Equatable {
  const CreateGroupEvent();

  @override
  List<Object> get props => [];
}

class SubmitGroupEvent extends CreateGroupEvent {
  final String name;
  final List<int> persons;

  const SubmitGroupEvent({
    required this.name,
    required this.persons,
  });

  @override
  List<Object> get props => [name, persons];
}

class ReadAllPersonsEvent extends CreateGroupEvent {}


