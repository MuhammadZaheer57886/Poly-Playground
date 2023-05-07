import '../../common/store.dart';

class AppStrings {
  static AppStrings i = AppStrings();



  get appName => "Poly Playground";
  get welcomeMsg =>
      "By clicking Log In, you agree with our Terms. Learn how we process your data in our Privacy Policy and Cookies Policy.";
  get signUp => "SignUp";
  get email => "Login with Email";
  get emailTxt => "Email";
  get phoneNumberTxt => "Phone number";
  get pass => "Password";
  get confirmPass => "Conform the password";
  get google => "Login with Google";
  get facebook => "Login with Facebook";
  get phoneNumber => "Login with Phone ";
  get doNotHaveAnAccount => "Don't have an account?";
  get paymentComment => "By tapping “Continue”. you agree to our Terms and your Apple ID will be charged. Your subscription will automatically renew at the same price and package length until you cancel in your App Store account.";
  get appId => "poly_playground";
  get appDescription => "Dating Application for Polyamorous People";

  get serverKey => "AAAA0tAQQ0E:APA91bHLglpArpGyG7Gr6wlD4XL905YPYhwplJU6aCyK25TEVHvMGOAe8PZxk2yktfajTuxW2jLeAR0n065UwlY5OIWbROPSpsRG1ak16Cuh5xIrRZoaJ3rAKFhOjUed3CYdiwydXOXp";

  get notificationSound  => "Tri-tone";

  get messageNotificationTitle   => "New Message";
  get messageNotificationBody => "You got a new message from ${Store().userData.name}";

  get friendRequestNotificationTitle => "Friend Request";
  get friendRequestNotificationBody => "${Store().userData.name} sent you a friend request";

  get canselFriendRequestNotificationTitle => "Request Canceled";
  get cancelFriendRequestNotificationBody => "${Store().userData.name} canceled the friend request";

  get friendRequestAcceptedNotificationTitle => "Request Accepted";
  get friendRequestAcceptedNotificationBody => "${Store().userData.name} accepted your friend request";

  get friendRequestRejectedNotificationTitle => "Request Rejected";
  get friendRequestRejectedNotificationBody => "${Store().userData.name} rejected your friend request";

  get noInternet => "Something went wrong please try again ";

  get fillAll  => "Please fill all the fields";



}
