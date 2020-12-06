// import 'package:flutter/material.dart';

// class MyMapsActivity extends StatefulWidget {
//   @override
//   _MyMapsActivityState createState() => _MyMapsActivityState();
// }

// class _MyMapsActivityState extends State<MyMapsActivity> {
//   Api key = AIzaSyBmkp-p00YJWkYo5h0Kk0AS3ROFZXrzhGQ  16.295221434517316, 80.44515895093205
//   AIzaSyBmkp-p00YJWkYo5h0Kk0AS3ROFZXrzhGQ

//   Completer<GoogleMapController> _mapcompleter = Completer();
//   static const LatLng _center = const LatLng(45.521563, -122.677433);
//   final Set<Marker> _markars = {};
//   LatLng _lastmapPosition = _center;
//   MapType _currentMaptype = MapType.normal;

//   _onMapCreated(GoogleMapController controller) {
//     _mapcompleter.complete(controller);
//   }

//   _onCameraMove(CameraPosition position) {
//     _lastmapPosition = position.target;
//   }

//   Widget button(Function function, IconData data) {
//     return FloatingActionButton(
//       onPressed: function,
//       materialTapTargetSize: MaterialTapTargetSize.padded,
//       backgroundColor: Colors.blue,
//       child: Icon(
//         data,
//         size: 36.0,
//       ),
//     );
//   }

//   _onMaptypeButtonPressed() {
//     setState(() {
//       _currentMaptype = _currentMaptype == MapType.normal
//           ? MapType.satellite
//           : MapType.normal;
//     });
//   }

//   _onAddMarkerButtonPressed() {
//     setState(() {
//       _markars..add(Marker(
//         markerId: MarkerId(_lastmapPosition.toString()),
//         position: _lastmapPosition,
//         infoWindow: InfoWindow(
//           title: 'This is A Title',
//           snippet: 'This is A snapshot'
//         ),
//         icon: BitmapDescriptor.defaultMarker,
//         )

//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Google Maps"),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(target: _center, zoom: 11.0),
//             mapType: _currentMaptype,
//             markers: _markars,
//             onCameraMove: _onCameraMove,
//           ),
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Align(
//               alignment: Alignment.topRight,
//               child: Column(
//                 children: [
//                   button(_onMaptypeButtonPressed, Icons.map),
//                   SizedBox(
//                     height: 15,
//                   ),
//                  // button(_onAddMarkerButtonPressed, Icons.add_location),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
