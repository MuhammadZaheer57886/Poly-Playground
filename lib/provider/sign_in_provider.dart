import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInProvider extends ChangeNotifier{

  //instance of fire base auth google and facebook
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
// haserror ,errorcode ,provider,uid ,email ,name ,photoUrl
bool _hasError = false;
bool get hasError => _hasError;

String? _errorCode;
String? get errorCode => _errorCode;
String? _provider;
String? get provider => _provider;
String? _uid;
String? get uid => _uid;
String? _email;
String? get email => _email;
String? _name;
String? get name => _name;
String? _photoUrl;
String? get photoUrl => _photoUrl;



  SignInProvider(){
  checkSignInUser();  
  }
  Future checkSignInUser() async{
      final SharedPreferences s = await SharedPreferences.getInstance();

      _isSignedIn = s.getBool('isSignIn') ?? false;
      notifyListeners();
    }

  Future setSignIn() async{
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool('SignedIn', true);
    _isSignedIn = true;
    notifyListeners();
  }  
  // signin with google
  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      // executeing our authentication
      try{
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
         );
         //sign in with firebase user instance
         final userDetail = (await firebaseAuth.signInWithCredential(credential)).user!;
         // save users all the values
          _provider = 'Google*';
          _uid = userDetail.uid;
          _email = userDetail.email;
          _name = userDetail.displayName;
          _photoUrl = userDetail.photoURL; 
        notifyListeners();

      }on FirebaseAuthException catch(e){
          switch(e.code){
          case"account-exists-with-different-credential":
            _errorCode = "You have already account with us.Use correct provider";
            _hasError = true;
            notifyListeners();
            break;
          case"null":
            _errorCode = "unexpected error occured please try to sign in again";
            _hasError = true;
            notifyListeners();
            break;
          default:
            _errorCode = e.code;
            _hasError = true;
            notifyListeners();
          }
      }
    } else {
      _hasError = true;
      // _errorCode = 'Error';
      notifyListeners();
    }
  }

//entry for cloud store
Future getUserDataFromFireStore(String? uid) async{
  await FirebaseFirestore.instance
  .collection('users')
  .doc(_uid)
  .get()
  .then((DocumentSnapshot snapshot)=>{
    _uid = snapshot.get('uid'),
    _email = snapshot.get('email'),
    _name = snapshot.get('name'),
    _photoUrl = snapshot.get('photoUrl'),
    _provider = snapshot.get('provider'),
  });
}

// save user data to cloud firestore
Future saveUserDataToFireStore() async{
  final DocumentReference r= 
     FirebaseFirestore.instance.collection('users').doc(_uid);
      await r.set({
        'uid':_uid,
        'email':_email,
        'name':_name,
        'photoUrl':_photoUrl,
        'provider':_provider,
      });
    notifyListeners();
}

Future<void> saveDataToSharedPref() async{
  final SharedPreferences s = await SharedPreferences.getInstance();
  await s.setBool('isSignIn', true);
  await s.setString('uid', _uid!);
  await s.setString('email', _email!);
  await s.setString('name', _name!);
  await s.setString('photoUrl', _photoUrl!);
  await s.setString('provider', _provider!);
  notifyListeners();

}
Future getDataFromSharedPreferences() async{
  final SharedPreferences s = await SharedPreferences.getInstance();
  _uid = s.getString('uid');
  _email = s.getString('email');
  _name = s.getString('name');
  _photoUrl = s.getString('photoUrl');
  _provider = s.getString('provider');
  notifyListeners();
}


      //google sign out 
    Future<void> signOutGoogle() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
    _isSignedIn = false;
    notifyListeners();
    // clear all stored data
    clearStoredData();

    }
    // check if user exist in cloud firebase or not
    Future<bool> checkUserExist() async{
      DocumentSnapshot snap = 
      await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if(snap.exists){
        print("user exist");
        return true;
      }else{ 
        print("New user");
        return false;
      }
    }

    // clean data 
  Future clearStoredData() async{
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.clear();
  }  
}