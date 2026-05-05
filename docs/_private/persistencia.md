# Persistencia de Datos

> Documentación interna - No compartir públicamente

SWAP usa una **estrategía híbrida de persistencia**, combinando almacenamiento local en el dispositivo con Firebase como fuente de verdad en la nube.

```
┌──────────────────────────────────────────────────┐
│                  App Flutter                      │
│                                                  │
│  ┌─────────────────┐    ┌──────────────────────┐ │
│  │  Datos Locales  │    │   Firebase (Nube)    │ │
│  │                 │    │                      │ │
│  │ SecureStorage   │    │ Cloud Firestore       │ │
│  │ (token/sesión)  │    │ Firebase Auth         │ │
│  └────────┬────────┘    └──────────┬───────────┘ │
│           │                        │             │
│           └──────── Repository ────┘             │
└──────────────────────────────────────────────────┘
```

## Métodos de persistencia local

| Mecanismo | Paquete | Qué almacena |
|-----------|---------|--------------|
| **Secure Storage** | `flutter_secure_storage` | Token de sesión, credenciales cifradas |

## Firebase (remoto)

### Colecciones Firestore

| Colección Firestore | Contenido |
|--------------------|-----------|
| `usuarios` | Perfil, correo, teléfono |
| `articulos` | Nombre, descripción, precio, estado, contacto |
| `publicaciones` | Relación usuario → artículo, fecha, estado activo |

## Estrategia de sincronización

- Todos los datos de artículos y usuarios se leen directamente desde **Firestore** en tiempo real.
- Las acciones de escritura (publicar, editar, eliminar) van directo a **Firestore**.
- La sesión del usuario se mantiene localmente de forma segura con **SecureStorage** para no requerir login en cada apertura.