import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hostel_management/domain/usecases/dorm/add_dorm_usecase.dart';
import 'package:hostel_management/domain/usecases/dorm/get_dorm_list_usecase.dart';
import 'package:hostel_management/domain/usecases/dorm/get_student_dorm_list_usecase.dart';
import 'package:hostel_management/domain/usecases/dorm/update_dorm_student_uscase.dart';
import 'package:hostel_management/domain/usecases/dorm/update_dorm_usecase.dart';
import 'package:hostel_management/presentation/blocs/dorm_bloc/dorm_event.dart';
import 'package:hostel_management/presentation/blocs/dorm_bloc/dorm_state.dart';

class DormBloc extends Bloc<DormEvent, DormState> {
  final GetDormListUseCase getDormListUseCase;
  final GetStudentDormListUseCase getStudentDormListUseCase;
  final AddDormUseCase addDormUseCase;
  final UpdateStudentDormUseCase updateStudentDormUseCase;
  final UpdateDormUseCase updateDormUseCase;

  DormBloc(this.getDormListUseCase, this.getStudentDormListUseCase,
      this.addDormUseCase,this.updateStudentDormUseCase,this.updateDormUseCase)
      : super(DormEmpty()) {
    on<DormEvent>((event, emit) async {
      emit(DormLoading());
      List<List<Map<String, dynamic>>> data = [];
      final result = await getDormListUseCase.execute();
      result.fold((failure) => emit(DormError(failure.message)), (r1) {
        data.add(r1);
      });

      final result2 = await getStudentDormListUseCase.execute();
      result2.fold((failure) => emit(DormError(failure.message)), (r2) {
        data.add(r2);
      });

      emit(DormSuccess(data));
      if (data.isEmpty) {
        emit(DormEmpty());
      }
    });

    on<AddDormEvent>((event, emit) async {
      emit(DormLoading());

      final isInserted = await addDormUseCase.execute();
      if (isInserted.right) {
        List<List<Map<String, dynamic>>> data = [];
        final result = await getDormListUseCase.execute();
        result.fold((failure) => emit(DormError(failure.message)), (r1) {
          data.add(r1);
        });

        final result2 = await getStudentDormListUseCase.execute();
        result2.fold((failure) => emit(DormError(failure.message)), (r2) {
          data.add(r2);
        });

        emit(DormSuccess(data));
        if (data.isEmpty) {
          emit(DormEmpty());
        }
      }
    });

    on<UpdateStudentDormEvent>((event, emit) async {
      emit(DormLoading());

      final isInserted =
      await updateStudentDormUseCase.execute(event.updatedDorm);

      if (isInserted.right) {
        List<List<Map<String, dynamic>>> data = [];
        final result = await getDormListUseCase.execute();
        result.fold((failure) => emit(DormError(failure.message)), (r1) {
          data.add(r1);
        });

        final result2 = await getStudentDormListUseCase.execute();
        result2.fold((failure) => emit(DormError(failure.message)), (r2) {
          data.add(r2);
        });

        emit(DormSuccess(data));
        if (data.isEmpty) {
          emit(DormEmpty());
        }
      }
    });

    on<UpdateDormEvent>((event, emit) async {
      emit(DormLoading());

      final isInserted =
      await updateDormUseCase.execute(event.updatedDorm);

      if (isInserted.right) {
        List<List<Map<String, dynamic>>> data = [];
        final result = await getDormListUseCase.execute();
        result.fold((failure) => emit(DormError(failure.message)), (r1) {
          data.add(r1);
        });

        final result2 = await getStudentDormListUseCase.execute();
        result2.fold((failure) => emit(DormError(failure.message)), (r2) {
          data.add(r2);
        });

        emit(DormSuccess(data));
        if (data.isEmpty) {
          emit(DormEmpty());
        }
      }
    });
  }
}
