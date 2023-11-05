import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pet_health_app/models/geometry.dart';
import 'package:pet_health_app/models/location.dart';
import 'package:pet_health_app/models/place.dart';
import 'package:pet_health_app/models/place_search.dart';
import 'package:pet_health_app/services/geolocator_service.dart';
import 'package:pet_health_app/services/marker_service.dart';
import 'package:pet_health_app/services/places_service.dart';

class ApplicationBlock with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();
  // variables
  Position? currentLocation;
  List<PlaceSearch>? searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>();
  StreamController<LatLngBounds> bounds = StreamController<LatLngBounds>();
  Place? selectedLocationStatic;
  String? placeType;
  List<Marker> markers = <Marker>[];

  List<Place>? placeResults;

  ApplicationBlock() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    selectedLocationStatic = Place(
      name: null,
      geometry: Geometry(
        location: Location(
            lat: currentLocation!.latitude, lng: currentLocation!.longitude),
      ),
    );
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutoComplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    //selectedLocation.add(await placesService.getPlace(placeId));
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults = null;
    notifyListeners();
  }

  clearSelectedLocation() {
    selectedLocation.add(Place(
        geometry: Geometry(location: Location(lat: 0, lng: 0)), name: null));
    selectedLocationStatic = null;
    searchResults = null;
    placeType = null;
    notifyListeners();
  }

  togglePlaceType(String value, bool selected) async {
    if (selected) {
      placeType = value;
    } else {
      placeType = null;
    }
    if (placeType != null) {
      var places = await placesService.getPlaces(
          selectedLocationStatic!.geometry.location.lat,
          selectedLocationStatic!.geometry.location.lng,
          placeType!);
      markers = [];
      if (places.length > 0) {
        var newMarker = markerService.createMarkerFromPlace(places[0], false);
        markers.add(newMarker);
      }

      var locationMarker =
          markerService.createMarkerFromPlace(selectedLocationStatic!, true);
      markers.add(locationMarker);

      var _bounds = markerService.bounds(Set<Marker>.of(markers));
      bounds.add(_bounds!);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    selectedLocation.close();
    bounds.close();
    super.dispose();
  }
}
