import 'package:get/get.dart';

class HiredRejectedUsersController extends GetxController {
  var isLoading = false.obs;
  var hiredUsers = <Map<String, dynamic>>[].obs;
  var rejectedUsers = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  void fetchUsers() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 1)); // Simulate API call
    hiredUsers.value = [
      {
        'id': '1',
        'name': 'John Doe',
        'imageUrl': 'https://via.placeholder.com/150',
        'description': 'Experienced UI/UX designer with 3+ years.',
      },
      {
        'id': '2',
        'name': 'Jane Smith',
        'imageUrl': 'https://via.placeholder.com/150',
        'description': 'Skilled in front-end development.',
      },
    ];
    rejectedUsers.value = [
      {
        'id': '3',
        'name': 'Alice Johnson',
        'imageUrl': 'https://via.placeholder.com/150',
        'description': 'Recently graduated, limited experience.',
      },
      {
        'id': '4',
        'name': 'Bob Brown',
        'imageUrl': 'https://via.placeholder.com/150',
        'description': 'Applied but did not meet criteria.',
      },
    ];
    isLoading.value = false;
  }
}