import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class themBenhAnScreen extends StatefulWidget {
  const themBenhAnScreen({super.key});

  @override
  _themBenhAnScreenState createState() => _themBenhAnScreenState();
}

class _themBenhAnScreenState extends State<themBenhAnScreen> {
  final _formKey = GlobalKey<FormState>();
  String _gender = 'Nam';
  DateTime _ngayNhapVienDate = DateTime.now();
  DateTime _ngayRaVienDate = DateTime.now();
  DateTime _ngaySinhDate = DateTime.now();
  File? _image;

  TextEditingController _tenController = TextEditingController();
  TextEditingController _danTocController = TextEditingController();
  TextEditingController _soNhaController = TextEditingController();
  TextEditingController _thonPhoController = TextEditingController();
  TextEditingController _xaPhuongController = TextEditingController();
  TextEditingController _huyenController = TextEditingController();
  TextEditingController _tinhThanhPhoController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _chanDoanVaoVienController = TextEditingController();
  TextEditingController _chanDoanRaVienController = TextEditingController();
  TextEditingController _liDoVaoVienController = TextEditingController();
  TextEditingController _tomTatQuaTrinhBenhLyController =
      TextEditingController();

  TextEditingController _soTheBHYTController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  // Optional: Focus Nodes to manage focus
  final FocusNode _tenFocusNode = FocusNode();
  final FocusNode _danTocFocusNode = FocusNode();

  @override
  void dispose() {
    _tenController.dispose();
    _danTocController.dispose();
    _tenFocusNode.dispose();
    _danTocFocusNode.dispose();
    super.dispose();
  }

