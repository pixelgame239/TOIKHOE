import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define the User model class
class User {
  final int userId;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String status; // 'active' or 'inactive'
  final String role; // 'Patient' or 'Doctor'
  final String province;
  final String password;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.status,
    required this.role,
    required this.province,
    required this.password,
  });

  // Factory method to create a User from a JSON object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: int.tryParse(json['UserID'].toString()) ??
          0, // Sử dụng tryParse để tránh lỗi
      name: json['name'] as String? ?? '', // Mặc định là chuỗi rỗng nếu null
      email: json['email'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      address: json['address'] as String? ?? '',
      status: json['status'] as String? ?? 'inactive', // Giá trị mặc định
      role: json['role'] as String? ?? 'Patient', // Giá trị mặc định
      province: json['province'] as String? ?? '',
      password: json['password'] as String? ?? '',
    );
  }

  // Convert a User instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'status': status,
      'role': role,
      'province': province,
      'password': password,
    };
  }
}

// Define a Riverpod provider for a list of users
class UserNotifier extends StateNotifier<List<User>> {
  UserNotifier() : super([]);

  // Add a new user
  void addUser(User user) {
    state = [...state, user];
  }

  // Update an existing user
  void updateUser(int userId, User updatedUser) {
    state = state
        .map((user) => user.userId == userId ? updatedUser : user)
        .toList();
  }

  // Delete a user
  void deleteUser(int userId) {
    state = state.where((user) => user.userId != userId).toList();
  }

  // Load users from a JSON list (e.g., API response)
  void loadUsers(List<Map<String, dynamic>> jsonList) {
    state = jsonList.map((json) => User.fromJson(json)).toList();
  }

  // Reset the user data (e.g., on Log Out)
  void logOut() {
    state = []; // Reset to an empty list or initial value
  }
}

// Create a Riverpod provider for the UserNotifier
final userProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
  return UserNotifier();
});
