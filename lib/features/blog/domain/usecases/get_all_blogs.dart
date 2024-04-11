import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/blog_entity.dart';
import '../repositories/blog_repository.dart';

class GetAllBlogs implements UseCase<List<BlogEntity>, NoParams> {
  final BlogRepository repository;

  GetAllBlogs(this.repository);

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async {
    return await repository.getAllBlogs();
  }
}
