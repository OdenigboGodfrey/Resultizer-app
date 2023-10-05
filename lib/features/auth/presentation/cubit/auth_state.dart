abstract class AuthState{}
class AuthLoading extends AuthState {}
class AuthLoadFailed extends AuthState {
  final String message;
  AuthLoadFailed(this.message);
}
class AuthLoadSuccess extends AuthState {}
class AuthInitial extends AuthState {}