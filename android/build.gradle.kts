// android/build.gradle.kts

plugins {
    // Updated to latest stable version for 16KB support
    id("com.android.application") version "8.6.0" apply false

    // Updated Kotlin version for compatibility
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
    id("com.google.gms.google-services") version "4.4.2" apply false
}

tasks.register("clean", Delete::class) {
    delete(rootProject.buildDir)
}