// class UsersFs {
//   static final auth = FirebaseAuth.instance;
//   static final uid = auth.currentUser.uid;
//   static final store = FirebaseFirestore.instance.collection('Users');

//   static Future<User> registerUser(UserDetails userDetails, context) async {
//     UserCredential userCred;
//     userCred = await auth.createUserWithEmailAndPassword(
//         email: userDetails.email, password: userDetails.id);
//     appState.uid = userCred.user.uid;
//     if (userCred != null) {
//       try {
//         await createUser(
//             UserDetails(email: userCred.user.email, id: userCred.user.uid),
//             context);
//       } catch (e) {
//         print(e);
//       }
//     }
//     return userCred.user;
//   }

//   static Future<UserDetails> createUser(UserDetails details, context) async {
//     try {
//       final userDetails = UserDetails(
//           name: details.name ?? 'Hello there!',
//           email: details.email,
//           phone: details.phone ?? '',
//           addressId: '',
//           addresses: [],
//           favourites: [],
//           recents: [],
//           imageUrl: '',
//           id: details.id);
//       await store.doc(userDetails.id).set(userDetails.toJson());
//       final saver = await SharedPreferences.getInstance();
//       saver.setString('name', userDetails.name);
//       saver.setString('email', userDetails.email);
//       saver.setString('phone', userDetails.email);
//       saver.setString('address', userDetails.addressId);
//       saver.setString('image', userDetails.imageUrl);
//       BlocProvider.of<UserDetailsCubit>(context).updateUserDetails(userDetails);
//       return userDetails;
//     } catch (err) {
//       print(err);

//       throw err.code;
//     }
//   }

//   static Future<bool> updateAddress(AddressDetails details) async {
//     try {
//       details.id = store.doc().id;
//       await store.doc(uid).set({
//         'addresses': FieldValue.arrayUnion([details.toJson()])
//       }, SetOptions(merge: true));
//       return true;
//     } catch (err) {
//       print(err);
//       throw err.code;
//     }
//   }

//   static Future<bool> updateDetails(Map<String, dynamic> details) async {
//     try {
//       await store.doc(uid).set(details, SetOptions(merge: true));
//       return true;
//     } catch (err) {
//       print(err);
//       throw err.code;
//     }
//   }

//   static Future<bool> deleteAddress(AddressDetails details) async {
//     print(details.toJson());
//     try {
//       await store.doc(uid).set({
//         'addresses': FieldValue.arrayRemove([details.toJson()])
//       }, SetOptions(merge: true));
//       return true;
//     } catch (err) {
//       print(err);
//       throw err.code;
//     }
//   }

//   static Future<String> signInUser(UserAuthM userAuthM, context) async {
//     try {
//       UserCredential credential = await auth.signInWithEmailAndPassword(
//           email: userAuthM.email, password: userAuthM.password);
//       appState.uid = credential.user.uid;
//       return 'success';
//     } catch (err) {
//       print(err.code);
//       switch (err.code) {
//         case 'wrong-password':
//           return 'invalid';
//         case 'user-not-found':
//           return 'notFound';
//         default:
//           return 'Dontknow';
//       }
//     }
//   }

//   static Future<bool> updateUser(UserDetails userDetails) async {
//     final save = await SharedPreferences.getInstance();
//     try {
//       await store.doc(uid).set(userDetails.toJson(), SetOptions(merge: true));
//       save.setString('phone', userDetails.phone);
//       save.setString('name', userDetails.name);
//       save.setString('image', userDetails.imageUrl);
//       return true;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   static Future<UserDetails> getUser(context) async {
//     try {
//       DocumentSnapshot data = await store.doc(uid).get();
//       UserDetails userDetails = UserDetails.fromJson(data.data());
//       final save = await SharedPreferences.getInstance();
//       appState.name = userDetails.name;
//       save.setString('name', userDetails.name);
//       save.setString('email', userDetails.email);
//       save.setString('phone', userDetails.phone);
//       save.setString('image', userDetails.imageUrl);
//       BlocProvider.of<UserDetailsCubit>(context).updateUserDetails(userDetails);
//       return userDetails;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }

//   static Stream<DocumentSnapshot> getUserDetailsST() async* {
//     try {
//       yield* store.doc(uid).snapshots();
//     } catch (e) {
//       throw e;
//     }
//   }

//   static userLogout() async {
//     await FirebaseAuth.instance.signOut();
//     final saver = await SharedPreferences.getInstance();
//     saver.clear();
//   }
// }
