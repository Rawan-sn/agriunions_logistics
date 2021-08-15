import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';

class MapScreenDeparture extends StatefulWidget {
  final LatLng? departure;

  const MapScreenDeparture({this.departure});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreenDeparture> {
  var _initialPos, _kMapCenter;
  late GoogleMapController _gController;
  Marker? origin;

  @override
  void initState() {
    _kMapCenter = widget.departure;
    _initialPos =
        CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      origin = Marker(
        markerId: MarkerId("origin"),
        infoWindow:
            InfoWindow(title: AppLocalizations.of(context)!.trans("departure")),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: widget.departure!,
      );
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _gController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialPos,
            onMapCreated: (controller) => _gController = controller,
            markers: {
              if (origin != null) origin!,
            },
          ),
          Positioned(child: Container())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _gController.animateCamera(
          CameraUpdate.newCameraPosition(_initialPos),
        ),
        child: Icon(Icons.center_focus_strong),
      ),
    );
  }
}
