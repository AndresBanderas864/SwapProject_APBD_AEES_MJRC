# Instrucciones para descargar e iniciar SWAP

## Requisitos previos

| Herramienta | Versión | Descarga |
|-------------|---------|----------|
| **Flutter** | 3.29+ | https://docs.flutter.dev/get-started/install |
| **Dart** | 3.11+ (viene con Flutter) | — |
| **Git** | Cualquier versión | https://git-scm.com/downloads |
| **Editor** | VS Code o Android Studio | https://code.visualstudio.com/ |

## Pasos

### 1. Clonar el repositorio

```bash
git clone https://github.com/AndresBanderas864/SwapProject_APBD_AEES_MJRC.git
cd SwapProject_APBD_AEES_MJRC
```

### 2. Verificar que Flutter está instalado

```bash
flutter doctor
```

Debe mostrar un check (✓) en al menos **Flutter**, **Dart** y **Android Toolchain**. Si faltan componentes, sigue las instrucciones que te muestre.

### 3. Instalar dependencias

```bash
flutter pub get
```

Esto descarga los paquetes necesarios (cupertino_icons, flutter_lints, etc.).

### 4. Configurar Firebase (opcional por ahora)

El proyecto usa Firebase Auth y Cloud Firestore. Para que funcione:

1. Ve a https://console.firebase.google.com
2. Crea un proyecto o usa el existente
3. Agrega una app **Android** con el paquete `com.uan.swap.swap`
4. Descarga `google-services.json` y colócalo en `android/app/`
5. En la consola de Firebase, ve a **Authentication** > **Sign-in method** y habilita **Correo electrónico/contraseña**
6. Ve a **Cloud Firestore** > **Crear base de datos** (modo prueba)

### 5. Ejecutar en modo debug

Conecta un dispositivo Android por USB o inicia un emulador, luego:

```bash
flutter run
```

Para correr en web:

```bash
flutter run -d chrome
```

## Comandos útiles

| Comando | Qué hace |
|---------|----------|
| `flutter pub get` | Descarga dependencias |
| `flutter pub upgrade` | Actualiza dependencias |
| `flutter clean` | Limpia archivos de compilación |
| `flutter build apk` | Genera APK de producción |
| `flutter analyze` | Revisa errores en el código |

## Notas

- El `.gitignore` ya está configurado para ignorar `build/`, `.dart_tool/`, `.idea/`, etc.
- Si agregas una dependencia nueva en `pubspec.yaml`, ejecuta `flutter pub get` después.
