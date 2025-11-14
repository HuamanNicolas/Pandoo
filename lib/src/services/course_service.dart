import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/course.dart';

class CourseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Obtener un curso específico por ID
  Future<Course?> getCourse(String courseId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('cursos').doc(courseId).get();
      
      if (doc.exists) {
        return Course.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }
      return null;
    } catch (e) {
      print('Error obteniendo curso: $e');
      return null;
    }
  }

  /// Obtener todas las actividades de un curso
  Future<List<Actividad>> getActividades(String courseId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('cursos')
          .doc(courseId)
          .collection('actividades')
          .orderBy('orden')
          .get();

      return snapshot.docs
          .map((doc) => Actividad.fromFirestore(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ))
          .toList();
    } catch (e) {
      print('Error obteniendo actividades: $e');
      return [];
    }
  }

  /// Obtener todos los ejercicios de una actividad
  Future<List<Ejercicio>> getEjercicios(String courseId, String actividadId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('cursos')
          .doc(courseId)
          .collection('actividades')
          .doc(actividadId)
          .collection('ejercicios')
          .orderBy('orden')
          .get();

      return snapshot.docs
          .map((doc) => Ejercicio.fromFirestore(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ))
          .toList();
    } catch (e) {
      print('Error obteniendo ejercicios: $e');
      return [];
    }
  }

  /// Verificar si el usuario está suscrito a un curso
  Future<bool> isUserSubscribed(String courseId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return false;

      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cursos')
          .doc(courseId)
          .get();

      return doc.exists;
    } catch (e) {
      print('Error verificando suscripción: $e');
      return false;
    }
  }

  /// Suscribir al usuario a un curso
  Future<bool> subscribeToCourse(String courseId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) {
        print('Usuario no autenticado');
        return false;
      }

      // Crear la suscripción del usuario al curso
      UserCourse userCourse = UserCourse(
        cursoId: courseId,
        progreso: 0,
        actividadesRealizadas: [],
      );

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cursos')
          .doc(courseId)
          .set(userCourse.toMap());

      print('Usuario suscrito al curso exitosamente');
      return true;
    } catch (e) {
      print('Error suscribiendo al curso: $e');
      return false;
    }
  }

  /// Obtener el progreso del usuario en un curso
  Future<UserCourse?> getUserCourseProgress(String courseId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return null;

      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cursos')
          .doc(courseId)
          .get();

      if (doc.exists) {
        return UserCourse.fromFirestore(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }
      return null;
    } catch (e) {
      print('Error obteniendo progreso: $e');
      return null;
    }
  }

  /// Obtener todos los cursos del usuario
  Future<List<String>> getUserCourses() async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return [];

      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cursos')
          .get();

      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print('Error obteniendo cursos del usuario: $e');
      return [];
    }
  }

  /// Marcar una actividad como completada y actualizar progreso
  Future<bool> completeActivity(String courseId, String activityId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return false;

      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('cursos')
          .doc(courseId);

      final doc = await docRef.get();
      if (!doc.exists) return false;

      final data = doc.data() as Map<String, dynamic>;
      final actividadesRealizadas = List<String>.from(data['actividadesRealizadas'] ?? []);

      // Si la actividad ya está completada, no hacer nada
      if (actividadesRealizadas.contains(activityId)) {
        return true;
      }

      // Agregar la actividad a la lista
      actividadesRealizadas.add(activityId);

      // Calcular el nuevo progreso (necesitamos el total de actividades)
      final totalActividades = await getActividades(courseId);
      final progreso = totalActividades.isEmpty 
          ? 0 
          : ((actividadesRealizadas.length / totalActividades.length) * 100).round();

      // Actualizar en Firestore
      await docRef.update({
        'actividadesRealizadas': actividadesRealizadas,
        'progreso': progreso,
      });

      print('Actividad completada. Progreso: $progreso%');
      return true;
    } catch (e) {
      print('Error completando actividad: $e');
      return false;
    }
  }

  /// Obtener información completa del curso con progreso del usuario
  Future<Map<String, dynamic>?> getCourseWithProgress(String courseId) async {
    try {
      final course = await getCourse(courseId);
      if (course == null) return null;

      final userProgress = await getUserCourseProgress(courseId);
      final actividades = await getActividades(courseId);

      return {
        'course': course,
        'progress': userProgress?.progreso ?? 0,
        'completedActivities': userProgress?.actividadesRealizadas ?? [],
        'totalActivities': actividades.length,
      };
    } catch (e) {
      print('Error obteniendo curso con progreso: $e');
      return null;
    }
  }
}
