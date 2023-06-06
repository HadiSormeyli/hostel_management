

import 'package:either_dart/either.dart';
import 'package:hostel_management/domain/repo/hostel_management_repository.dart';

import '../../../config/failure.dart';

class GetStudentDormListUseCase {
  final HostelManagementRepository repository;

  GetStudentDormListUseCase(this.repository);

  Future<Either<Failure, List<Map<String, dynamic>>>> execute() {
    return repository.getStudentDormList();
  }
}
