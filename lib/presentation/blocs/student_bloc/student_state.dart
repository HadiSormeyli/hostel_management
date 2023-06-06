import 'package:equatable/equatable.dart';

abstract class StudentState extends Equatable {
  const StudentState();

  @override
  List<Object> get props => [];
}

class StudentEmpty extends StudentState {}

class StudentLoading extends StudentState {}

class StudentSuccess extends StudentState {
  final List<Map<String,dynamic>> students;

  const StudentSuccess(this.students);

  @override
  List<Object> get props => [students];
}

class StudentError extends StudentState {
  final String message;

  const StudentError(this.message);

  @override
  List<Object> get props => [message];
}
