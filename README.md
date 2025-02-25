# Blog App - Frontend Flutter

Este es el frontend en Flutter para la aplicación móvil Blog App, que permite a los usuarios registrarse, iniciar sesión y crear publicaciones con texto e imágenes.

## Instalación y Configuración

### Requisitos
- Flutter SDK 3.5.3 o superior
- Dispositivo/emulador configurado

### Instalación
1. Clonar el repositorio.
2. Ejecutar el siguiente comando para instalar las dependencias:
   ```sh
   flutter pub get
   ```

### Configuración

#### Archivo `lib/constants.dart`
Modifica el archivo `lib/constants.dart` con la dirección IP local del servidor Laravel:

```dart
const baseURL = 'http://TU-IP:8000/api';
const loginURL = '$baseURL/login';
const registerURL = '$baseURL/register';
const logoutURL = '$baseURL/logout';
const userURL = '$baseURL/user';
const postsURL = '$baseURL/posts';
const commentsURL = '$baseURL/comments';

// ----- Errors -----
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';
```

Para Android, asegúrate de ejecutar Laravel con la IP de tu máquina y conectar el dispositivo a la misma red:
```sh
php artisan serve --host=TU-IP --port=8000
```

## Configuración para Android

Editar `android/app/build.gradle`:
```gradle
defaultConfig {
    applicationId = "com.example.blog_app_mobile"
    minSdk = 21
    targetSdk = 30
    versionCode = flutter.versionCode
    versionName = flutter.versionName
}
```

Editar `android/app/src/main/AndroidManifest.xml` para agregar permisos:
```xml
<uses-permission android:name="android.permission.INTERNET" />

<activity
    android:usesCleartextTraffic="true"
    android:requestLegacyExternalStorage="true">
</activity>
```

## Configuración para iOS

Editar `ios/Podfile`:
```ruby
platform :ios, '12.0'
```

Editar `ios/Runner/Info.plist` para agregar permisos:
```xml
<dict>
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true />
    </dict>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>Esta aplicación necesita acceso a la galería para subir imágenes.</string>
    <key>NSCameraUsageDescription</key>
    <string>Esta aplicación necesita acceso a la cámara para tomar fotos.</string>
    <key>NSPhotoLibraryAddUsageDescription</key>
    <string>Esta aplicación necesita acceso para guardar imágenes en la galería.</string>
</dict>
```

## Dependencias

El archivo `pubspec.yaml` debe incluir las siguientes dependencias:
```yaml
name: blog_app_mobile
description: "A new Flutter project."
publish_to: 'none'
version: 0.1.0

environment:
  sdk: ^3.5.3

dependencies:
  flutter:
    sdk: flutter
  http: ^1.3.0
  image_picker: ^1.1.2
  shared_preferences: ^2.5.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0

flutter:
  uses-material-design: true
```

---

Con esto, tu aplicación Flutter estará correctamente configurada para interactuar con el backend Laravel. 🚀

## Repositorio del Backend
Puedes acceder al repositorio del backend Laravel en el siguiente enlace:
[Blog App - Backend](https://github.com/JoseGitUt/blog_app_laravel)

