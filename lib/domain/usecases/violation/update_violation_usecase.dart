

import 'package:either_dart/either.dart';
import 'package:hostel_management/domain/repo/hostel_management_repository.dart';

import '../../../config/failure.dart';

class UpdateViolationUseCase {
  final HostelManagementRepository repository;

  UpdateViolationUseCase(this.repository);

  Future<Either<Failure, bool>> execute(Map<String?,dynamic> updateViolation) {
    return repository.updateViolation(updateViolation);
  }
}
