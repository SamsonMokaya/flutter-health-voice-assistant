// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'delete_account_bloc.dart';

abstract class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();

  @override
  List<Object> get props => [];
}

class DeleteAccount extends DeleteAccountEvent {
  const DeleteAccount();
}
