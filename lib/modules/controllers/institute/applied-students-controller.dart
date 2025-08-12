import 'package:get/get.dart';
import 'package:tech_linker_new/models/student.dart';
import 'package:tech_linker_new/modules/controllers/institute/applied-student-detail.dart';

class Post {
  final String id;
  final String title;

  Post({required this.id, required this.title});
}



class AppliedUsersController extends GetxController {
  var posts = <Post>[].obs;
  var appliedUsers = <String, List<User>>{}.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAppliedUsers();
  }

  void fetchAppliedUsers() async {
    // Simulate API call or data fetch
    await Future.delayed(Duration(seconds: 2));
    posts.value = [
      Post(id: '1', title: 'UI/UX Designer Internship'),
      Post(id: '2', title: 'Software Developer Internship'),
    ];
    appliedUsers.value = {
      '1': [
        User (id: "1", name: 'John Doe', email: 'john@example.com', avatar: 'path/to/image',role: "institute"),
        User(id: "1", name: 'Jane Smith', email: 'jane@example.com', avatar: 'path/to/image',role: "institute"),
      ],
      '2': [
        User(id: "1", name: 'Alice Johnson', email: 'alice@example.com', avatar: 'path/to/image',role: "institute"),
      ],
    };
    isLoading.value = false;
  }
}