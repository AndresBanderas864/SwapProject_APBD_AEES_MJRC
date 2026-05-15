# Stack Tecnológico

> Documentación interna - No compartir públicamente

SWAP es una aplicación **100% móvil** desarrollada con Flutter, con Firebase como plataforma de backend y persistencia en la nube.

## Flutter – Frontend móvil

Flutter es el framework principal de desarrollo. Permite construir aplicaciones nativas para Android desde una única base de código en Dart.

| Aspecto | Detalle |
|---------|---------|
| **Lenguaje** | Dart |
| **Versión objetivo** | Flutter 3.x (stable) |
| **Plataforma** | Android (3G/4G) |
| **Arquitectura UI** | Widget tree con separación de capas (UI / lógica / datos) |

### Paquetes clave de Flutter

| Paquete | Uso |
|---------|-----|
| `firebase_core` | Inicialización de Firebase en Flutter |
| `firebase_auth` | Autenticación con correo y contraseña |
| `cloud_firestore` | Lectura y escritura en la base de datos remota |
| `http` | Consumo de la API REST |
| `provider` | Gestión de estado global de la app |
| `go_router` | Navegación declarativa entre pantallas |
| `flutter_secure_storage` | Almacenamiento seguro de tokens |

## Firebase – Backend y base de datos

| Servicio | Uso en SWAP |
|----------|-------------|
| **Firebase Auth** | Registro e inicio de sesión, validación de dominio `@uan.edu.co` |
| **Cloud Firestore** | Almacenamiento de usuarios, artículos y publicaciones en la nube |
| **Cloudinary** *(Could Have)* | Imágenes de los artículos |

## Gestión de Estado

Se utilizará **Provider** como solución de gestión de estado por su simpleza y compatibilidad con proyectos de escala universitaria. El estado global incluye:
- Sesión del usuario
- Lista de artículos
- Resultados de búsqueda