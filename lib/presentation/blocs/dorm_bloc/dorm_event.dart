import 'package:equatable/equatable.dart';

class DormEvent extends Equatable {
  const DormEvent();

  @override
  List<Object> get props => [];
}

class AddDormEvent extends DormEvent {
  const AddDormEvent();

  @override
  List<Object> get props => [];
}

class UpdateStudentDormEvent extends DormEvent {
  final Map<String?,dynamic> updatedDorm;

  const UpdateStudentDormEvent(this.updatedDorm);

  @override
  List<Object> get props => [];
}

class UpdateDormEvent extends DormEvent {
  final Map<String?,dynamic> updatedDorm;

  const UpdateDormEvent(this.updatedDorm);

  @override
  List<Object> get props => [];
}