

import 'package:either_dart/either.dart';
import 'package:hostel_management/domain/repo/hostel_management_repository.dart';

import '../../../config/failure.dart';

class AddDormFinanceUseCase {
  final HostelManagementRepository repository;

  AddDormFinanceUseCase(this.repository);

  Future<Either<Failure, bool>> execute() {
    return repository.addDormFinance();
  }
}
