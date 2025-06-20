# === ML Kit Text Recognition - Prevent R8 from removing classes ===
-keep class com.google.mlkit.vision.text.** { *; }
-dontwarn com.google.mlkit.vision.text.**
