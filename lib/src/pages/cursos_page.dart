import 'package:flutter/material.dart';

class CursosPage extends StatelessWidget {
  const CursosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          'Página de Cursos',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
