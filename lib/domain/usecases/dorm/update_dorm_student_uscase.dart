

import 'package:either_dart/either.dart';
import 'package:hostel_management/domain/repo/hostel_management_repository.dart';

import '../../../config/failure.dart';

class UpdateStudentDormUseCase {
  final HostelManagementRepository repository;

  UpdateStudentDormUseCase(this.repository);

  Future<Either<Failure, bool>> execute(Map<String?,dynamic> updatedDorm) {
    return repository.updateStudentDorm(updatedDorm);
  }
}
