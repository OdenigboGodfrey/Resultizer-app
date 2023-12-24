import 'package:bloc/bloc.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/account/data/models/chat_item_dto.dart';
import 'package:resultizer_merged/features/account/domain/usecase/manage_chat_usecase.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/manage_chat_state.dart';

class ManageChatCubit extends Cubit<ManageChatStates> {
  ManageChatCubit(
      {required this.countChatUseCase,
      required this.getAllChatMetaUseCase,
      required this.deleteChatUseCase,
      required this.deleteChatMetaUseCase,
    })
      : super(ManageChatInitial());

  final CountChatUseCase countChatUseCase;
  final GetAllChatMetaUseCase getAllChatMetaUseCase;
  final DeleteChatUseCase deleteChatUseCase;
  final DeleteChatMetaUseCase deleteChatMetaUseCase;

  Future<int> countChat(int fixtureId) async {
    // emit(ManageChatLoading());
    final result = await countChatUseCase(fixtureId);
    int count = 0;
    result.fold(
      (left) {},
      (right) {
        count = right;
        emit(CountingChatLoaded(count));
      },
    );
    return count;
  }

  Future<List<ChatMetaDTO>> getAllChatMeta() async {
    // emit(ManageChatLoading());
    final result = await getAllChatMetaUseCase(NoParams());
    List<ChatMetaDTO> response = [];
    result.fold(
      (left) {
        emit(GetChatMetaFailure('Failed to fetch chat meta'));
      },
      (right) {
        for (var element in right) {
          print(element.value);
          response.add(ChatMetaDTO.fromJson(element.value));
        }
      },
    );
    return response;
  }

  Future<bool> deleteChat(int fixtureId) async {
    // emit(ManageChatLoading());
    final deleteChatResult = await deleteChatUseCase(fixtureId);
    final deleteChatMetaResult = await deleteChatMetaUseCase(fixtureId);
    bool hasDeletedChat = false;
    deleteChatResult.fold(
      (left) {},
      (right) {
        hasDeletedChat = right;
        // emit(CountingChatLoaded(count));
      },
    );
    deleteChatMetaResult.fold(
      (left) {},
      (right) {
        print('has deleted chat meta $right');
        // hasDeletedChat = right;
        // emit(CountingChatLoaded(count));
      },
    );
    return hasDeletedChat;
  }

  // Future<bool> updateUser(UserModel model) async {
  //   bool status = false;
  //   final fixtures = await updateManageChatUseCase(model);
  //   fixtures.fold(
  //     (left) {},
  //     (right) {
  //       status = right;

  //     },
  //   );
  //   return status;
  // }
}
