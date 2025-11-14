# Estructura de Ejercicios en Firebase

## Ejemplo de Ejercicio Multiple Choice

### Ruta en Firestore:
```
cursos/curso1/actividades/actividad1/ejercicios/ejercicio1
```

### Estructura del documento:

```json
{
  "enunciado": "¿Cuál es el lenguaje de programación más utilizado para desarrollo web?",
  "metadata": {
    "opciones": [
      "Python",
      "JavaScript",
      "C++",
      "Ruby"
    ],
    "respuesta": "JavaScript"
  },
  "orden": 1,
  "tipo": "multiple_choice"
}
```

## Otro ejemplo:

### Ruta:
```
cursos/curso1/actividades/actividad2/ejercicios/ejercicio1
```

### Documento:
```json
{
  "enunciado": "¿Qué significa HTML?",
  "metadata": {
    "opciones": [
      "Hyper Text Markup Language",
      "High Tech Modern Language",
      "Home Tool Markup Language",
      "Hyperlinks and Text Markup Language"
    ],
    "respuesta": "Hyper Text Markup Language"
  },
  "orden": 1,
  "tipo": "multiple_choice"
}
```

## Pasos para agregar ejercicios en Firebase Console:

1. Ve a Firestore Database
2. Navega a `cursos/curso1/actividades/actividad1`
3. Crea la subcolección `ejercicios`
4. Agrega el documento `ejercicio1` con los campos:
   - **enunciado** (string): La pregunta
   - **metadata** (map):
     - **opciones** (array): Lista de opciones
     - **respuesta** (string): La respuesta correcta (debe coincidir exactamente con una opción)
   - **orden** (number): Orden del ejercicio
   - **tipo** (string): "multiple_choice"

5. Repite para `actividad2`

## Funcionalidades implementadas:

✅ Usuario ve actividades en CourseDetailPage
✅ Click en actividad → navega a ActivityDetailPage
✅ ActivityDetailPage muestra lista de ejercicios
✅ Botón "Comenzar ejercicios" → navega a ExercisePage
✅ ExercisePage muestra ejercicios de tipo multiple choice
✅ Usuario selecciona respuesta y presiona "Comprobar"
✅ Muestra feedback visual (verde = correcto, rojo = incorrecto)
✅ Botón "Siguiente" para avanzar al siguiente ejercicio
✅ Al finalizar muestra diálogo con resultados (X de Y correctas)
✅ Calcula porcentaje y muestra mensaje según resultado
✅ Todo es responsive (tablet y phone)
