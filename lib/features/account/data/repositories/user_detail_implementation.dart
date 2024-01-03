import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/account/data/datasource/user_detail_datasource.dart';
import 'package:resultizer_merged/features/account/domain/repository/user_detail_repository.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';

class UserDetailImplementation implements UserDetailRepository {
  final UserDetailDataSource dataSource;
  final NetworkInfo networkInfo;
  UserDetailImplementation({
    required this.dataSource,
    required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, UserModel>> fetchUserByEmail({required String email}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await dataSource.fetchUserByEmail(email: email);
        final user = result;
        return Right(user);
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
        // return Left(DataSource.unexpected.getFailure());
        return const Left(Failure(code: 01, message: 'unexpected'));
      }
    } else {
      // return Left(DataSource.networkConnectError.getFailure());
      return const Left(Failure(code: 02, message: 'networkConnectError'));
    }
  }
  
  @override
  Future<Either<Failure, bool>> updateUser({required UserModel userModel}) async {
    if (await networkInfo.isConnected) {
      try {
        final result =
            await dataSource.updateUser(userModel: userModel);
        final user = result;
        return Right(user);
      } catch (e, stackTrace) {
        print(e);
        print(stackTrace);
        // return Left(DataSource.unexpected.getFailure());
        return const Left(Failure(code: 01, message: 'unexpected'));
      }
    } else {
      // return Left(DataSource.networkConnectError.getFailure());
      return const Left(Failure(code: 02, message: 'networkConnectError'));
    }
  }
  }