import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class HistoryRepo {
  Future<void> deleteOfferDetails(String sid, bool isPunch);
  Future<void> deleteUserDetails(String sid);
  Stream<QuerySnapshot> getPunches();
  Stream<QuerySnapshot> getCollectedPoints();
}

class HistoryApis extends HistoryRepo {
  final uid = FirebaseAuth.instance.currentUser.uid;
  final usersStore = FirebaseFirestore.instance.collection('users');
  final offersStore = FirebaseFirestore.instance.collection('stores');

  Future<void> deleteOfferDetails(String id, bool isPunch) async {
    print(id);
    print(isPunch);
    await usersStore
        .doc(uid)
        .collection((isPunch ? 'punches' : 'points'))
        .doc(id)
        .delete();
  }

  Future<void> deleteUserDetails(String id) async {
    print(id);
    await offersStore.doc(id).collection('user_data').doc(uid).delete();
  }

  Stream<QuerySnapshot> getPunches() async* {
    yield* usersStore
        .doc(uid)
        .collection('punches')
        .orderBy('date', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getCollectedPoints() async* {
    yield* usersStore
        .doc(uid)
        .collection('points')
        .orderBy('date', descending: true)
        .snapshots();
  }
}
