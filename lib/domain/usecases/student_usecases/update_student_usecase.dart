import 'package:either_dart/either.dart';
import 'package:hostel_management/domain/repo/hostel_management_repository.dart';

import '../../../config/failure.dart';

class UpdateStudentUseCase {
  final HostelManagementRepository repository;

  UpdateStudentUseCase(this.repository);

  Future<Either<Failure, bool>> execute(Map<String?,dynamic> updatedStudent) {
    return repository.updateStudent(updatedStudent);
  }
}
