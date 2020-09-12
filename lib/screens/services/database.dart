import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daniela_store/models/brews.dart';
import 'package:daniela_store/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

  Future updateUserDataWithUserData(UserData userdata) async {
    return await brewCollection.document(uid).setData({
      'sugars': userdata.sugars,
      'name': userdata.name,
      'strength': userdata.strength
    });
  }

//brew list from snapshot
  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot) {
    List<Brew> listResult = List<Brew>();
    for (var doc in snapshot.documents) {
      Brew b = Brew(
          name: doc.data['name'] ?? '',
          sugars: doc.data['sugars'] ?? '0',
          strength: doc.data['strength'] ?? 0);
      listResult.add(b);
    }
    return listResult;
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }

//userData from snapshot
  UserData _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

  //get user doc stream
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapShot);
  }
}
