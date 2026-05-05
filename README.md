# 🔄 SWAP
> Plataforma de compra, venta e intercambio de artículos entre estudiantes universitarios

[![Estado](https://img.shields.io/badge/Estado-En%20Desarrollo-yellow)](https://github.com/)
[![Universidad](https://img.shields.io/badge/Universidad-Antonio%20Nariño-blue)](https://www.uan.edu.co/)
[![Plataforma](https://img.shields.io/badge/Plataforma-Android-green)](https://www.android.com/)
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-Firestore%20%2B%20Auth-FFCA28?logo=firebase)](https://firebase.google.com/)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart)](https://dart.dev/)

---

## 📋 Tabla de Contenidos

- [Descripción](#descripción)
- [Problema que resuelve](#problema-que-resuelve)
- [Funcionalidades](#funcionalidades)
- [Historias de Usuario](#historias-de-usuario)
- [Requisitos No Funcionales](#requisitos-no-funcionales)
- [Arquitectura y Diseño](#arquitectura-y-diseño)
- [Stack Tecnológico](#stack-tecnológico)
- [API REST](#api-rest)
- [Persistencia de Datos](#persistencia-de-datos)
- [Priorización MoSCoW](#priorización-moscow)
- [Equipo](#equipo)

---

## 📖 Descripción

**SWAP** es una plataforma móvil que facilita la **compra, venta e intercambio rápido y seguro de artículos** entre estudiantes de la Universidad Antonio Nariño. Pensada para reducir la acumulación de materiales de un solo uso y mejorar la economía estudiantil dentro de la misma comunidad universitaria.

---

## 🎯 Problema que resuelve

Los estudiantes universitarios enfrentan dificultades para:

- Comprar, vender e intercambiar artículos dentro de su comunidad universitaria.
- Generar confianza entre usuarios desconocidos.
- Coordinar entregas cercanas de forma eficiente.
- Aprovechar materiales que fueron utilizados una sola vez.

**SWAP** cubre estas necesidades creando un espacio seguro y exclusivo para la comunidad UAN.

---

## ⚙️ Funcionalidades

| # | Funcionalidad | Descripción |
|---|---------------|-------------|
| RF1 | Búsqueda de artículos | Búsqueda por nombre o palabras clave con coincidencias exactas o parciales |
| RF2 | Visualización de artículos | Nombre, descripción, precio y datos de contacto del vendedor |
| RF3 | Registro de usuario | Mediante correo institucional `@uan.edu.co` y contraseña |
| RF4 | Inicio de sesión | Autenticación para acceder a funcionalidades de vendedor |
| RF5 | Publicación de artículos | Los usuarios registrados pueden publicar artículos |
| RF6 | Edición de publicaciones | Modificar descripción y precio de publicaciones propias |
| RF7 | Eliminación de publicaciones | Eliminar publicaciones propias |
| RF8 | Listado de artículos | Visualizar todos los artículos disponibles |
| RF9 | Contacto con vendedor | Ver correo o teléfono del vendedor sin necesidad de iniciar sesión |
| RF10 | Cambio de estado | Marcar artículos como `disponible` o `vendido` |
| RF11 | Validación de formularios | Validación de formatos y restricciones en todos los formularios |

---

## 📖 Historias de Usuario

<details>
<summary><strong>HU1 – Búsqueda de artículos</strong> 🟩 Must Have</summary>

**Como** estudiante universitario  
**Quiero** buscar artículos por nombre o palabras clave  
**Para** encontrar rápidamente productos que necesito dentro de la universidad

**Criterios de aceptación:**
- Existe una barra de búsqueda funcional
- Se muestran resultados con coincidencias exactas o parciales
- Si no hay resultados, se muestra el mensaje: `ARTÍCULO NO ENCONTRADO`
</details>

<details>
<summary><strong>HU2 – Visualización de artículo</strong> 🟩 Must Have</summary>

**Como** estudiante universitario  
**Quiero** ver información detallada de un artículo  
**Para** asegurar que el producto cumple con mis necesidades

**Criterios de aceptación:**
- Se muestra descripción del producto
- Se muestra precio válido (mayor a 0)
- Se muestra al menos un medio de contacto (correo o teléfono)
- Se puede ver sin iniciar sesión
</details>

<details>
<summary><strong>HU3 – Registro de usuario</strong> 🟩 Must Have</summary>

**Como** estudiante  
**Quiero** crear una cuenta  
**Para** ingresar al sistema

**Criterios de aceptación:**
- El sistema solicita correo y contraseña
- El correo debe pertenecer al dominio `@uan.edu.co`
- Se valida contra una lista simulada de correos institucionales
</details>

<details>
<summary><strong>HU4 – Gestión de publicaciones</strong> 🟨 Should Have</summary>

**Como** estudiante con rol de vendedor  
**Quiero** gestionar mis publicaciones  
**Para** mantener la información actualizada

**Criterios de aceptación:**
- Puede modificar descripción y precio
- Puede cambiar el estado a `disponible` / `vendido`
- Puede eliminar sus publicaciones
</details>

<details>
<summary><strong>HU5 – Inicio de sesión</strong> 🟩 Must Have</summary>

**Como** usuario registrado  
**Quiero** iniciar sesión  
**Para** gestionar mis publicaciones

**Criterios de aceptación:**
- El sistema valida credenciales
- Permite acceso a funcionalidades de vendedor
- Muestra error si los datos son incorrectos
</details>

<details>
<summary><strong>HU6 – Contacto con vendedor</strong> 🟩 Must Have</summary>

**Como** comprador  
**Quiero** contactar al vendedor  
**Para** concretar la compra

**Criterios de aceptación:**
- Se muestra al menos un medio de contacto (correo o teléfono)
- No es obligatorio iniciar sesión
- El vendedor debe proporcionar al menos un medio de contacto válido
</details>

<details>
<summary><strong>HU7 – Publicación de artículos</strong> 🟩 Must Have</summary>

**Como** usuario registrado  
**Quiero** publicar artículos  
**Para** ofrecer productos a otros estudiantes

**Criterios de aceptación:**
- Se solicita nombre, descripción y precio
- El precio debe ser mayor a 0
- El artículo queda en estado `disponible`
</details>

---

## 🔧 Requisitos No Funcionales

### ⚡ Rendimiento
- Respuesta a búsquedas en máximo **3–5 segundos** bajo condiciones normales de conexión móvil.

### 📱 Usabilidad
- Interfaz intuitiva y optimizada para dispositivos móviles.
- Buen contraste de colores (UI/UX).
- Mensajes claros en caso de error o ausencia de resultados.

### 🔒 Seguridad
- Contraseñas almacenadas de forma **cifrada**.
- Validación de todos los datos ingresados por el usuario.
- Solo usuarios autenticados pueden publicar, editar o eliminar artículos.
- Validación de correo institucional `@uan.edu.co`.

### 📲 Compatibilidad
- Dispositivos móviles con sistema operativo **Android**.
- Redes **3G y 4G**.

> ⚠️ *El sistema utiliza correos institucionales como mecanismo de confianza; sin embargo, no garantiza la autenticidad total de los usuarios. Se recomienda precaución en transacciones.*

---

## 🏗️ Arquitectura y Diseño

### Conceptos Clave del Dominio
- `Usuario` → `Estudiante` (herencia)
- `Artículo`
- `Publicación`
- `Contacto`
- `Búsqueda`

### Flujo Principal
```
Usuario busca artículo → Sistema muestra lista → Usuario selecciona artículo
→ Ve información detallada → Contacta al vendedor
```

### Diagrama de Clases (Resumen)

| Clase | Atributos principales | Métodos principales |
|-------|-----------------------|---------------------|
| `Usuario` | nombre, contraseña, correo, telefono | `registrar()`, `iniciarSesion()` |
| `Publicacion` | id, fechaCreacion, activa | `publicar()`, `eliminar()` |
| `Articulo` | nombre, descripcion, precio, estado | `editar()`, `cambiarEstado()`, `esPrecioValido()` |
| `Busqueda` | termino, resultados | `buscarPorNombre()`, `buscarParcial()`, `sinResultados()` |
| `Contacto` | correoContacto, telefonoContacto | `getContacto()` |

### Actores del Sistema
- **Estudiante** – Usuario registrado con rol de comprador y/o vendedor
- **Usuario no registrado** – Puede buscar, ver artículos y contactar vendedores
- **Sistema** – Gestiona validaciones, sesiones y datos

---

## 🛠️ Stack Tecnológico

SWAP es una aplicación **100% móvil** desarrollada con Flutter, con Firebase como plataforma de backend y persistencia en la nube.

### 📱 Flutter – Frontend móvil

[Flutter](https://flutter.dev/) es el framework principal de desarrollo. Permite construir aplicaciones nativas para Android desde una única base de código en **Dart**.

| Aspecto | Detalle |
|---------|---------|
| **Lenguaje** | Dart |
| **Versión objetivo** | Flutter 3.x (stable) |
| **Plataforma** | Android (3G/4G) |
| **Arquitectura UI** | Widget tree con separación de capas (UI / lógica / datos) |

**Paquetes clave de Flutter:**

| Paquete | Uso |
|---------|-----|
| `firebase_core` | Inicialización de Firebase en Flutter |
| `firebase_auth` | Autenticación con correo y contraseña |
| `cloud_firestore` | Lectura y escritura en la base de datos remota |
| `http` | Consumo de la API REST |
| `provider` | Gestión de estado global de la app |
| `go_router` | Navegación declarativa entre pantallas |
| `flutter_secure_storage` | Almacenamiento seguro de tokens |

### 🔥 Firebase – Backend y base de datos

| Servicio | Uso en SWAP |
|----------|-------------|
| **Firebase Auth** | Registro e inicio de sesión, validación de dominio `@uan.edu.co` |
| **Cloud Firestore** | Almacenamiento de usuarios, artículos y publicaciones en la nube |
| **Firebase Storage** *(Could Have)* | Imágenes de los artículos |

### 🗂️ Gestión de Estado

Se utilizará **Provider** como solución de gestión de estado por su simpleza y compatibilidad con proyectos de escala universitaria. El estado global incluye: sesión del usuario, lista de artículos y resultados de búsqueda.

```
lib/
├── main.dart
├── models/          # Clases del dominio (Usuario, Articulo, Publicacion...)
├── providers/       # Estado global con Provider
├── services/        # Lógica de negocio, llamadas a API y Firebase
├── repositories/    # Abstracción de fuentes de datos (local vs remoto)
├── screens/         # Pantallas de la app
└── widgets/         # Componentes reutilizables de UI
```

---

## 🌐 API REST

SWAP se comunica con Firebase a través de sus SDKs nativos, pero también expone una capa de servicio interna organizada como **API REST conceptual** para estructurar claramente la interacción entre la app y el backend.

### ¿Cómo funciona la interacción?

```
┌─────────────────────────────────────────────┐
│              App Flutter (Cliente)           │
│                                             │
│  Pantalla → Provider → Service → Repository │
└──────────────────┬──────────────────────────┘
                   │  HTTP / Firebase SDK
         ┌─────────▼──────────┐
         │   Firebase / API   │
         │  Auth + Firestore  │
         └────────────────────┘
```

Cada acción del usuario (buscar, publicar, editar) pasa por la capa de **Service**, que decide si consulta el caché local o hace una llamada al backend. Las respuestas siguen una estructura JSON estándar:

```json
{
  "status": "success" | "error",
  "data": { ... },
  "message": "Descripción del resultado"
}
```

### 📌 Tabla de Endpoints

> Los endpoints reflejan la estructura lógica de la API. En Firebase se implementan como operaciones sobre colecciones de Firestore; si se usa un backend propio futuro, serían rutas HTTP reales.

#### 🔐 Autenticación

| Método | Endpoint | Descripción | Auth requerida |
|--------|----------|-------------|----------------|
| `POST` | `/auth/register` | Registro con correo `@uan.edu.co` y contraseña | ❌ |
| `POST` | `/auth/login` | Inicio de sesión, retorna token | ❌ |
| `POST` | `/auth/logout` | Cierre de sesión | ✅ |

#### 📦 Artículos

| Método | Endpoint | Descripción | Auth requerida |
|--------|----------|-------------|----------------|
| `GET` | `/articulos` | Lista todos los artículos disponibles | ❌ |
| `GET` | `/articulos/{id}` | Detalle de un artículo específico | ❌ |
| `GET` | `/articulos?q={termino}` | Búsqueda por nombre o palabra clave | ❌ |
| `POST` | `/articulos` | Publica un nuevo artículo | ✅ |
| `PUT` | `/articulos/{id}` | Edita descripción o precio de un artículo | ✅ |
| `PATCH` | `/articulos/{id}/estado` | Cambia estado a `disponible` o `vendido` | ✅ |
| `DELETE` | `/articulos/{id}` | Elimina una publicación | ✅ |

#### 👤 Usuarios

| Método | Endpoint | Descripción | Auth requerida |
|--------|----------|-------------|----------------|
| `GET` | `/usuarios/{id}/contacto` | Obtiene el contacto del vendedor | ❌ |
| `GET` | `/usuarios/{id}/articulos` | Lista los artículos de un usuario | ✅ |

### Ejemplo de respuesta – `GET /articulos/{id}`

```json
{
  "status": "success",
  "data": {
    "id": "abc123",
    "nombre": "Calculadora científica",
    "descripcion": "Casio FX-991, en buen estado",
    "precio": 45000,
    "estado": "disponible",
    "contacto": {
      "correo": "estudiante@uan.edu.co",
      "telefono": "3001234567"
    },
    "fechaCreacion": "2025-05-01T10:00:00Z"
  }
}
```

---

## 💾 Persistencia de Datos

SWAP usa una **estrategia híbrida de persistencia**, combinando almacenamiento local en el dispositivo con Firebase como fuente de verdad en la nube.

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

### Métodos de persistencia local

| Mecanismo | Paquete | Qué almacena |
|-----------|---------|--------------|
| **Secure Storage** | `flutter_secure_storage` | Token de sesión, credenciales cifradas |

### Firebase (remoto)

| Colección Firestore | Contenido |
|--------------------|-----------|
| `usuarios` | Perfil, correo, teléfono |
| `articulos` | Nombre, descripción, precio, estado, contacto |
| `publicaciones` | Relación usuario → artículo, fecha, estado activo |

### Estrategia de sincronización

- Todos los datos de artículos y usuarios se leen directamente desde **Firestore** en tiempo real.
- Las acciones de escritura (publicar, editar, eliminar) van directo a **Firestore**.
- La sesión del usuario se mantiene localmente de forma segura con **SecureStorage** para no requerir login en cada apertura.

---

## 📊 Priorización MoSCoW

| Prioridad | Funcionalidades |
|-----------|-----------------|
| 🟩 **Must Have** | Registro (HU3), Inicio de sesión (HU5), Publicación de artículos (HU7), Búsqueda (HU1), Visualización (HU2), Contacto con vendedor (HU6), Validación de formularios |
| 🟨 **Should Have** | Edición de publicaciones (HU4), Eliminación de publicaciones (HU4), Cambio de estado (RF10), Mensajes de error claros |
| 🟦 **Could Have** | Filtros avanzados por precio y categoría, Incorporación de ubicación automática |
| 🟥 **Won't Have** | Sistema de pagos integrado, Integración con otras universidades, Sistema de calificación por estrellas, Chat integrado, Notificaciones al vendedor |

---

## 👥 Equipo

| Nombre | Rol |
|--------|-----|
| Angel Esteven Espitia Salas | Diseñador |
| Jocsan Matias Rodriguez | Tester |
| Andres Paul Banderas Diaz | Desarrollador |

**Universidad Antonio Nariño** – Ingeniería de Sistemas

---

*SWAP – Compra, vende e intercambia dentro de tu comunidad universitaria* 🔄
