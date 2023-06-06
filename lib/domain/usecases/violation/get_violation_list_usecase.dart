

import 'package:either_dart/either.dart';
import 'package:hostel_management/domain/repo/hostel_management_repository.dart';

import '../../../config/failure.dart';

class GetViolationListUseCase {
  final HostelManagementRepository repository;

  GetViolationListUseCase(this.repository);

  Future<Either<Failure, List<Map<String,dynamic>>>> execute() {
    return repository.getViolationList();
  }
}
