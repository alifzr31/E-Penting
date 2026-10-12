##############################################
## Project Package
##############################################
-keep class gov.bdg.epenting.** { *; }

##############################################
## Core Android Components
##############################################
-keep public class * extends android.app.Application
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends androidx.lifecycle.ViewModel
-keep public class * extends androidx.lifecycle.LiveData

##############################################
## Flutter Engine & Plugins
##############################################
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**

-keep class * extends io.flutter.embedding.android.FlutterActivity
-keep class * extends io.flutter.embedding.android.FlutterFragmentActivity

#############################################
# Firebase (Core, Messaging, Remote Config)
#############################################
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-dontwarn io.grpc.**

-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

##############################################
## Networking: Dio, OkHttp, Okio
##############################################
-keep class okhttp3.** { *; }
-keep interface okhttp3.**
-keep class okio.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**

-keep class com.github.ihsanbal.logging.** { *; }
-dontwarn com.github.ihsanbal.logging.**

##############################################
## Secure Storage & Keystore
##############################################
-keep class io.flutter.plugins.fluttersecurestorage.** { *; }
-keep class com.it_nomads.fluttersecurestorage.** { *; }
-keep class androidx.security.crypto.** { *; }
-keep class android.security.keystore.** { *; }
-keep class android.security.** { *; }

#############################################
# local_auth & biometric_storage
#############################################
-keep class io.flutter.plugins.localauth.** { *; }
-keep class androidx.biometric.** { *; }
-keep class design.codeux.biometric_storage.** { *; }

##############################################
## Shared Preferences
##############################################
-keep class io.flutter.plugins.sharedpreferences.** { *; }

#############################################
# flutter_local_notifications
#############################################
-keep class com.dexterous.flutterlocalnotifications.** { *; }

##############################################
## WebView (webview_flutter)
##############################################
-keep class android.webkit.WebView { *; }
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

##############################################
## Lottie
##############################################
-keep class com.airbnb.lottie.** { *; }
-dontwarn com.airbnb.lottie.**

##############################################
## flutter_svg
##############################################
-keep class com.caverock.androidsvg.** { *; }

##############################################
## Toastification
##############################################
-keep class com.toastification.** { *; }

##############################################
## URL Launcher
##############################################
-keep class io.flutter.plugins.urllauncher.** { *; }

##############################################
## Misc
##############################################
-keep class **.R$* { *; }
-dontwarn **.R

##############################################
## Remove debug log in release
##############################################
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** w(...);
    public static *** v(...);
    public static *** i(...);
}
