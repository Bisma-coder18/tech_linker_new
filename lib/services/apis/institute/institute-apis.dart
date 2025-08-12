// institute_api_service.dart
import 'package:tech_linker_new/models/api-model.dart';
import 'package:tech_linker_new/models/institute-model.dart';
import 'package:tech_linker_new/services/api.dart';
import 'package:tech_linker_new/services/apis/base-api.dart';

class InstituteApiService extends BaseApiService {
  Future<ApiResponse<InstituteModel>> loginInstitute({
    required String email,
    required String password,
  }) {
    final data = {'email': email, 'password': password};

    return post<InstituteModel>(
      url: AppKeys.institeLogin,
      body: data,
      fromJson: (json) => InstituteModel.fromJson(json), // expects json == the user object
    );
  }
  Future<ApiResponse<InstituteModel>> signUpInstitute({
    required String email,
    required String password,
    required String name,
    required String contact,
    required String address,
  }) {
    final data = {
      'email': email,
      'password': password,
      "name":name,
      "phone":contact,
      'address': address,
      };

    return post<InstituteModel>(
      url: AppKeys.institeSignUp,
      body: data,
      fromJson: (json) => InstituteModel.fromJson(json), // expects json == the user object
    );
  }
   Future<ApiResponse<InstituteModel>> getProfileById({
    required String id,
  }) {
   

    return get<InstituteModel>(
      url: AppKeys.profile+id,
      fromJson: (json) => InstituteModel.fromJson(json),
    );
  }

  // Update profile
  Future<ApiResponse<InstituteModel>> updateProfile({
    required String id,
    required String email,
    required String name,
    required String contact,
    required String address,
  }) {
    final data = {
      '_id': id,
      'email': email,
      "name": name,
      "phone": contact,
      'address': address,
    };
print( AppKeys.updateUser+id);
    return post<InstituteModel>(
      url: AppKeys.updateUser+id, // <-- make sure this key exists in AppKeys
      body: data,
      fromJson: (json) => InstituteModel.fromJson(json),
    );
  }


}
