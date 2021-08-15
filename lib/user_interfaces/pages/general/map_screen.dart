import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';

import 'package:agriunions_logistics/models/dicections_model.dart';
import 'package:agriunions_logistics/providers/api_directions_repository.dart';

class MapScreen extends StatefulWidget {
  final LatLng? departurePos;
  final LatLng? destinationPos;
  const MapScreen({
    this.departurePos,
    this.destinationPos,
  });
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late var _initialPos;
  late GoogleMapController _gController;
  Marker? origin;
  Marker? destination;
  DirectionsModel? _info;
  @override
  void initState() {
    ApiDirectionsRepository(context)
        .getDirections(
            origin: widget.departurePos!, destination: widget.destinationPos!)
        .then((directions) => setState(() => _info = directions));

    _initialPos = CameraPosition(
      target: LatLng(
        (widget.departurePos!.latitude + widget.destinationPos!.latitude) / 2,
        (widget.departurePos!.longitude + widget.destinationPos!.longitude) / 2,
      ),
      zoom: 6,
    );
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      origin = Marker(
        markerId: MarkerId("origin"),
        infoWindow:
            InfoWindow(title: AppLocalizations.of(context)!.trans("departure")),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: widget.departurePos!,
      );
      destination = Marker(
        markerId: MarkerId("destination"),
        infoWindow: InfoWindow(
            title: AppLocalizations.of(context)!.trans("destination")),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: widget.destinationPos!,
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
              if (destination != null) destination!
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: PolylineId("polylineId"),
                  color: Colors.red,
                  width: 5,
                  points: _info!.polylinePoints!
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
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
