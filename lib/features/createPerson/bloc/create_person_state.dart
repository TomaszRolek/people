import 'package:equatable/equatable.dart';
import 'package:people/utils/state_status.dart';

class CreatePersonState extends Equatable {
  final StateStatus status;

  const CreatePersonState({this.status = StateStatus.initial});

  CreatePersonState copyWith({StateStatus? status}) {
    return CreatePersonState(status: status ?? this.status);
  }

  @override
  List<Object> get props => [status];
}