  // Calculate Age from birth date
  int _calculateAge(DateTime birthDate) {
    final DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    print(today.year);
    print(birthDate.year);

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    void _showErrorDialog(BuildContext context, String errorMessage) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

    // Định dạng ngày nhập viện và ngày sinh
    String formattedNgayNhapVienDate =
        DateFormat('dd/MM/yyyy').format(_ngayNhapVienDate);
    String formattedBirthDate = DateFormat('dd/MM/yyyy').format(_ngaySinhDate);
    String formattedNgayRaVienDate =
        DateFormat('dd/MM/yyyy').format(_ngayRaVienDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Bệnh Án'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Heading "I. Hành Chính"
                const Text(
                  'I. Hành Chính',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                // Trường tải ảnh
                GestureDetector(
                  onTap: () async {
                    final XFile? pickedImage =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      setState(() {
                        _image = File(pickedImage.path);
                      });
                    }
                  },
                  child: Container(
                    padding:
                        EdgeInsets.all(16.0), // Padding inside the container
                    decoration: BoxDecoration(
                      color: Colors.grey[
                          200], // Background color for the image picker area
                      borderRadius:
                          BorderRadius.circular(8.0), // Rounded corners
                      border: Border.all(
                          color: Colors.grey,
                          width: 2), // Border around the container
                    ),
                    height: 200, // Set a fixed height
                    width: double.infinity, // Take up full width
                    child: _image == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 60,
                                color: Colors.grey[600], // Color for the icon
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Ảnh bệnh nhân',
                                style: TextStyle(
                                  color: Colors.grey[600], // Text color
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.w500, // Slightly bolder text
                                ),
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(
                                8.0), // Rounded corners for the image
                            child: Image.file(
                              _image!,
                              fit: BoxFit
                                  .cover, // Crop the image to fill the container while maintaining its aspect ratio
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 16),

                // Tên bệnh nhân
                TextFormField(
                  controller: _tenController,
                  decoration: InputDecoration(
                    labelText: 'Tên bệnh nhân',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên bệnh nhân';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-ZáéíóúàèìòùăâêôơưđñÁÉÍÓÚÀÈÌÒÙĂÂÊÔƠƯĐÑ]')),
                  ],
                ),

                SizedBox(height: 8),

                // Ngày sinh
                Row(
                  children: [
                    Text('Ngày sinh: $formattedBirthDate'),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _ngaySinhDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null && picked != _ngaySinhDate) {
                          setState(() {
                            _ngaySinhDate = picked;
                            _ageController.text =
                                _calculateAge(_ngaySinhDate).toString();
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // Tuổi
                Text(
                  'Tuổi: ${_ageController.text}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                // Giới tính
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: InputDecoration(
                    labelText: 'Giới tính',
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _gender = newValue!;
                    });
                  },
                  items: ['Nam', 'Nữ']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 8),

                // dân tộc
                TextFormField(
                  controller: _danTocController,
                  decoration: InputDecoration(
                    labelText: 'Dân tộc',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên dân tộc';
                    }
                    return null;
                  },

                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp('[a-zA-ZáéíóúàèìòùăâêôơưđñÁÉÍÓÚÀÈÌÒÙĂÂÊÔƠƯĐÑ]')),
                  ],
                ),
                SizedBox(height: 8),

                // số nhà
                TextFormField(
                    controller: _soNhaController,
                    decoration: InputDecoration(
                      labelText: 'Số nhà',
                    )),
                SizedBox(height: 8),

                // thôn phố
                TextFormField(
                  controller: _thonPhoController,
                  decoration: InputDecoration(
                    labelText: 'Thôn phố',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập thôn, phố';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),

                // xã phường
                TextFormField(
                  controller: _xaPhuongController,
                  decoration: InputDecoration(
                    labelText: 'Xã, phường',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên xã phường';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),

                // Huyện
                TextFormField(
                  controller: _huyenController,
                  decoration: InputDecoration(
                    labelText: 'Huyện',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên huyện';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),

                //Tỉnh thành phố
                TextFormField(
                  controller: _tinhThanhPhoController,
                  decoration: InputDecoration(
                    labelText: 'Tỉnh, thành phố',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên thành phố';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),

                // số thẻ BHYT
                TextFormField(
                  controller: _soTheBHYTController,
                  decoration: InputDecoration(
                    labelText: 'Số thẻ BHYT',
                  ),
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction, // Validate as user interacts
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập số BHYT';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Số BHYT phải là một số hợp lệ';
                    }
                    return null;
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]'), // This regex allows only digits (0-9)
                    ),
                  ],
                ),

                SizedBox(height: 8),

                // Ngày nhập viện
                Row(
                  children: [
                    Text('Ngày nhập viện: $formattedNgayNhapVienDate'),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _ngayNhapVienDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != _ngayNhapVienDate) {
                          setState(() {
                            _ngayNhapVienDate = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),

                // Ngày ra viện
                Row(
                  children: [
                    Text('Ngày ra viện: $formattedNgayRaVienDate'),
                    IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: _ngayRaVienDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null && picked != _ngayRaVienDate) {
                          setState(() {
                            _ngayRaVienDate = picked;
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Heading "I. Chẩn đoán"
                const Text(
                  'II. CHẨN ĐOÁN',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Chẩn đoán vào viện
                TextFormField(
                  controller: _chanDoanVaoVienController,
                  decoration: InputDecoration(
                    labelText: 'Chẩn đoán vào viện',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập chẩn đoán vào viện';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),

                // Chẩn đoán ra viện
                TextFormField(
                  controller: _chanDoanRaVienController,
                  decoration: InputDecoration(
                    labelText: 'Chẩn đoán ra viện',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập chẩn đoán ra viện';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),

                const Text(
                  'III. TÓM TẮT QUÁ TRÌNH ĐIỀU TRỊ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //lý do vào viện
                TextFormField(
                  controller: _liDoVaoVienController,
                  decoration: InputDecoration(
                    labelText: 'Lý do vào viện',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập lý do vào viện';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),

                //Lý do ra viện
                TextFormField(
                  controller: _tomTatQuaTrinhBenhLyController,
                  decoration: InputDecoration(
                    labelText:
                        'Tóm tắt quá trình bệnh lý và diễn biến lâm sàng',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8),

                // Nút gửi
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Lưu thông tin bệnh án
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Đã thêm bệnh án cho ${_tenController.text}')));
                      }
                    },
                    child: Text('Thêm bệnh án'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
