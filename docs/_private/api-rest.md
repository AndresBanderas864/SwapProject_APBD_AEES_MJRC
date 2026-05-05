# API REST

> Documentación interna - No compartir públicamente

SWAP se comunica con Firebase a través de sus SDKs nativos, pero también expone una capa de servicio interna organizada como **API REST conceptual** para estructurar claramente la interacción entre la app y el backend.

## Estructura de Respuestas

```json
{
  "status": "success" | "error",
  "data": { ... },
  "message": "Descripción del resultado"
}
```

## Endpoints

### Autenticación

| Método | Endpoint | Descripción | Auth requerida |
|--------|----------|-------------|----------------|
| `POST` | `/auth/register` | Registro con correo `@uan.edu.co` y contraseña | ❌ |
| `POST` | `/auth/login` | Inicio de sesión, retorna token | ❌ |
| `POST` | `/auth/logout` | Cierre de sesión | ✅ |

### Artículos

| Método | Endpoint | Descripción | Auth requerida |
|--------|----------|-------------|----------------|
| `GET` | `/articulos` | Lista todos los artículos disponibles | ❌ |
| `GET` | `/articulos/{id}` | Detalle de un artículo específico | ❌ |
| `GET` | `/articulos?q={termino}` | Búsqueda por nombre o palabra clave | ❌ |
| `POST` | `/articulos` | Publica un nuevo artículo | ✅ |
| `PUT` | `/articulos/{id}` | Edita descripción o precio de un artículo | ✅ |
| `PATCH` | `/articulos/{id}/estado` | Cambia estado a `disponible` o `vendido` | ✅ |
| `DELETE` | `/articulos/{id}` | Elimina una publicación | ✅ |

### Usuarios

| Método | Endpoint | Descripción | Auth requerida |
|--------|----------|-------------|----------------|
| `GET` | `/usuarios/{id}/contacto` | Obtiene el contacto del vendedor | ❌ |
| `GET` | `/usuarios/{id}/articulos` | Lista los artículos de un usuario | ✅ |

## Ejemplo de Respuesta - GET /articulos/{id}

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