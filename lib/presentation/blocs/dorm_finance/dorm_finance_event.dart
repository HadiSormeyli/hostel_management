import 'package:equatable/equatable.dart';

class DormFinanceEvent extends Equatable {
  const DormFinanceEvent();

  @override
  List<Object> get props => [];
}

class AddDormFinanceEvent extends DormFinanceEvent {
  const AddDormFinanceEvent();

  @override
  List<Object> get props => [];
}

class UpdateDormFinanceEvent extends DormFinanceEvent {

  final Map<String?, dynamic> updatedDormFinance;

  const UpdateDormFinanceEvent(this.updatedDormFinance);

  @override
  List<Object> get props => [];
}