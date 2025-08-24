plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")            // ✅ use full id, not "kotlin-android"
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

android {
    namespace = "com.qb.viton"

    // ✅ Kotlin DSL needs Int
    compileSdk = flutter.compileSdkVersion.toInt()

    compileOptions {
        // ✅ AGP 8.7 requires JDK 17
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.qb.viton"

        // ✅ Kotlin DSL; use = and cast to Int
        minSdk = flutter.minSdkVersion.toInt()
        targetSdk = flutter.targetSdkVersion.toInt()

        versionCode = 8
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            storeFile = file("C:/Users/muamm/StudioProjects/viton_new/my-new-upload-key.jks")
            storePassword = "Pakistan038@"   // ⚠️ don’t commit these
            keyAlias = "upload"
            keyPassword = "Pakistan038@"     // ⚠️ seriously, don’t
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}

flutter {
    source = "../.."
}
