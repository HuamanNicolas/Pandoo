# Configuración de Firebase - Sistema de Cursos

## Estructura de la Base de Datos

### Colección: `cursos`

**Documento: `curso1`**
```json
{
  "estado": "activo",
  "imagen": "prog.png",
  "nombre": "Introduccion a la programacion",
  "orden": 1
}
```

#### Subcolección: `cursos/curso1/actividades`

**Documento: `actividad1`**
```json
{
  "nombre": "Primera actividad",
  "orden": 1
}
```

**Documento: `actividad2`**
```json
{
  "nombre": "Segunda actividad",
  "orden": 2
}
```

#### Subcolección: `cursos/curso1/actividades/actividad1/ejercicios`

**Documento: `ejercicio1`**
```json
{
  "titulo": "Ejercicio 1",
  "descripcion": "Descripción del ejercicio"
}
```

#### Subcolección: `cursos/curso1/actividades/actividad2/ejercicios`

**Documento: `ejercicio1`**
```json
{
  "titulo": "Ejercicio 1",
  "descripcion": "Descripción del ejercicio"
}
```

### Colección: `users/{userId}/cursos`

Cuando un usuario se suscribe a un curso, se crea automáticamente:

**Documento: `curso1`**
```json
{
  "progreso": 0,
  "actividadesRealizadas": []
}
```

## Pasos para configurar en Firebase Console

1. Ve a Firebase Console: https://console.firebase.google.com
2. Selecciona tu proyecto
3. Ve a Firestore Database
4. Crea la colección `cursos`
5. Agrega el documento `curso1` con los campos mencionados
6. Dentro de `curso1`, crea la subcolección `actividades`
7. Agrega `actividad1` y `actividad2` con sus campos
8. Para cada actividad, crea la subcolección `ejercicios` y agrega un ejercicio

## Assets necesarios

Asegúrate de tener la imagen en:
```
assets/images/prog.png
```

Si no tienes la imagen, el sistema mostrará un ícono de escuela por defecto.

## Funcionalidades implementadas

✅ HomePage carga el curso dinámicamente desde Firebase
✅ Al hacer click en el curso, navega a CourseDetailPage
✅ CourseDetailPage muestra:
  - Información del curso
  - Lista de actividades
  - Botón de suscripción
✅ Al suscribirse se crea el documento en `users/{userId}/cursos/{cursoId}`
✅ Si ya está suscrito, muestra mensaje confirmando la suscripción
✅ Todo es responsive (tablet y phone)
