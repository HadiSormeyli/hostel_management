import 'package:equatable/equatable.dart';

abstract class ViolationState extends Equatable {
  const ViolationState();

  @override
  List<Object> get props => [];
}

class ViolationEmpty extends ViolationState {}

class ViolationLoading extends ViolationState {}

class ViolationSuccess extends ViolationState {
  final List<Map<String,dynamic>> violations;

  const ViolationSuccess(this.violations);

  @override
  List<Object> get props => [violations];
}

class ViolationError extends ViolationState {
  final String message;

  const ViolationError(this.message);

  @override
  List<Object> get props => [message];
}
