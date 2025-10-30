part of 'update_cubit.dart';

abstract class UpdateState extends Equatable {
  const UpdateState();

  @override
  List<Object> get props => [];
}

class UpdateInitial extends UpdateState {}

class UpdateLoading extends UpdateState {}

class UpdateAvailableState extends UpdateState {
  final bool isForceUpdate;
  const UpdateAvailableState({
    required this.isForceUpdate,
  });
}

class UpdateError extends UpdateState {}
