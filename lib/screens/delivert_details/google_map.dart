import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/provider/check_out_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class CustomGoogleMap extends StatefulWidget {


  @override
  _CustomGoogleMapState createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {

  LatLng _initialCameraPosition =  LatLng(20.5937, 78.9629);

  GoogleMapController controller;
   Location _location = Location();
  void _onMapCreated(GoogleMapController _value){
    controller = _value;
    _location.onLocationChanged.listen((event) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(event.latitude, event.longitude),
          zoom: 15,
      ),
      ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider = Provider.of(context);
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.0,
      //   centerTitle: true,
      //   iconTheme: IconThemeData(color: Colors.black),
      //   backgroundColor: primaryColor,
      //   title: Text('Google Map',
      //     style: TextStyle(
      //         color: Colors.black
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: _initialCameraPosition,
                  ),
                mapType: MapType.normal,
                onMapCreated:_onMapCreated,
                myLocationEnabled: true,
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 40, 60, 40),
                    height: 45,
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: ()async{
                        await _location.getLocation().then((value) {
                          setState(() {
                            checkOutProvider.setLocation = value;
                          });
                        });
                        Navigator.of(context).pop();
                      },
                      color: Colors.grey[200],
                      child: Text('Set Location',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      ),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
