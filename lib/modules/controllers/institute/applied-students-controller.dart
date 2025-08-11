import 'package:get/get.dart';

class Post {
  final String id;
  final String title;

  Post({required this.id, required this.title});
}

class User {
  final String name;
  final String email;
  final String profileImage;

  User({required this.name, required this.email, this.profileImage = ''});
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
        User(name: 'John Doe', email: 'john@example.com', profileImage: 'path/to/image'),
        User(name: 'Jane Smith', email: 'jane@example.com', profileImage: 'path/to/image'),
      ],
      '2': [
        User(name: 'Alice Johnson', email: 'alice@example.com', profileImage: 'path/to/image'),
      ],
    };
    isLoading.value = false;
  }
}