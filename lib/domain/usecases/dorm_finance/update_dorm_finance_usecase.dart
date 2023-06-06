

import 'package:either_dart/either.dart';
import 'package:hostel_management/domain/repo/hostel_management_repository.dart';

import '../../../config/failure.dart';

class UpdateDormFinanceUseCase {
  final HostelManagementRepository repository;

  UpdateDormFinanceUseCase(this.repository);

  Future<Either<Failure, bool>> execute(Map<String?,dynamic> updatedDormFinance) {
    return repository.updateDormFinance(updatedDormFinance);
  }
}
