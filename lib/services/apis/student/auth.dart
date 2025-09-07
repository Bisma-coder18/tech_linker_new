import 'package:tech_linker_new/models/api-model.dart';
import 'package:tech_linker_new/models/institute-model.dart';
import 'package:tech_linker_new/models/student.dart';
import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/services/http-service.dart';
import 'package:tech_linker_new/services/local-storage.dart';

class AuthService {
  Future<ApiResponse> loginService({
    required String email,
    required String password,
    // required String role,
  }) async {
    final data = {'email': email, 'password': password};

    final response = await HttpService.post('/student/login', data);

    // If login successful, save token and user data
    if (response.success && response.data != null) {
      // final token = response.data!['token'];
      final userData = response.data!;

      // if (userData != null) {
      //   // await LocalStorage.setData(AppKeys.userToken, token);
      //   await LocalStorage.setData(AppKeys.userId, userData['id']);
      // }

      if (userData != null) {
        final user = User.fromJson(userData);
        print("smmsmsm");
        await LocalStorage.saveUser(user);
      }
    }

    return response;
  }

  Future<ApiResponse> institueLoginService({
    required String email,
    required String password,
    // required String role,
  }) async {
    final data = {'email': email, 'password': password};

    final response = await HttpService.post('/institute/login', data);

    // If login successful, save token and user data
    if (response.success && response.data != null) {
      // final token = response.data!['token'];
      final userData = response.data!;

      // if (userData != null) {
      //   // await LocalStorage.setData(AppKeys.userToken, token);
      //   await LocalStorage.setData(AppKeys.userId, userData['id']);
      // }

      if (userData != null) {
        final user = InstituteModel.fromJson(userData);
        print("smmsmsm");
        await LocalStorage.saveInstUser(user);
      }
    }

    return response;
  }
}
