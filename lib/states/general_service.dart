import 'package:flutter/material.dart';
//import 'package:saraburialro/bodys/show_general_request.dart';
import 'package:saraburialro/bodys/show_general.dart';
import 'package:saraburialro/utility/my_constant.dart';
import 'package:saraburialro/widgets/show_signout.dart';
import 'package:saraburialro/widgets/show_title.dart';
import 'package:saraburialro/states/creact_request.dart';

class GeneralService extends StatefulWidget {
  const GeneralService({Key? key}) : super(key: key);

  @override
  _GeneralServiceState createState() => _GeneralServiceState();
}

class _GeneralServiceState extends State<GeneralService> {
  List<Widget> widgets = [
    ShowGeneral(),
    ShowGeneral(),
    ShowGeneral(),
  ];
  int indexWidget = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สมาชิกทั่วไป'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                showHead(),
                menuShowRequest(),
                menuShopManage(),
                menuShowProduct(),
              ],
            ),
          ],
        ),
      ),
      body: widgets[indexWidget],
    );
  }
  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyConstant().myBoxDecoration('user.jpg'),
      currentAccountPicture: MyConstant().showLogo(),
      accountName: Text(
        'ส.ป.ก.สระบุรี',
        style: MyConstant().h3WhiteStyle(),
      ),
      accountEmail: Text(
        'ยินดีต้อนรับ',
        style: MyConstant().h2WhiteStyle(),
      ),
    );
  }

  ListTile menuShowRequest() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRequest()),
          );
        });
      },
      leading: Icon(Icons.filter_3),
      title: ShowTitle(
        title: 'บันทึกคำขอเกษตรกร',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
          title: 'ยื่นคำขอ "ออนไลน์" ส.ป.ก.สระบุรี',
          textStyle: MyConstant().h3Style()),
    );
  }

  ListTile menuShopManage() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_2),
      title: ShowTitle(
        title: 'รายการให้บริการ',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
          title: 'แสดงรายละเอียดรายการให้บริการ',
          textStyle: MyConstant().h3Style()),
    );
  }

  ListTile menuShowProduct() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 2;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_3),
      title: ShowTitle(
        title: 'ติดต่อสอบถาม',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
          title: 'แสดงรายละเอียดของการติดต่อสอบถาม',
          textStyle: MyConstant().h3Style()),
    );
  }
  
}
