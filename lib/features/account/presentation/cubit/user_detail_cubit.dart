import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/utils/app_session.dart';
import 'package:resultizer_merged/features/account/domain/usecase/user_detail_usecase.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_state.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:resultizer_merged/onesignal_config.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class UserDetailCubit extends Cubit<UserDetailStates> {
  UserDetailCubit(
      this.userDetailUseCase,
      this.updateUserDetailUseCase,
      this.changePasswordUseCase,
      this.getFollowerUserUseCase,
      this.getFollowingUserUseCase,
      this.toggleFollowUserUseCase,
      this.fetchUserDetailByUidUseCase)
      : super(UserDetailInitial());

  final FetchUserDetailByEmailUseCase userDetailUseCase;
  final UpdateUserDetailUseCase updateUserDetailUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final GetFollowerUserUseCase getFollowerUserUseCase;
  final GetFollowingUserUseCase getFollowingUserUseCase;
  final ToggleFollowUserUseCase toggleFollowUserUseCase;
  final FetchUserDetailByUidUseCase fetchUserDetailByUidUseCase;

  late UserModel? userModel;
  late UserModel? fetchUserByUidResult;

  Future<UserModel?> fetchUserByEmail(String email) async {
    emit(UserDetailLoading());
    final fixtures = await userDetailUseCase(email);
    fixtures.fold(
      (left) {
        emit(UserDetailLoadFailure(left.message));
      },
      (right) {
        userModel = right;
        if (userModel!.id.isNotEmpty) {
          emit(UserDetailLoaded(userModel!));
        }
      },
    );
    return userModel;
  }

  Future<UserModel?> fetchUserByUid(String uid) async {
    fetchUserByUidResult = null;
    emit(UserDetailLoading());
    final fixtures = await fetchUserDetailByUidUseCase(uid);
    fixtures.fold(
      (left) {
        emit(UserDetailLoadFailure(left.message));
      },
      (right) {
        fetchUserByUidResult = right;
        if (fetchUserByUidResult!.id.isNotEmpty) {
          emit(UserDetailLoaded(fetchUserByUidResult!));
        }
      },
    );
    return fetchUserByUidResult;
  }

  Future<bool> updateUser(UserModel model) async {
    bool status = false;
    final fixtures = await updateUserDetailUseCase(model);
    fixtures.fold(
      (left) {},
      (right) {
        status = right;
      },
    );
    return status;
  }

  Future<bool> updatePassword(ChangePasswordParams model) async {
    bool status = false;
    final fixtures = await changePasswordUseCase(model);
    fixtures.fold(
      (left) {},
      (right) {
        status = right;
      },
    );
    return status;
  }

  Future<List<dynamic>> getFollowers(String uid) async {
    final result = await getFollowerUserUseCase(uid);
    List<dynamic> followers = [];
    result.fold((left) {}, (right) {
      if (right.containsKey('data')) followers = right['data'];
    });
    return followers;
  }

  Future<List<dynamic>> getFollowing(String uid) async {
    final result = await getFollowingUserUseCase(uid);
    List<dynamic> following = [];
    result.fold((left) {}, (right) {
      if (right.containsKey('data')) following = right['data'];
    });
    return following;
  }

  Future<bool> toggleFollowUserOld(String uid) async {
    // follow and unfollow user
    final result = await toggleFollowUserUseCase(uid);
    bool response = false;
    result.fold((left) {}, (right) {
      response = right;
    });
    return response;
  }

  Future<bool> toggleFollowUser(String uid, bool isFollowing) async {
    // follow and unfollow user
    final result = await toggleFollowUserUseCase(uid);
    bool response = false;
    result.fold((left) {}, (right) {
      response = right;
      if (isFollowing) {
        // remove from global user data
        GlobalDataSource.userData.following.remove(uid);
        unsubscribeFromTag(uid);
      } else {
        GlobalDataSource.userData.following.add(uid);
        subscribeToTag(uid);
      }

      AppSession.writeGlobalUserDataToLocal();
    });
    return response;
  }

  Future<String> uploadImage(String imagePath, String extension) async {
    try {
      var uploadRef = FirebaseStorage.instance.ref(
          '${AppString.profileImageUploadKey}/${GlobalDataSource.userData.id}.${extension.replaceAll('.', '')}');

      TaskSnapshot uploadResult = await uploadRef.putFile(File(imagePath));

      print('Image uploaded successfully!');
      return await uploadResult.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
    }
    return '';
  }
}
