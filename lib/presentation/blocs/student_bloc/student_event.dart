import 'package:equatable/equatable.dart';

class StudentEvent extends Equatable {
  const StudentEvent();

  @override
  List<Object> get props => [];
}

class AddStudentEvent extends StudentEvent {
  const AddStudentEvent();

  @override
  List<Object> get props => [];
}

class UpdateStudentEvent extends StudentEvent {

  final Map<String?, dynamic> updatedStudent;

  const UpdateStudentEvent(this.updatedStudent);

  @override
  List<Object> get props => [];
}