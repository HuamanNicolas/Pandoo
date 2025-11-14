import 'package:flutter/material.dart';
import 'main_navigation.dart';
import 'register_page.dart';
import '../services/auth_service.dart';
import '../../utils/responsive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passController.text.trim();

    // Validar campos vacíos
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor ingresa email y contraseña'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Mostrar loading
    setState(() {
      _isLoading = true;
    });

    try {
      // Llamar al servicio de autenticación
      Map<String, dynamic> result = await _authService.login(
        email: email,
        password: password,
      );

      if (result['success']) {
        // Login exitoso - Obtener datos del usuario
        Map<String, dynamic>? userData = await _authService.getUserData();

        setState(() {
          _isLoading = false;
        });

        if (userData != null) {
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('¡Bienvenido ${userData['nombre']}!'),
              backgroundColor: Colors.green,
            ),
          );

          // Navegar al MainNavigation
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainNavigation()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al obtener datos del usuario'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      } else {
        // Login fallido
        setState(() {
          _isLoading = false;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al iniciar sesión: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    
    return Scaffold(
      backgroundColor: Color(0xFF78C800),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: responsive.wp(8)),
            child: Container(
              constraints: BoxConstraints(maxWidth: responsive.isTablet ? 500 : double.infinity),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Image.asset(
                    'assets/images/logo.png',
                    width: responsive.wp(responsive.isTablet ? 15 : 30),
                    height: responsive.wp(responsive.isTablet ? 15 : 30),
                  ),
                  SizedBox(height: responsive.hp(3)),
                  Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: responsive.dp(responsive.isTablet ? 2.5 : 3.5),
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF243841),
                    ),
                  ),
                  SizedBox(height: responsive.hp(4)),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2)),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'ejemplo@correo.com',
                      labelStyle: TextStyle(fontSize: responsive.dp(responsive.isTablet ? 1.3 : 1.8)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(4),
                        vertical: responsive.hp(2),
                      ),
                    ),
                  ),
                  SizedBox(height: responsive.hp(2)),
                  TextField(
                    controller: _passController,
                    obscureText: true,
                    style: TextStyle(fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2)),
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(fontSize: responsive.dp(responsive.isTablet ? 1.3 : 1.8)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: responsive.wp(4),
                        vertical: responsive.hp(2),
                      ),
                    ),
                  ),
                  SizedBox(height: responsive.hp(3)),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF243841),
                        padding: EdgeInsets.symmetric(vertical: responsive.hp(2)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: _isLoading ? null : _handleLogin,
                      child: _isLoading
                          ? SizedBox(
                              height: responsive.dp(2),
                              width: responsive.dp(2),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              'Iniciar sesión',
                              style: TextStyle(
                                fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2.2),
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: responsive.hp(1.5)),
                  GestureDetector(
                    onTap: () {
                      // Navegar a la página de registro
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const RegisterPage()),
                      );
                    },
                    child: Text(
                      '¿No tienes cuenta? Regístrate',
                      style: TextStyle(
                        color: Color(0xFF243841),
                        decoration: TextDecoration.underline,
                        fontSize: responsive.dp(responsive.isTablet ? 1.3 : 2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
