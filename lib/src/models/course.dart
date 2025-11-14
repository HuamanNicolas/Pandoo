class Course {
  final String id;
  final String nombre;
  final String imagen;
  final String estado;
  final int orden;

  Course({
    required this.id,
    required this.nombre,
    required this.imagen,
    required this.estado,
    required this.orden,
  });

  factory Course.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Course(
      id: documentId,
      nombre: data['nombre'] ?? '',
      imagen: data['imagen'] ?? '',
      estado: data['estado'] ?? 'activo',
      orden: data['orden'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'imagen': imagen,
      'estado': estado,
      'orden': orden,
    };
  }
}

class Actividad {
  final String id;
  final String nombre;
  final int orden;

  Actividad({
    required this.id,
    required this.nombre,
    required this.orden,
  });

  factory Actividad.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Actividad(
      id: documentId,
      nombre: data['nombre'] ?? '',
      orden: data['orden'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'orden': orden,
    };
  }
}

class Ejercicio {
  final String id;
  final String enunciado;
  final Map<String, dynamic> metadata;
  final int orden;
  final String tipo;

  Ejercicio({
    required this.id,
    required this.enunciado,
    required this.metadata,
    required this.orden,
    required this.tipo,
  });

  factory Ejercicio.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Ejercicio(
      id: documentId,
      enunciado: data['enunciado'] ?? '',
      metadata: Map<String, dynamic>.from(data['metadata'] ?? {}),
      orden: data['orden'] ?? 0,
      tipo: data['tipo'] ?? 'multiple_choice',
    );
  }

  List<String> get opciones {
    if (metadata['opciones'] != null && metadata['opciones'] is List) {
      return List<String>.from(metadata['opciones']);
    }
    return [];
  }

  String get respuesta {
    return metadata['respuesta']?.toString() ?? '';
  }

  Map<String, dynamic> toMap() {
    return {
      'enunciado': enunciado,
      'metadata': metadata,
      'orden': orden,
      'tipo': tipo,
    };
  }
}

class UserCourse {
  final String cursoId;
  final int progreso;
  final List<String> actividadesRealizadas;

  UserCourse({
    required this.cursoId,
    this.progreso = 0,
    this.actividadesRealizadas = const [],
  });

  factory UserCourse.fromFirestore(Map<String, dynamic> data, String documentId) {
    return UserCourse(
      cursoId: documentId,
      progreso: data['progreso'] ?? 0,
      actividadesRealizadas: List<String>.from(data['actividadesRealizadas'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'progreso': progreso,
      'actividadesRealizadas': actividadesRealizadas,
    };
  }
}
