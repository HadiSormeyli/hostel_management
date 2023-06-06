import 'package:equatable/equatable.dart';

abstract class DormFinanceState extends Equatable {
  const DormFinanceState();

  @override
  List<Object> get props => [];
}

class DormFinanceEmpty extends DormFinanceState {}

class DormFinanceLoading extends DormFinanceState {}

class DormFinanceSuccess extends DormFinanceState {
  final List<Map<String,dynamic>> dormFinances;

  const DormFinanceSuccess(this.dormFinances);

  @override
  List<Object> get props => [dormFinances];
}

class DormFinanceError extends DormFinanceState {
  final String message;

  const DormFinanceError(this.message);

  @override
  List<Object> get props => [message];
}
