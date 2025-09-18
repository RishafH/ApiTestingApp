
plugins {
    id("com.android.application") version "8.7.0" apply false
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
    id("com.google.gms.google-services") version "4.3.15" apply false
}
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}


buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Add Google Services plugin classpath
        classpath("com.google.gms:google-services:4.3.15") // ✅ Firebase
    }
}
val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
