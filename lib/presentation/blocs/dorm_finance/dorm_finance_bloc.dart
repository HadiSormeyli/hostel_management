import 'package:bloc/bloc.dart';
import 'package:hostel_management/domain/usecases/dorm_finance/update_dorm_finance_usecase.dart';

import '../../../domain/usecases/dorm_finance/add_dorm_finance_usecase.dart';
import '../../../domain/usecases/dorm_finance/get_dorm_finance_list_usecase.dart';
import 'dorm_finance_event.dart';
import 'dorm_finance_state.dart';

class DormFinanceBloc extends Bloc<DormFinanceEvent, DormFinanceState> {
  final GetDormFinanceListUseCase getDormFinanceListUseCase;
  final AddDormFinanceUseCase addDormFinanceUseCase;
  final UpdateDormFinanceUseCase updateDormFinanceUseCase;

  DormFinanceBloc(this.getDormFinanceListUseCase,this.addDormFinanceUseCase,this.updateDormFinanceUseCase)
      : super(DormFinanceEmpty()) {
    on<DormFinanceEvent>((event, emit) async {
      emit(DormFinanceLoading());
      final result = await getDormFinanceListUseCase.execute();
      result.fold((failure) => emit(DormFinanceError(failure.message)),
              (DormFinancesData) {
            emit(DormFinanceSuccess(DormFinancesData));
            if (DormFinancesData.isEmpty) {
              emit(DormFinanceEmpty());
            }
          });
    });

    on<AddDormFinanceEvent>((event, emit) async {
      emit(DormFinanceLoading());

      final isInserted =
      await addDormFinanceUseCase.execute();

      if (isInserted.right) {
        final result = await getDormFinanceListUseCase.execute();
        result.fold((failure) => emit(DormFinanceError(failure.message)),
                (StudentsData) {
              emit(DormFinanceSuccess(StudentsData));
              if (StudentsData.isEmpty) {
                emit(DormFinanceEmpty());
              }
            });
      }
    });

    on<UpdateDormFinanceEvent>((event, emit) async {
      emit(DormFinanceLoading());

      final isInserted =
      await updateDormFinanceUseCase.execute(event.updatedDormFinance);

      if (isInserted.right) {
        final result = await getDormFinanceListUseCase.execute();
        result.fold((failure) => emit(DormFinanceError(failure.message)),
                (StudentsData) {
              emit(DormFinanceSuccess(StudentsData));
              if (StudentsData.isEmpty) {
                emit(DormFinanceEmpty());
              }
            });
      }
    });
  }
}
