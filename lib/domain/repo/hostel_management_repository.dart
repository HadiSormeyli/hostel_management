import 'package:either_dart/either.dart';

import '../../config/failure.dart';

abstract class HostelManagementRepository {
  Future<Either<Failure, List<Map<String,dynamic>>>> getStudentList();
  Future<Either<Failure, bool>> addStudent();
  Future<Either<Failure, bool>> updateStudent(Map<String?,dynamic> updatedStudent);
  Future<Either<Failure, List<Map<String, dynamic>>>> getDormList();
  Future<Either<Failure, List<Map<String, dynamic>>>> getStudentDormList();
  Future<Either<Failure, List<Map<String,dynamic>>>> getDormFinanceList();
  Future<Either<Failure, List<Map<String,dynamic>>>> getViolationList();
  Future<Either<Failure, bool>> addViolation();
  Future<Either<Failure, bool>> updateViolation(Map<String?,dynamic> updateViolation);

  Future<Either<Failure, bool>> addDormFinance();

  Future<Either<Failure, bool>> updateDormFinance(Map<String?, dynamic> updatedDormFinance);

  Future<Either<Failure, bool>> addDorm();

  Future<Either<Failure, bool>> updateStudentDorm(Map<String?, dynamic> updatedDorm);

  Future<Either<Failure, bool>> updateDorm(Map<String?, dynamic> updatedDorm);
}
