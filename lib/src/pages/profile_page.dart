import 'package:flutter/material.dart';
import '../services/firebase_services.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List personas = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    cargarPersonas();
  }

  cargarPersonas() async {
    List data = await getpersona();

    setState(() {
      personas = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator() // Muestra loading mientras carga
            : personas.isNotEmpty
            ? Text(
                'Página de Perfil ${personas[0]['nombre']},${personas[0]['usuario']} ',
                style: TextStyle(fontSize: 24),
              )
            : Text(
                'No se encontraron usuarios',
                style: TextStyle(fontSize: 24),
              ),
      ),
    );
  }
}
