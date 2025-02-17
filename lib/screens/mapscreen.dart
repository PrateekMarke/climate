import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class Mapscreen extends StatefulWidget {
  const Mapscreen({super.key});

  @override
  State<Mapscreen> createState() => _MapscreenState();
}

class _MapscreenState extends State<Mapscreen> {
  final MapController _mapController = MapController();
  final Location _location = Location();
  final TextEditingController _locationController = TextEditingController();
  LatLng? _currentLocation;
  // LatLng? _destination;
  // List<LatLng> _route = [];

 @override
  void initState(){
    super.initState();
    
  _initializeLocation();

  }

  Future<void> _initializeLocation() async{
    _location.onLocationChanged.listen((LocationData locationData){
      if (locationData.latitude != null && locationData.longitude != null  ) {
        setState(() {
          _currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
        });
      }
    });
  }

  // Future<void> fetchCoordinatorPoint(String location) async {
  //   final url = Uri.parse();
  //   final response = await http.get(url);
  // }

  
  
  Future<void> _userCurrentLocation() async {
    setState(() {
      if (_currentLocation != null){
      _mapController.move(_currentLocation!, 100);

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Current location not available."),)
      );
    }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
           options:  MapOptions(
          initialCenter: _currentLocation ?? LatLng(20.5937, 78.9629 ),
          initialZoom: 5,
          minZoom: 0,
          maxZoom: 100,
        ),
            children: [TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            // maxZoom: 19,
          ),
          CurrentLocationLayer(
            style: const LocationMarkerStyle(
              marker: DefaultLocationMarker(
                child: Icon(
                  Icons.location_pin,
                  color: Colors.white,
                ),
              ),
              markerSize: Size(35, 35),
              markerDirection: MarkerDirection.heading,
            ),
          )
          ]
          ),
          Positioned(child: Padding(padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _locationController,
            
          ),
          )),
         
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Colors.amber,
        onPressed: _userCurrentLocation,
        child: const Icon(
          Icons.my_location,
          size:30,
          color: Colors.white
        )),



    );
  }
}





 // #Map
 //  flutter_map: 7.0.2
 //  geolocator: 13.0.2
 //  http: 1.3.0
 //  flutter_polyline_points: 2.1.0
 //  latlong2: 0.9.1
 //  flutter_map_location_marker: 9.1.1
 //  location: 8.0.0
// https://app.gomaps.pro/apis
