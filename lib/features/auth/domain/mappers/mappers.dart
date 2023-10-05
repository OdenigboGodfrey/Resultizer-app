import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:resultizer_merged/features/auth/domain/entities/user.dart';

extension UserModelExtension on UserModel {
  User toDomain() => User(id: id, email: email, username: username);
}