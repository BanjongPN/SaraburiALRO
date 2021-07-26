import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saraburialro/utility/my_constant.dart';
import 'package:saraburialro/utility/my_dialog.dart';
import 'package:saraburialro/widgets/show_image.dart';
import 'package:saraburialro/widgets/show_progress.dart';
import 'package:saraburialro/widgets/show_title.dart';
import 'package:saraburialro/models/point_model.dart';

class AddPoint extends StatefulWidget {
  const AddPoint({Key? key}) : super(key: key);

  @override
  _AddPointState createState() => _AddPointState();
}

class _AddPointState extends State<AddPoint> {
  List<PointModel> pointModels = [];
  Map<MarkerId, Marker> markers = {};
  String? typeUser;
  String avatar = '';
  File? file;
  double? lat, lng;
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkPermission();
    readAllData();
  }
  void addMarker(LatLng latLng, String idMarker, String title, String snippet) {
    MarkerId markerId = MarkerId(idMarker);
    Marker marker = Marker(
      markerId: markerId,
      position: latLng,
      infoWindow: InfoWindow(title: title, snippet: snippet),
    );
    markers[markerId] = marker;
  }
  Future<Null> readAllData() async {
    String api = '${MyConstant.domain}/alro_sb/getAllPoint.php?isAdd=true';
    await Dio().get(api).then((value) {
      for (var item in json.decode(value.data)) {
        PointModel pointModel = PointModel.fromMap(item);

        addMarker(
          LatLng(double.parse(pointModel.lat), double.parse(pointModel.lng)),
          'id${pointModel.id}',
          pointModel.name,
          pointModel.address + ' โทร.' + pointModel.phone,
        );

        setState(() {
          pointModels.add(pointModel);
        });
      }
    });
  }
  Future<Null> editAndRefresh() async {
    Navigator.pop(context);
  }

  Future<Null> checkPermission() async {
    bool locationService;
    LocationPermission locationPermission;

    locationService = await Geolocator.isLocationServiceEnabled();
    if (locationService) {
      print('Service Location Open');

      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // Find LatLang
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          MyDialog().alertLocationService(
              context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        } else {
          // Find LatLng
          findLatLng();
        }
      }
    } else {
      print('Service Location Close');
      MyDialog().alertLocationService(context, 'Location Service ปิดอยู่ ?',
          'กรุณาเปิด Location Service ด้วย');
    }
  }

  Future<Null> findLatLng() async {
    print('findLatLan ==> Work');
    Position? position = await findPostion();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      print('lat = $lat, lng = $lng');
    });
  }

  Future<Position?> findPostion() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก ชื่อผู้ถือครองที่ดิน';
              } else {
                return null;
              }
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'ชื่อผู้ถือครอง :',
              prefixIcon: Icon(
                Icons.fingerprint,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row builPhone(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก หมายเลขโทรศัพท์';
              } else {}
            },
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'โทรศัพท์ :',
              prefixIcon: Icon(
                Icons.phone,
                color: MyConstant.dark,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

   Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.6,
          child: TextFormField(
            controller: addressController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณากรอก รายละเอียด';
              } else {}
            },
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'รายละเอียด :',
              hintStyle: MyConstant().h3Style(),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Icon(
                  Icons.home,
                  color: MyConstant.dark,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          buildCreateNewPoint(),
        ],
        title: Text('ตรวจแปลงที่ดินเอกชน'),
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildTitle('ข้อมูลบุคคล :'),
                buildName(size),
                buildTitle('ข้อมูลพื้นฐาน'),
                buildAddress(size),
                builPhone(size),
              //  buildTitle('รูปภาพ'),
              //  buildSubTitle(),
              //  buildAvatar(size),
                buildTitle('แสดงพิกัดแผนที่'),
                buildMap(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildCreateNewPoint() {
    return IconButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          if (typeUser == 'banjong') {
            print('Non Choose Type User');
            MyDialog().normalDialog(context, 'ยังไม่ได้เลือก ชนิดของ User',
                'กรุณา Tap ที่ ชนิดของ User ที่ต้องการ');
          } else {
            print('Process Insert to Database');
            uploadPictureAndInsertData();
          }
        }
      },
      icon: Icon(Icons.save),
    );
  }

  Future<Null> uploadPictureAndInsertData() async {
    String name = nameController.text;
    String address = addressController.text;
    String phone = phoneController.text;
    print(
        '## name = $name, address = $address, phone = $phone');

        if (file == null) {
          // No Avatar
          processInsertMySQL(
            name: name,
            address: address,
            phone: phone,
          );
        } else {
          // Have Avatar
          print('### process Upload Avatar');
          String apiSaveAvatar =
              '${MyConstant.domain}/alro_sb/saveFileLands.php';
          int i = Random().nextInt(100000);
          String nameAvatar = 'lands$i.jpg';
          Map<String, dynamic> map = Map();
          map['file'] =
              await MultipartFile.fromFile(file!.path, filename: nameAvatar);
          FormData data = FormData.fromMap(map);
          await Dio().post(apiSaveAvatar, data: data).then((value) {
            avatar = '/saraburialro/Lands/$nameAvatar';
            processInsertMySQL(
              name: name,
              address: address,
              phone: phone,
            );
          });
        }
       // MyDialog().normalDialog(context, 'User False ?', 'Please Change User');
  }

  Future<Null> processInsertMySQL(
      {String? name,
      String? address,
      String? phone}) async {
    print('### processInsertMySQL Work and Lands ==>> $avatar');
    String apiInsertPoint =
        '${MyConstant.domain}/alro_sb/insertPoint.php?isAdd=true&name=$name&address=$address&phone=$phone&lat=$lat&lng=$lng';
    await Dio().get(apiInsertPoint).then((value) {
      if (value.toString() == 'true') {
        Navigator.pop(context);
      } else {
        MyDialog().normalDialog(
            context, 'ไม่สามารถบันทึกข้อมูลได้ !!!', 'กรุณาลองอีกครั้ง');
      }
    });
  }

  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('id'),
          position: LatLng(lat!, lng!),
          infoWindow: InfoWindow(
              title: 'คุณอยู่ที่นี่', snippet: 'Lat = $lat, lng = $lng'),
        ),
      ].toSet();

  Widget buildMap() => Container(
        width: double.infinity,
        height: 500,
        child: lat == null
            ? ShowProgress()
            : GoogleMap(
              mapType: MapType.hybrid,
              myLocationEnabled: true,              
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!),
                  zoom: 9,
                ),
                onMapCreated: (controller) {},
        markers: Set<Marker>.of(markers.values),          
 //               markers: setMarker(),
              ),
      );

  Future<Null> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );
      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Row buildAvatar(double size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => chooseImage(ImageSource.camera),
          icon: Icon(
            Icons.add_a_photo,
            size: 36,
            color: MyConstant.dark,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.6,
          child: file == null
              ? ShowImage(path: MyConstant.avatar)
              : Image.file(file!),
        ),
        IconButton(
          onPressed: () => chooseImage(ImageSource.gallery),
          icon: Icon(
            Icons.add_photo_alternate,
            size: 36,
            color: MyConstant.dark,
          ),
        ),
      ],
    );
  }

  ShowTitle buildSubTitle() {
    return ShowTitle(
      title:
          'รูปภาพบริเวณแปลงที่ดิน หรือ รูปเกษตรกรที่ทำประโยชน์ในที่ดิน (แต่ถ้าไม่ สะดวกแชร์ เราจะแสดงภาพ default แทน)',
      textStyle: MyConstant().h3Style(),
    );
  }

    Container buildTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }
}
