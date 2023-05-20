part of 'social_login_cubit.dart';

abstract class SocialLoginState extends Equatable {
  const SocialLoginState();

  @override
  List<Object> get props => [];
}

class SocialLoginInitial extends SocialLoginState {}

class SocialLoginLoading extends SocialLoginState {}

class SocialLoginSuccess extends SocialLoginState {
  final User user;

  const SocialLoginSuccess({required this.user});
}

class SocialLoginError extends SocialLoginState {
  final String message;

  const SocialLoginError({required this.message});
}
