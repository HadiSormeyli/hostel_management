

import 'package:either_dart/either.dart';
import 'package:hostel_management/domain/repo/hostel_management_repository.dart';

import '../../../config/failure.dart';

class AddDormUseCase {
  final HostelManagementRepository repository;

  AddDormUseCase(this.repository);

  Future<Either<Failure, bool>> execute() {
    return repository.addDorm();
  }
}
