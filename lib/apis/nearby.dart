import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class NearByRepo {
  Stream<List<DocumentSnapshot>> getStores(LatLng currLocation);
  Stream<List<DocumentSnapshot>> getServices(LatLng currLocation);
  Future<DocumentSnapshot> getStoreByid(String sid);
  Stream<QuerySnapshot> getServicesBySid(String sid);
}

class NearByApis extends NearByRepo {
  final uid = FirebaseAuth.instance.currentUser.uid;
  final servicesStore = FirebaseFirestore.instance.collection('stores');
  final geo = Geoflutterfire();
  final radiusinKm = 4.0;

  Stream<List<DocumentSnapshot>> getStores(LatLng currLocation) async* {
    GeoFirePoint center = geo.point(
        latitude: currLocation.latitude, longitude: currLocation.longitude);
    yield* geo
        .collection(
            collectionRef: servicesStore.where('is_store', isNull: true))
        .within(
            center: center,
            radius: radiusinKm,
            field: 'location',
            strictMode: true);
  }

  Future<DocumentSnapshot> getStoreByid(String sid) async {
    return await servicesStore.doc(sid).get();
  }

  Stream<QuerySnapshot> getServicesBySid(String sid) async* {
    yield* servicesStore
        .where('sid', isEqualTo: sid)
        .orderBy('name')
        .snapshots();
  }

  Stream<List<DocumentSnapshot>> getServices(LatLng currLocation) async* {
    GeoFirePoint center = geo.point(
        latitude: currLocation.latitude, longitude: currLocation.longitude);
    yield* geo
        .collection(
            collectionRef: servicesStore.where('is_service', isNull: true))
        .within(
            center: center,
            radius: radiusinKm,
            field: 'location',
            strictMode: true);
  }
}
