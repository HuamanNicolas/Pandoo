import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getpersona() async {
  List persona = [];
  CollectionReference coleccionreference = db.collection('User');
  QuerySnapshot querypersona = await coleccionreference.get();

  for (var documento in querypersona.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String, dynamic>;
    final person = {
      "id": documento.id,
      "nombre": data['nombre'],
      "usuario": data['usuario'],
      "password": data['password'],
      "email": data['email'],
    };
    persona.add(person);
  }
  return persona;
}

Future<void> addpersona(String nombre) async {
  await db.collection('User').add({"nombre": nombre});
}

Future<void> updatePersona(String uid, String newNombre) async {
  await db.collection('User').doc(uid).set({"nombre": newNombre});
}

Future<void> borrarPersona(String uid) async {
  await db.collection('User').doc(uid).delete();
}