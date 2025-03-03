# Melindungi class, method, dan resource penting
-keep class gov.bdg.epenting.** { *; }
-keep class gov.bdg.epenting.models.** { *; }

# Menjaga class penting
-keep public class * extends android.app.Application
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends androidx.lifecycle.ViewModel
-keep public class * extends androidx.lifecycle.LiveData

# Obfuscate semua class, kecuali yang dibutuhkan
-keepclassmembers class ** {
    @android.webkit.JavascriptInterface <methods>;
}

-keepclassmembers class * {
    public void *(java.lang.String, java.lang.Class[]);
}

# Jaga semua metode native (untuk library dengan JNI)
-keepclasseswithmembernames class * {
    native <methods>;
}

# Jangan obfuscate class tertentu
-dontwarn android.support.**
-dontwarn androidx.**

# Konfigurasi ProGuard Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep public class * extends io.flutter.embedding.android.FlutterActivity
-keep public class * extends io.flutter.embedding.android.FlutterFragmentActivity
-dontwarn io.flutter.embedding.**

# Jangan hapus library dependencies
-dontwarn **.R
-dontwarn com.google.**
-keep class com.google.** { *; }

-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** w(...);
    public static *** v(...);
    public static *** i(...);
}

# Firebase Rules
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**
-dontwarn io.grpc.**

# Firebase Cloud Messaging
-keep class com.google.firebase.messaging.** { *; }
-keep class com.google.firebase.iid.** { *; }
-keep class com.google.firebase.components.ComponentRegistrar { *; }
-keep class com.google.firebase.provider.FirebaseInitProvider { *; }

# Menjaga annotations
# -keep @interface com.google.android.gms.maps.**

# Menjaga class Google Maps
# -keep class com.google.android.gms.maps.** { *; }
# -keep interface com.google.android.gms.maps.** { *; }

# Menjaga class Google Maps Flutter
# -keep class io.flutter.plugins.googlemaps.** { *; }

# Menjaga metadata Google Maps
# -keep public class com.google.android.gms.maps.MapsInitializer { *; }

# Menjaga class Google Play Services
-keep class com.google.android.gms.common.** { *; }
-keep interface com.google.android.gms.common.** { *; }

# Menjaga Parcelable classes
-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Menjaga metode native
-keep class com.google.maps.android.** { *; }

# WorkManager (digunakan oleh background notification)
-keep class androidx.work.impl.background.systemjob.SystemJobService { *; }
-keep class androidx.work.impl.background.systemalarm.RescheduleReceiver { *; }

# Keep all notification-related classes
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# OkHttp, Dio and related classes Rules
-dontwarn okhttp3.**
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-keep enum okhttp3.** { *; }
-dontwarn okhttp3.**
-keep class okio.** { *; }
-dontwarn okio.**
-keep class com.github.ihsanbal.logging.** { *; }
-dontwarn com.github.ihsanbal.logging.*

# Preserve resource files (like .env)
-keep class **.R$* {
    *;
}

# Prevent issues with internationalization
-keep class java.util.** { *; }
-keep class org.intellij.lang.annotations.** { *; }
-dontwarn org.intellij.lang.annotations.**

# Preserve Flutter Secure Storage and Android Keystore classes
-keep class io.flutter.plugins.fluttersecurestorage.** { *; }
-keep class androidx.security.crypto.** { *; }
-keepclassmembers class androidx.security.crypto.** { *; }

# Prevent removing Keystore-related methods
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}

# Flutter SVG library
-keep class com.bumptech.glide.** { *; }
-dontwarn com.bumptech.glide.**
-keep class com.caverock.androidsvg.** { *; }
-dontwarn com.caverock.androidsvg.**
## Keep SplitCompat classes
#-keep public class com.google.android.play.core.splitcompat.SplitCompatApplication { *; }
#-keep class com.google.android.play.core.** { *; }
#-dontwarn com.google.android.play.core.**

## Abaikan peringatan terkait ErrorProne annotations
#-dontwarn com.google.errorprone.annotations.**
#-keep class com.google.errorprone.annotations.** { *; }
#
## Hindari penghapusan kode terkait KeysetManager dan InsecureSecretKeyAccess
#-keep class com.google.crypto.tink.** { *; }