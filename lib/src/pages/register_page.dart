import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import '../../utils/responsive.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _handleRegister() async {
    String email = _emailController.text.trim();
    String password = _passController.text.trim();
    String nombre = _nombreController.text.trim();
    String usuario = _usuarioController.text.trim();

    print('📝 Intentando registro con email: $email');

    // Validar campos vacíos
    if (email.isEmpty || password.isEmpty || nombre.isEmpty || usuario.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor completa todos los campos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validar formato de email
    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor ingresa un email válido'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validar longitud de contraseña
    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La contraseña debe tener al menos 6 caracteres'),
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
      // Llamar al servicio de registro
      Map<String, dynamic> result = await _authService.register(
        email: email,
        password: password,
        nombre: nombre,
        usuario: usuario,
      );

      setState(() {
        _isLoading = false;
      });

      print('📊 Resultado del registro: $result');

      if (result['success']) {
        // Registro exitoso
        print('✅ Registro exitoso');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cuenta creada exitosamente. ¡Ahora puedes iniciar sesión!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        // Cerrar sesión automática y volver al login
        await _authService.logout();

        // Volver al login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        // Registro fallido
        print('❌ Registro fallido: ${result['message']}');

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

      print('❌ Error en registro: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al registrar: $e'),
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF243841)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: responsive.wp(8)),
          child: Container(
            constraints: BoxConstraints(maxWidth: responsive.isTablet ? 500 : double.infinity),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                Image.asset(
                  'assets/images/logo.png',
                  width: responsive.wp(responsive.isTablet ? 12 : 25),
                  height: responsive.wp(responsive.isTablet ? 12 : 25),
                ),
                SizedBox(height: responsive.hp(3)),
                Text(
                  'Crear Cuenta',
                  style: TextStyle(
                    fontSize: responsive.dp(responsive.isTablet ? 2.5 : 3.5),
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF243841),
                  ),
                ),
                SizedBox(height: responsive.hp(4)),
                TextField(
                  controller: _nombreController,
                  style: TextStyle(fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2)),
                  decoration: InputDecoration(
                    labelText: 'Nombre completo',
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
                  controller: _usuarioController,
                  style: TextStyle(fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2)),
                  decoration: InputDecoration(
                    labelText: 'Nombre de usuario',
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
                    hintText: 'Mínimo 6 caracteres',
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
                    onPressed: _isLoading ? null : _handleRegister,
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
                            'Registrarse',
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
                    Navigator.pop(context);
                  },
                  child: Text(
                    '¿Ya tienes cuenta? Inicia sesión',
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
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _nombreController.dispose();
    _usuarioController.dispose();
    super.dispose();
  }
}
