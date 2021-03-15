import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ServicesRepo {
  Stream<DocumentSnapshot> getDetails(String sid, String uid);
  Stream<QuerySnapshot> get();
}

class ServicesApis extends ServicesRepo {
  final servicesStore = FirebaseFirestore.instance.collection('stores');

  Stream<DocumentSnapshot> getDetails(String sid, String uid) async* {
    yield* servicesStore.doc(sid).collection('user_data').doc(uid).snapshots();
  }

  Stream<QuerySnapshot> get() async* {
    yield* servicesStore
        .orderBy('date', descending: true)
        .where('ban_for', isNull: true)
        .snapshots();
  }
}
