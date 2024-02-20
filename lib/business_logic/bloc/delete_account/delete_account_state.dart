part of 'delete_account_bloc.dart';

abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

class DeleteAccountLoding extends DeleteAccountState {}

class DeleteAccountInitial extends DeleteAccountState {}

class AccountDeletedSuccess extends DeleteAccountState {
  @override
  List<Object> get props => [];
}

class DeleteAccountError extends DeleteAccountState {
  final String errorMessage;
  const DeleteAccountError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
