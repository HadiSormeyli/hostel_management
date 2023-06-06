import 'package:bloc/bloc.dart';
import 'package:hostel_management/domain/usecases/violation/add_violation_usecase.dart';
import 'package:hostel_management/domain/usecases/violation/update_violation_usecase.dart';
import 'package:hostel_management/presentation/blocs/violation/violation_event.dart';
import 'package:hostel_management/presentation/blocs/violation/violation_state.dart';

import '../../../domain/usecases/violation/get_violation_list_usecase.dart';

class ViolationBloc extends Bloc<ViolationEvent, ViolationState> {
  final GetViolationListUseCase getViolationListUseCase;
  final AddViolationUseCase addViolationUseCase;
  final UpdateViolationUseCase updateViolationUseCase;

  ViolationBloc(this.getViolationListUseCase, this.addViolationUseCase, this.updateViolationUseCase)
      : super(ViolationEmpty()) {
    on<ViolationEvent>((event, emit) async {
      emit(ViolationLoading());
      final result = await getViolationListUseCase.execute();
      result.fold((failure) => emit(ViolationError(failure.message)),
          (ViolationsData) {
        emit(ViolationSuccess(ViolationsData));
        if (ViolationsData.isEmpty) {
          emit(ViolationEmpty());
        }
      });
    });
    on<AddViolationEvent>((event, emit) async {
      emit(ViolationLoading());

      final isInserted = await addViolationUseCase.execute();
      if (isInserted.right) {
        final result = await getViolationListUseCase.execute();
        result.fold((failure) => emit(ViolationError(failure.message)),
            (ViolationsData) {
          emit(ViolationSuccess(ViolationsData));
          if (ViolationsData.isEmpty) {
            emit(ViolationEmpty());
          }
        });
      }
    });
    on<UpdateViolationEvent>((event, emit) async {
      emit(ViolationLoading());

      final isInserted = await updateViolationUseCase.execute(event.updateViolation);
      if (isInserted.right) {
        final result = await getViolationListUseCase.execute();
        result.fold((failure) => emit(ViolationError(failure.message)),
                (ViolationsData) {
              emit(ViolationSuccess(ViolationsData));
              if (ViolationsData.isEmpty) {
                emit(ViolationEmpty());
              }
            });
      }
    });
  }
}
