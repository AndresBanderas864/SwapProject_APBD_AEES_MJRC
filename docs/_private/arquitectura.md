# Arquitectura y Diseño

> Documentación interna - No compartir públicamente

## Conceptos Clave del Dominio

- `Usuario` → `Estudiante` (herencia)
- `Artículo`
- `Publicación`
- `Contacto`
- `Búsqueda`

## Flujo Principal

```
Usuario busca artículo → Sistema muestra lista → Usuario selecciona artículo
→ Ve información detallada → Contacta al vendedor
```

## Diagrama de Clases (Resumen)

| Clase | Atributos principales | Métodos principales |
|-------|-----------------------|---------------------|
| `Usuario` | nombre, contraseña, correo, telefono | `registrar()`, `iniciarSesion()` |
| `Publicacion` | id, fechaCreacion, activa | `publicar()`, `eliminar()` |
| `Articulo` | nombre, descripcion, precio, estado | `editar()`, `cambiarEstado()`, `esPrecioValido()` |
| `Busqueda` | termino, resultados | `buscarPorNombre()`, `buscarParcial()`, `sinResultados()` |
| `Contacto` | correoContacto, telefonoContacto | `getContacto()` |

## Actores del Sistema

- **Estudiante** – Usuario registrado con rol de comprador y/o vendedor
- **Usuario no registrado** – Puede buscar, ver artículos y contactar vendedores
- **Sistema** – Gestiona validaciones, sesiones y datos

## Estructura del Proyecto

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