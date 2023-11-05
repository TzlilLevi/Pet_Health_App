import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_health_app/blocks/application_block.dart';
import 'package:pet_health_app/models/place.dart';
import 'package:provider/provider.dart';

class Professionals extends StatefulWidget {
  const Professionals({Key? key}) : super(key: key);

  @override
  _ProfessionalsState createState() => _ProfessionalsState();
}

class _ProfessionalsState extends State<Professionals> {
  Completer<GoogleMapController> _mapContoller = Completer();
  late StreamSubscription locationSubscription;
  late StreamSubscription boundsSubscription;

  final _locationController = TextEditingController();
  @override
  void initState() {
    final applicationBlock =
        Provider.of<ApplicationBlock>(context, listen: false);
    locationSubscription =
        applicationBlock.selectedLocation.stream.listen((place) {
      if (place != null) {
        _locationController.text = place.name!;
        _goToPlace(place);
      } else
        _locationController.text = "";
    });

    applicationBlock.bounds.stream.listen((bounds) async {
      final GoogleMapController controller = await _mapContoller.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
    });

    super.initState();
  }

  @override
  void dispose() {
    print("Linoy print: ");
    print(context);
    final applicationBlock =
        Provider.of<ApplicationBlock>(context, listen: false);
    print("Linoy print 2: ");
    print(context);
    applicationBlock.dispose();
    _locationController.dispose();
    locationSubscription.cancel();
    boundsSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBlock = Provider.of<ApplicationBlock>(context);

    return Scaffold(
      body: (applicationBlock.currentLocation == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _locationController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      hintText: 'Search Location',
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) => applicationBlock.searchPlaces(value),
                    onTap: () => applicationBlock.clearSelectedLocation(),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 300.0,
                      child: GoogleMap(
                        mapType: MapType.normal,

                        // markers: Set<Marker>.of(applicationBlock.markers),
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                applicationBlock.currentLocation!.latitude,
                                applicationBlock.currentLocation!.longitude),
                            zoom: 14),
                        onMapCreated: (GoogleMapController controller) {
                          _mapContoller.complete(controller);
                        },
                        markers: Set<Marker>.of(applicationBlock.markers),
                      ),
                    ),
                    if (applicationBlock.searchResults != null &&
                        applicationBlock.searchResults!.length != 0)
                      Container(
                        height: 300.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            backgroundBlendMode: BlendMode.darken),
                      ),
                    if (applicationBlock.searchResults != null &&
                        applicationBlock.searchResults!.length != 0)
                      Container(
                          height: 300.0,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(.6),
                              backgroundBlendMode: BlendMode.darken)),
                    if (applicationBlock.searchResults != null)
                      Container(
                        height: 300.0,
                        child: ListView.builder(
                          itemCount:
                              applicationBlock.searchResults?.length ?? 0,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                applicationBlock
                                    .searchResults![index].description,
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                applicationBlock.setSelectedLocation(
                                    applicationBlock
                                        .searchResults![index].placeId);
                              },
                            );
                          },
                        ),
                      )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Find Nearest Profesionals',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8.0,
                    children: [
                      FilterChip(
                        label: Text('Veterinary Care'),
                        onSelected: (val) => applicationBlock.togglePlaceType(
                            'veterinary_care', val),
                        selected:
                            applicationBlock.placeType == 'veterinary_care',
                        selectedColor: Colors.blueAccent,
                      ),
                      FilterChip(
                        label: Text('Pet store'),
                        onSelected: (val) =>
                            applicationBlock.togglePlaceType('pet_store', val),
                        selected: applicationBlock.placeType == 'pet_store',
                        selectedColor: Colors.blueAccent,
                      ),
                      FilterChip(
                        label: Text('Park for Walk'),
                        onSelected: (val) =>
                            applicationBlock.togglePlaceType('park', val),
                        selected: applicationBlock.placeType == 'park',
                        selectedColor: Colors.blueAccent,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapContoller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target:
            LatLng(place.geometry.location.lat, place.geometry.location.lng),
        zoom: 14.0)));
  }
}
