import 'package:flutter/material.dart';
import 'RdsService.dart';
import 'login_screen.dart'; // Import RdsService class

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passController = TextEditingController();

  // Khởi tạo đối tượng RdsService
  final RdsService _rdsService = RdsService();

  // Các giá trị mặc định
  String _selectedProvince = 'Hà Nội'; // Giá trị mặc định cho tỉnh thành
  String _selectedRole = 'Patient'; // Giá trị mặc định cho vai trò

  // Danh sách tỉnh thành Việt Nam
  final List<String> provinces = [
    'Hà Nội', 'Hồ Chí Minh', 'Đà Nẵng', 'Hải Phòng', 'Cần Thơ', 'An Giang',
    'Bà Rịa - Vũng Tàu', 'Bắc Giang', 'Bắc Kạn', 'Bạc Liêu', 'Bắc Ninh', 'Bến Tre',
    'Bình Dương', 'Bình Định', 'Bình Phước', 'Bình Thuận', 'Cà Mau', 'Cao Bằng',
    'Cần Thơ', 'Đắk Lắk', 'Đắk Nông', 'Điện Biên', 'Đồng Nai', 'Đồng Tháp',
    'Gia Lai', 'Hà Giang', 'Hà Nam', 'Hà Tĩnh', 'Hậu Giang', 'Hòa Bình',
    'Hưng Yên', 'Khánh Hòa', 'Kiên Giang', 'Kon Tum', 'Lai Châu', 'Lâm Đồng',
    'Long An', 'Nam Định', 'Nghệ An', 'Ninh Bình', 'Ninh Thuận', 'Phú Thọ',
    'Phú Yên', 'Quảng Bình', 'Quảng Nam', 'Quảng Ngãi', 'Quảng Ninh', 'Quảng Trị',
    'Sóc Trăng', 'Sơn La', 'Tây Ninh', 'Thái Bình', 'Thái Nguyên', 'Thanh Hóa',
    'Thừa Thiên Huế', 'Tiền Giang', 'Trà Vinh', 'Tuyên Quang', 'Vĩnh Long',
    'Vĩnh Phúc', 'Yên Bái'
  ];

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final phone = _phoneController.text.trim();
      final address = _addressController.text.trim();
      final password = _passController.text;
      final province = _selectedProvince;  // Lấy giá trị tỉnh thành
      final role = _selectedRole;  // Lấy giá trị vai trò

      try {
        // Gọi phương thức registerUser từ RdsService để lưu vào RDS
        await _rdsService.registerUser(name, email, phone, address, province, role, password);

        // Sau khi đăng ký thành công, chuyển hướng về trang Login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()), // Quay lại trang login
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng ký thành công')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi đăng ký tài khoản: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng ký'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Họ và tên'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập họ và tên';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập mật khẩu của bạn';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Email không hợp lệ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Số điện thoại'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số điện thoại';
                    }
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Số điện thoại không hợp lệ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passController,
                   decoration: InputDecoration(labelText: 'Mật khẩu'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length <=6) {
                      return 'Mật khẩu không hợp lệ';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Địa chỉ'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập địa chỉ của bạn';
                    }
                    return null;
                  },
                ),
                // Dropdown cho tỉnh thành
                DropdownButtonFormField<String>(
                  value: _selectedProvince,
                  items: provinces.map((province) {
                    return DropdownMenuItem<String>(
                      value: province,
                      child: Text(province),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProvince = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Chọn tỉnh thành'),
                ),
                // Dropdown cho vai trò
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  items: ['Patient', 'Doctor'].map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Đăng ký với tư cách'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registerUser,
                  child: Text('Đăng ký'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
