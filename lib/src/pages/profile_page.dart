import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    cargarDatosUsuario();
  }

  Future<void> cargarDatosUsuario() async {
    try {
      Map<String, dynamic>? data = await _authService.getUserData();
      setState(() {
        userData = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error al cargar datos: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _handleLogout() async {
    // Mostrar diálogo de confirmación
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cerrar sesión'),
        content: Text('¿Estás seguro que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _authService.logout();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sesión cerrada correctamente'),
          backgroundColor: Colors.green,
        ),
      );

      // Navegar al login y limpiar el stack
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF78C800),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _handleLogout,
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : userData != null
              ? SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      // Avatar
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFF243841),
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      // Nombre
                      Text(
                        userData!['nombre'] ?? 'Sin nombre',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF243841),
                        ),
                      ),
                      SizedBox(height: 8),
                      // Usuario
                      Text(
                        '@${userData!['usuario'] ?? 'usuario'}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 30),
                      // Tarjeta de información
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              // Email
                              _buildInfoRow(
                                Icons.email,
                                'Email',
                                userData!['correo'] ?? 'No disponible',
                              ),
                              Divider(height: 30),
                              // UID
                              _buildInfoRow(
                                Icons.fingerprint,
                                'ID de Usuario',
                                userData!['uid'] ?? 'No disponible',
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      // Botón de cerrar sesión
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: _handleLogout,
                          icon: Icon(Icons.logout, color: Colors.white),
                          label: Text(
                            'Cerrar sesión',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 80,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'No se pudo cargar la información del usuario',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: cargarDatosUsuario,
                        child: Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF243841), size: 28),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF243841),
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
