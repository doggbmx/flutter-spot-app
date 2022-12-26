import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:secret_project/side_bar.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Position _currentPosition;
  MapController? controller;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  initState() {
    super.initState();
    _getCurrentPosition();
    controller = MapController();
  }

  @override
  Widget build(BuildContext context) {
    var marker = <Marker>[];

    marker = [
      Marker(
        point: LatLng(-25.300923539330743, -57.580828308014055),
        builder: (context) => const Icon(
          Icons.gpp_bad,
          color: Colors.blue,
          size: 30,
        ),
      ),
      Marker(
        point: LatLng(-25.302030585157677, -57.55924576414993),
        builder: (context) => const Icon(
          Icons.wallet,
          color: Colors.red,
          size: 30,
        ),
      ),
      Marker(
        point: LatLng(-25.294685685868085, -57.57737932703449),
        builder: (context) => const Icon(
          Icons.stairs,
          color: Colors.green,
          size: 30,
        ),
      ),
      Marker(
        point: LatLng(-25.294685685868085, -57.57737932703449),
        builder: (context) => const Icon(
          Icons.stairs,
          color: Colors.green,
          size: 30,
        ),
      ),
    ];

    return Scaffold(
        drawer: const SideBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => log('asd'),
          child: const Icon(Icons.location_searching_rounded),
        ),
        appBar: AppBar(
          elevation: 25,
          shadowColor: Colors.purpleAccent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: const Alignment(0, 0),
                child: const SizedBox(
                  // width: double.infinity,
                  child: Text('Baratapp para vagos', textAlign: TextAlign.end),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                    center: LatLng(
                        _currentPosition.latitude, _currentPosition.longitude),
                    // LatLng(-25.294685685868085, -57.57737932703449),
                    zoom: 14),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: const ['a', 'b', 'c'],
                    // backgroundColor: Colors.transparent,
                  ),
                  MarkerLayer(
                    markers: marker,
                  )
                ],
              ),
            )
          ]),
        ));
  }
}
