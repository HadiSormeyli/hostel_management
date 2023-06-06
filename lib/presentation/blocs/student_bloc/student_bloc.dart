import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hostel_management/domain/usecases/student_usecases/add_student_usecase.dart';
import 'package:hostel_management/domain/usecases/student_usecases/get_student_list_usecase.dart';
import 'package:hostel_management/domain/usecases/student_usecases/update_student_usecase.dart';
import 'package:hostel_management/presentation/blocs/student_bloc/student_event.dart';
import 'package:hostel_management/presentation/blocs/student_bloc/student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final GetStudentListUseCase getStudentListUseCase;
  final AddStudentUseCase addStudentUseCase;
  final UpdateStudentUseCase updateStudentUseCase;

  StudentBloc(this.getStudentListUseCase, this.addStudentUseCase,
      this.updateStudentUseCase)
      : super(StudentEmpty()) {
    on<StudentEvent>((event, emit) async {
      emit(StudentLoading());
      final result = await getStudentListUseCase.execute();
      result.fold((failure) => emit(StudentError(failure.message)),
          (StudentsData) {
        emit(StudentSuccess(StudentsData));
        if (StudentsData.isEmpty) {
          emit(StudentEmpty());
        }
      });
    });
    on<AddStudentEvent>((event, emit) async {
      emit(StudentLoading());

      final isInserted = await addStudentUseCase.execute();
      if (isInserted.right) {
        final result = await getStudentListUseCase.execute();
        result.fold((failure) => emit(StudentError(failure.message)),
            (StudentsData) {
          emit(StudentSuccess(StudentsData));
          if (StudentsData.isEmpty) {
            emit(StudentEmpty());
          }
        });
      }
    });
    on<UpdateStudentEvent>((event, emit) async {
      emit(StudentLoading());

      final isInserted =
          await updateStudentUseCase.execute(event.updatedStudent);

      if (isInserted.right) {
        final result = await getStudentListUseCase.execute();
        result.fold((failure) => emit(StudentError(failure.message)),
            (StudentsData) {
          emit(StudentSuccess(StudentsData));
          if (StudentsData.isEmpty) {
            emit(StudentEmpty());
          }
        });
      }
    });
  }
}
