import 'package:equatable/equatable.dart';

abstract class DormState extends Equatable {
  const DormState();

  @override
  List<Object> get props => [];
}

class DormEmpty extends DormState {}

class DormLoading extends DormState {}

class DormSuccess extends DormState {
  final List<List<Map<String, dynamic>>> dorms;

  const DormSuccess(this.dorms);

  @override
  List<Object> get props => [dorms];
}

class DormError extends DormState {
  final String message;

  const DormError(this.message);

  @override
  List<Object> get props => [message];
}
