import 'package:toikhoe/database/connection.dart';
import 'package:mysql1/mysql1.dart';
import 'package:toikhoe/model/bacsi_model.dart';

Future<List<BacsiProfile>> profileBS(List<BacsiProfile> allDoc) async{
  final MySqlConnection? conn = await connectToRDS();
  if(conn!=null){
    final result = await conn.query('Select * from Chien');
    for(var field in result){
      BacsiProfile currDoc = BacsiProfile('Id', 'hoten', 'chuyenmon', 0);
      currDoc.Id = field['ID'];
      currDoc.hoten = field['hoTen'];
      currDoc.chuyenmon = field['chuyenMon'];
      currDoc.exp = field['soNamKinhNghiem'];
      allDoc.add(currDoc);
    }
    conn.close();
  }
  return allDoc;
}