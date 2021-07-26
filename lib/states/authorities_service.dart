import 'package:flutter/material.dart';
import 'package:saraburialro/utility/my_constant.dart';
import 'package:saraburialro/widgets/show_signout.dart';
import 'package:saraburialro/bodys/show_authorities.dart';
import 'package:saraburialro/states/create_point.dart';
import 'package:saraburialro/states/creact_request.dart';
import 'package:saraburialro/states/my_service.dart';
import 'package:saraburialro/widgets/show_title.dart';


class AuthoritiesService extends StatefulWidget {
  const AuthoritiesService({Key? key}) : super(key: key);

  @override
  _AuthoritiesServiceState createState() => _AuthoritiesServiceState();
}

class _AuthoritiesServiceState extends State<AuthoritiesService> {
  List<Widget> widgets = [
    ShowAuthorities(),
    ShowAuthorities(),
    ShowAuthorities(),
  ];
  int indexWidget = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('เจ้าหน้าที่ ส.ป.ก.'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              children: [
                showHead(),
                menuCheckPlang(),
                menuShopMaps(),
                menuShowRequest(),
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

  ListTile menuCheckPlang() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 0;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePoint()),
          );
        });
      },
      leading: Icon(Icons.filter_1),
      title: ShowTitle(
        title: 'ตรวจแปลง',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
          title: 'การตรวจแปลงที่ดิน', textStyle: MyConstant().h3Style()),
    );
  }

  ListTile menuShopMaps() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 1;
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyService()),
          );
        });
      },
      leading: Icon(Icons.filter_2),
      title: ShowTitle(
        title: 'แสดงแผนที่',
        textStyle: MyConstant().h2Style(),
      ),
      subtitle: ShowTitle(
          title: 'แสดงรายละเอียดแผนที่', textStyle: MyConstant().h3Style()),
    );
  }

  ListTile menuShowRequest() {
    return ListTile(
      onTap: () {
        setState(() {
          indexWidget = 2;
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
}
