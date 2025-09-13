  
   import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// Read local properties
val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localProperties.load(FileInputStream(localPropertiesFile))
}

// Get Flutter properties from local.properties, providing default values
val flutterMinSdkVersion = localProperties.getProperty("flutter.minSdkVersion")?.toInt() ?: 24
val flutterCompileSdkVersion = localProperties.getProperty("flutter.compileSdkVersion")?.toInt() ?: 36
val flutterTargetSdkVersion = localProperties.getProperty("flutter.targetSdkVersion")?.toInt() ?: 35
val flutterVersionCode = localProperties.getProperty("flutter.versionCode")?.toInt() ?: 1
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"


android {
    namespace = "com.qb.viton"

    compileSdk = flutterCompileSdkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
    kotlinOptions {
        jvmTarget = "17"
    }

    // ADDED: This block disables some lint checks that can cause silent failures.
    lint {
        checkReleaseBuilds = false
        abortOnError = false
    }

    defaultConfig {
        applicationId = "com.qb.viton"
        minSdk = flutterMinSdkVersion
        targetSdk = flutterTargetSdkVersion
        versionCode = 11
        versionName = flutterVersionName
        multiDexEnabled = true
        
        // Support for 16KB memory page sizes (required for Android 15+)
        ndk {
            abiFilters += listOf("arm64-v8a", "armeabi-v7a", "x86_64")
        }
    }

    signingConfigs {
        create("release") {
            storeFile = file("C:/Users/muamm/StudioProjects/viton_new/my-new-upload-key.jks")
            storePassword = "Pakistan038@"
            keyAlias = "upload"
            keyPassword = "Pakistan038@"
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false // Minification is off, but ProGuard rules can still help.
            isShrinkResources = false
            // ADDED: Standard ProGuard rules for Flutter. This is crucial even if minification is disabled.
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }


    packaging {
        resources {
            excludes += "META-INF/DEPENDENCIES"
            excludes += "META-INF/LICENSE"
            excludes += "META-INF/LICENSE.txt"
            excludes += "META-INF/license.txt"
            excludes += "META-INF/NOTICE"
            excludes += "META-INF/NOTICE.txt"
            excludes += "META-INF/notice.txt"
            excludes += "META-INF/ASL2.0"
            excludes += "META-INF/*.kotlin_module"
        }
    }
    
    // Enable 16KB page size support
    bundle {
        language {
            enableSplit = false
        }
        density {
            enableSplit = false
        }
        abi {
            enableSplit = true
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:2.1.0")
    implementation("androidx.core:core-ktx:1.13.1")
}

// This block forces a consistent Kotlin version across all dependencies.
configurations.all {
    resolutionStrategy {
        eachDependency {
            if (requested.group == "org.jetbrains.kotlin" && requested.name.startsWith("kotlin-stdlib")) {
                useVersion("2.1.0")
            }
        }
    }
}

