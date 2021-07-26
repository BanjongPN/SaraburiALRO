import 'package:flutter/material.dart';

import 'package:saraburialro/bodys/show_manage.dart';

import 'package:saraburialro/utility/my_constant.dart';
import 'package:saraburialro/widgets/show_signout.dart';
import 'package:saraburialro/widgets/show_title.dart';

class ManageService extends StatefulWidget {
  const ManageService({Key? key}) : super(key: key);

  @override
  _ManageServiceState createState() => _ManageServiceState();
}

class _ManageServiceState extends State<ManageService> {
  List<Widget> widgets = [
    ShowManage(),
    ShowManage(),
    ShowManage(),
  ];
  int indexWidget = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สมาชิกผู้ดูแลระบบ'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                showHead(),
                menuShowOrder(),
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
  ListTile menuShowOrder() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.pop(context);
        });
      },
      leading: Icon(Icons.filter_1),
      title: ShowTitle(
        title: 'ข้อมูลสมาชิก',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
          title: 'ตรวจสอบข้อมูลสมาชิก', textStyle: MyConstant().h3Style()),
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
        title: 'ติดตามผลงาน',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
          title: 'แสดงรายละเอียดรายการผลงาน',
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
