import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:hostel_management/data/datasource/hostel_management_data_source.dart';

import '../../config/exception.dart';
import '../../config/failure.dart';
import '../../domain/repo/hostel_management_repository.dart';

class HostelManagementRepositoryImpl extends HostelManagementRepository {
  final HostelManagementDataSource dataSource;

  HostelManagementRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getStudentList() async {
    try {
      final result = await dataSource.getStudentList();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, bool>> addStudent() async {
    try {
      final result = await dataSource.addStudent();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getDormList() async {
    try {
      final result = await dataSource.getDormList();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getStudentDormList() async {
    try {
      final result = await dataSource.getStudentDormList();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getViolationList() async {
    try {
      final result = await dataSource.getViolationList();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>>
      getDormFinanceList() async {
    try {
      final result = await dataSource.getDormFinanceList();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, bool>> addDormFinance() async {
    try {
      final result = await dataSource.addDormFinance();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateDormFinance(
      Map<String?, dynamic> updatedDormFinance) async {
    try {
      final result = await dataSource.updateDormFinance(updatedDormFinance);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateStudent(
      Map<String?, dynamic> updatedStudent) async {
    try {
      final result = await dataSource.updateStudent(updatedStudent);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, bool>> addViolation() async {
    try {
      final result = await dataSource.addViolation();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateViolation(
      Map<String?, dynamic> updateViolation) async {
    try {
      final result = await dataSource.updateViolation(updateViolation);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, bool>> addDorm() async {
    try {
      final result = await dataSource.addDorm();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateStudentDorm(Map<String?, dynamic> updatedDorm) async {
    try {
      final result = await dataSource.updateStudentDorm(updatedDorm);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }

  @override
  Future<Either<Failure, bool>> updateDorm(Map<String?, dynamic> updatedDorm) async {
    try {
      final result = await dataSource.updateDorm(updatedDorm);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on TlsException catch (e) {
      return Left(CommonFailure('Certificated Not Valid:\n${e.message}'));
    }
  }
}
