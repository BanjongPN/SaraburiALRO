import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saraburialro/utility/my_constant.dart';
import 'package:saraburialro/models/point_model.dart';
import 'package:saraburialro/widgets/show_progress.dart';
import 'package:saraburialro/states/create_point.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  List<PointModel> pointModels = [];
  Map<MarkerId, Marker> markers = {};

  @override
  void initState() {
   
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แผนที่ ส.ป.ก.'),
        backgroundColor: MyConstant.primary,
      ),
      body: pointModels.length == 0 ? ShowProgress() : buildMap(),
      floatingActionButton: Wrap(
        children: [
          FloatingActionButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreatePoint()),
              ),
            },
            child: Icon(Icons.save),
          ),
          SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: () => {},
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }

  Widget buildMap() => GoogleMap(
        mapType: MapType.hybrid,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            double.parse(pointModels[0].lat),
            double.parse(pointModels[0].lng),
          ),
          zoom: 9,
        ),
        onMapCreated: (controller) {},
        markers: Set<Marker>.of(markers.values),
    
      );
}
