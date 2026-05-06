# 🔄 SWAP
> Plataforma de compra, venta e intercambio de artículos entre estudiantes universitarios

---

## 📋 Tabla de Contenidos

- [Descripción](#descripción)
- [Problema que resuelve](#problema-que-resuelve)
- [Funcionalidades](#funcionalidades)
- [Historias de Usuario](#historias-de-usuario)
- [Requisitos No Funcionales](#requisitos-no-funcionales)
- [Stack Tecnológico](#stack-tecnológico)
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
**Para** concretas la compra

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

## 🛠️ Stack Tecnológico

SWAP es una aplicación móvil desarrollada con **Flutter** para Android, utilizando **Firebase** como plataforma de backend.

| Tecnología | Descripción |
|------------|------------|
| **Flutter** | Framework principal de desarrollo móvil |
| **Firebase Auth** | Sistema de autenticación |
| **Cloud Firestore** | Base de datos en la nube |
| **Provider** | Gestión de estado de la aplicación |

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
