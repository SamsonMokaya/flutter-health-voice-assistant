import 'package:diseases/constants/constants.dart';
import 'package:diseases/repositories/authentication/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final AuthRepository _authRepository;
  DeleteAccountBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(DeleteAccountInitial()) {
    on<DeleteAccount>(_onDeleteAccount);
  }

  Future<void> _onDeleteAccount(
      DeleteAccount event, Emitter<DeleteAccountState> emit) async {
    emit(DeleteAccountLoding());
    try {
      final deleted = await _authRepository.deleteUser(
          userId: currentUser.userId.toString());
      if (deleted == true) {
        emit(AccountDeletedSuccess());
      }
    } catch (e) {
      emit(DeleteAccountError(errorMessage: e.toString()));
    }
  }
}
