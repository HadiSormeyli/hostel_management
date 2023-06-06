import 'package:equatable/equatable.dart';

class ViolationEvent extends Equatable {
  const ViolationEvent();

  @override
  List<Object> get props => [];
}

class AddViolationEvent extends ViolationEvent {
  const AddViolationEvent();

  @override
  List<Object> get props => [];
}

class UpdateViolationEvent extends ViolationEvent {

  final Map<String?, dynamic> updateViolation;

  const UpdateViolationEvent(this.updateViolation);

  @override
  List<Object> get props => [];
}