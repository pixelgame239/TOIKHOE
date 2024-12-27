import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String? selectedAddress;

  List<String> savedAddresses = [
    'Nhà riêng: 123/3 Nguyễn Trãi, Thanh Xuân, Hà Nội',
    'Nơi làm việc: 456/7 Lê Văn Lương, Cầu Giấy, Hà Nội',
  ];

  void _pickDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void _pickTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  void _addNewAddress() {
    TextEditingController addressController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thêm địa chỉ mới'),
        content: TextField(
          controller: addressController,
          decoration: InputDecoration(hintText: 'Nhập địa chỉ mới'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                savedAddresses.add(addressController.text);
              });
              Navigator.pop(context);
            },
            child: Text('Thêm'),
          ),
        ],
      ),
    );
  }

  void _editAddress(int index) {
    TextEditingController addressController =
    TextEditingController(text: savedAddresses[index]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sửa địa chỉ'),
        content: TextField(
          controller: addressController,
          decoration: InputDecoration(hintText: 'Chỉnh sửa địa chỉ'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                savedAddresses[index] = addressController.text;
              });
              Navigator.pop(context);
            },
            child: Text('Lưu'),
          ),
        ],
      ),
    );
  }

  void _deleteAddress(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xóa địa chỉ'),
        content: Text('Bạn có chắc chắn muốn xóa địa chỉ này không?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                savedAddresses.removeAt(index);
                if (selectedAddress == savedAddresses[index]) {
                  selectedAddress = null;
                }
              });
              Navigator.pop(context);
            },
            child: Text('Xóa'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đặt dịch vụ'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                'https://via.placeholder.com/400x200',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 16),
              Text(
                'Dịch vụ chăm sóc sức khỏe tại nhà',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text('Chọn lịch', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _pickDate,
                child: Text(selectedDate == null
                    ? 'Chọn ngày'
                    : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'),
              ),
              SizedBox(height: 16),
              Text('Chọn thời gian', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: _pickTime,
                child: Text(selectedTime == null
                    ? 'Chọn giờ'
                    : '${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}'),
              ),
              SizedBox(height: 16),
              Text('Chọn địa chỉ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Column(
                children: savedAddresses.asMap().entries.map((entry) {
                  int index = entry.key;
                  String address = entry.value;
                  return Row(
                    children: [
                      Expanded(
                        child: RadioListTile<String>(
                          title: Text(address),
                          value: address,
                          groupValue: selectedAddress,
                          onChanged: (value) {
                            setState(() {
                              selectedAddress = value;
                            });
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editAddress(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteAddress(index),
                      ),
                    ],
                  );
                }).toList(),
              ),
              TextButton(
                onPressed: _addNewAddress,
                child: Text('Thêm địa chỉ mới'),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Xử lý khi nhấn nút Hủy
                    },
                    child: Text('Hủy'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedDate != null &&
                          selectedTime != null &&
                          selectedAddress != null) {
                        String date =
                            '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}';
                        String time =
                            '${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}';
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              'Đã chọn: $date lúc $time, tại $selectedAddress'),
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Vui lòng chọn đầy đủ ngày, giờ và địa chỉ'),
                        ));
                      }
                    },
                    child: Text('Xác nhận'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
