import 'package:get_it/get_it.dart';
import 'package:hostel_management/data/datasource/hostel_management_data_source.dart';
import 'package:hostel_management/domain/repo/hostel_management_repository.dart';
import 'package:hostel_management/domain/usecases/dorm/add_dorm_usecase.dart';
import 'package:hostel_management/domain/usecases/dorm/get_student_dorm_list_usecase.dart';
import 'package:hostel_management/domain/usecases/dorm/update_dorm_student_uscase.dart';
import 'package:hostel_management/domain/usecases/dorm/update_dorm_usecase.dart';
import 'package:hostel_management/domain/usecases/dorm_finance/update_dorm_finance_usecase.dart';
import 'package:hostel_management/domain/usecases/dorm/get_dorm_list_usecase.dart';
import 'package:hostel_management/domain/usecases/student_usecases/add_student_usecase.dart';
import 'package:hostel_management/domain/usecases/student_usecases/get_student_list_usecase.dart';
import 'package:hostel_management/domain/usecases/student_usecases/update_student_usecase.dart';
import 'package:hostel_management/domain/usecases/violation/add_violation_usecase.dart';
import 'package:hostel_management/domain/usecases/violation/get_violation_list_usecase.dart';
import 'package:hostel_management/domain/usecases/violation/update_violation_usecase.dart';
import 'package:hostel_management/presentation/blocs/dorm_bloc/dorm_bloc.dart';
import 'package:hostel_management/presentation/blocs/dorm_finance/dorm_finance_bloc.dart';
import 'package:hostel_management/presentation/blocs/student_bloc/student_bloc.dart';
import 'package:hostel_management/presentation/blocs/violation/violation_bloc.dart';
import 'package:http/http.dart' as http;

import '../data/repo/hostel_management_repository_impl.dart';
import '../domain/usecases/dorm_finance/add_dorm_finance_usecase.dart';
import '../domain/usecases/dorm_finance/get_dorm_finance_list_usecase.dart';

final locator = GetIt.instance;

void init() {
  //bloc
  locator.registerFactory(
    () => StudentBloc(locator(), locator(), locator()),
  );

  locator.registerFactory(
    () => DormBloc(
      locator(),locator(),locator(),locator(),locator()
    ),
  );

  locator.registerFactory(
    () => ViolationBloc(locator(), locator(), locator()),
  );

  locator.registerFactory(
    () => DormFinanceBloc(locator(), locator(), locator()),
  );

  //use case
  locator.registerLazySingleton(() => GetStudentListUseCase(locator()));
  locator.registerLazySingleton(() => AddStudentUseCase(locator()));
  locator.registerLazySingleton(() => UpdateStudentUseCase(locator()));
  locator.registerLazySingleton(() => GetDormListUseCase(locator()));
  locator.registerLazySingleton(() => GetViolationListUseCase(locator()));
  locator.registerLazySingleton(() => GetDormFinanceListUseCase(locator()));
  locator.registerLazySingleton(() => AddViolationUseCase(locator()));
  locator.registerLazySingleton(() => UpdateViolationUseCase(locator()));
  locator.registerLazySingleton(() => AddDormFinanceUseCase(locator()));
  locator.registerLazySingleton(() => UpdateDormFinanceUseCase(locator()));
  locator.registerLazySingleton(() => GetStudentDormListUseCase(locator()));
  locator.registerLazySingleton(() => AddDormUseCase(locator()));
  locator.registerLazySingleton(() => UpdateStudentDormUseCase(locator()));
  locator.registerLazySingleton(() => UpdateDormUseCase(locator()));

  locator.registerLazySingleton<HostelManagementRepository>(
    () => HostelManagementRepositoryImpl(locator()),
  );

  //data source
  locator.registerLazySingleton<HostelManagementDataSource>(
    () => HostelManagementDataSourceImpl(client: locator()),
  );

  //http client
  locator.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
}
