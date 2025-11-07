import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Obtener el usuario actual
  User? get currentUser => _auth.currentUser;

  /// Registrar un nuevo usuario
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String nombre,
    required String usuario,
  }) async {
    try {
      print('🔐 Iniciando registro para: $email');

      // 1. Crear usuario en Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      print('✅ Usuario creado en Auth con UID: $uid');

      // 2. Crear documento en Firestore con el UID como ID
      await _firestore.collection('users').doc(uid).set({
        'correo': email,
        'nombre': nombre,
        'usuario': usuario,
        'createdAt': FieldValue.serverTimestamp(),
      });

      print('✅ Documento creado en Firestore');

      return {
        'success': true,
        'message': 'Usuario registrado exitosamente',
        'uid': uid,
      };
    } on FirebaseAuthException catch (e) {
      print('❌ Error de autenticación: ${e.code}');
      
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'La contraseña es demasiado débil';
          break;
        case 'email-already-in-use':
          message = 'Este correo ya está registrado';
          break;
        case 'invalid-email':
          message = 'El correo no es válido';
          break;
        default:
          message = 'Error al registrar: ${e.message}';
      }

      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      print('❌ Error general: $e');
      return {
        'success': false,
        'message': 'Error inesperado: $e',
      };
    }
  }

  /// Iniciar sesión con email y contraseña
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      print('🔐 Iniciando sesión para: $email');

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      print('✅ Sesión iniciada con UID: $uid');

      return {
        'success': true,
        'message': 'Sesión iniciada correctamente',
        'uid': uid,
      };
    } on FirebaseAuthException catch (e) {
      print('❌ Error de autenticación: ${e.code}');

      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No existe una cuenta con este correo';
          break;
        case 'wrong-password':
          message = 'Contraseña incorrecta';
          break;
        case 'invalid-email':
          message = 'El correo no es válido';
          break;
        case 'user-disabled':
          message = 'Esta cuenta ha sido deshabilitada';
          break;
        case 'invalid-credential':
          message = 'Credenciales inválidas';
          break;
        default:
          message = 'Error al iniciar sesión: ${e.message}';
      }

      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      print('❌ Error general: $e');
      return {
        'success': false,
        'message': 'Error inesperado: $e',
      };
    }
  }

  /// Obtener datos del usuario logueado desde Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        print('❌ No hay usuario logueado');
        return null;
      }

      String uid = user.uid;
      print('🔍 Obteniendo datos del usuario con UID: $uid');

      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();

      if (!doc.exists) {
        print('❌ No se encontró el documento del usuario');
        return null;
      }

      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      userData['uid'] = uid; // Agregar el UID a los datos

      print('✅ Datos del usuario obtenidos: $userData');
      return userData;
    } catch (e) {
      print('❌ Error al obtener datos: $e');
      return null;
    }
  }

  /// Cerrar sesión
  Future<void> logout() async {
    try {
      await _auth.signOut();
      print('✅ Sesión cerrada correctamente');
    } catch (e) {
      print('❌ Error al cerrar sesión: $e');
    }
  }

  /// Verificar si hay un usuario logueado
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  /// Obtener el UID del usuario actual
  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  /// Obtener el email del usuario actual
  String? getCurrentUserEmail() {
    return _auth.currentUser?.email;
  }
}
