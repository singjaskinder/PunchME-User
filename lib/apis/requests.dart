import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:punchme/models/requests_m.dart';

abstract class RequestsRepo {
  Future<void> create(RequestM requestM);
  Stream<DocumentSnapshot> getServiceDetails(String sid);
  Stream<QuerySnapshot> get();
}

class RequestsApis extends RequestsRepo {
  final uid = FirebaseAuth.instance.currentUser.uid;
  final requestsStore = FirebaseFirestore.instance.collection('requests');
  final servicesStore = FirebaseFirestore.instance.collection('stores');

  Future<void> create(RequestM requestM) async {
    requestM.id = requestsStore.doc().id;
    await requestsStore.doc(requestM.id).set(requestM.toJson());
  }

  Stream<DocumentSnapshot> getServiceDetails(String sid) async* {
    yield* servicesStore.doc(sid).collection('user_data').doc(uid).snapshots();
  }

  Stream<QuerySnapshot> get() async* {
    yield* requestsStore
        .orderBy('date', descending: true)
        .where('uid', isEqualTo: uid)
        .snapshots();
  }
}
