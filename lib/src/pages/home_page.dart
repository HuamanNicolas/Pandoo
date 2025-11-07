import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con saludo y logo
            Container(
              height: responsive.hp(responsive.isTablet ? 12 : 16),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF78C800),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: responsive.hp(2),
                    left: responsive.wp(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hola,',
                          style: TextStyle(
                            fontSize: responsive.dp(responsive.isTablet ? 2 : 3),
                          ),
                        ),
                        Text(
                          'Nico!',
                          style: TextStyle(
                            fontSize: responsive.dp(responsive.isTablet ? 2.5 : 3.5),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: responsive.wp(5),
                    top: 0,
                    bottom: 0,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: responsive.wp(responsive.isTablet ? 8 : 20),
                      height: responsive.wp(responsive.isTablet ? 8 : 20),
                    ),
                  ),
                ],
              ),
            ),
            
            // Sección de Cursos
            Container(
              padding: EdgeInsets.only(
                left: responsive.wp(7),
                top: responsive.hp(3),
                bottom: responsive.hp(1),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                'Cursos',
                style: TextStyle(
                  fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2.2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Iconos de Cursos
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.wp(5),
                vertical: responsive.hp(2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCourseIcon(
                    context,
                    responsive,
                    'assets/images/Redes.png',
                    'Redes',
                  ),
                  _buildCourseIcon(
                    context,
                    responsive,
                    'assets/images/Ingles.png',
                    'Inglés',
                  ),
                  _buildCourseIcon(
                    context,
                    responsive,
                    'assets/images/Eyfc.png',
                    'EyFC',
                  ),
                  _buildCourseIcon(
                    context,
                    responsive,
                    'assets/images/Ayrp.png',
                    'AyRP',
                  ),
                ],
              ),
            ),
            
            // Tus cursos - Header
            Container(
              constraints: BoxConstraints(maxWidth: responsive.isTablet ? 600 : double.infinity),
              padding: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tus cursos',
                    style: TextStyle(
                      fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2.2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Ver todos',
                    style: TextStyle(
                      fontSize: responsive.dp(responsive.isTablet ? 1.3 : 2),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: responsive.hp(1)),
            
            // Tarjeta de curso 1
            _buildCourseCard(
              context,
              responsive,
              'Redes',
              'Unidad 2 - Capa de aplicación',
              0.7,
            ),
            
            SizedBox(height: responsive.hp(2)),
            
            // Tarjeta de curso 2
            _buildCourseCard(
              context,
              responsive,
              'Inglés',
              'Unidad 2 - Actividad 4',
              0.3,
            ),
            
            // Sección de Calculadoras
            Container(
              padding: EdgeInsets.only(
                left: responsive.wp(7),
                top: responsive.hp(3),
                bottom: responsive.hp(1),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                'Calculadoras',
                style: TextStyle(
                  fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2.2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            // Iconos de Calculadoras
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: responsive.wp(5),
                vertical: responsive.hp(2),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCalculatorIcon(
                    context,
                    responsive,
                    'assets/images/Calculate.png',
                    'Redes',
                    const Color.fromARGB(255, 0, 122, 204),
                  ),
                  _buildCalculatorIcon(
                    context,
                    responsive,
                    'assets/images/Calculate.png',
                    'EyFC',
                    const Color.fromARGB(255, 155, 81, 224),
                  ),
                  _buildCalculatorIcon(
                    context,
                    responsive,
                    'assets/images/Calculate.png',
                    'AyRP',
                    const Color.fromARGB(255, 255, 122, 0),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: responsive.hp(2)),
          ],
        ),
      ),
    );
  }

  // Widget reutilizable para iconos de cursos
  Widget _buildCourseIcon(
    BuildContext context,
    Responsive responsive,
    String imagePath,
    String label,
  ) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print('$label presionado');
          },
          onLongPress: () {
            print('$label long presionado');
          },
          child: Container(
            padding: EdgeInsets.all(responsive.wp(responsive.isTablet ? 1 : 1.5)),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 36, 56, 65),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              imagePath,
              width: responsive.wp(responsive.isTablet ? 10 : 16),
              height: responsive.wp(responsive.isTablet ? 10 : 16),
            ),
          ),
        ),
        SizedBox(height: responsive.hp(0.5)),
        Text(
          label,
          style: TextStyle(
            fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.8),
          ),
        ),
      ],
    );
  }

  // Widget reutilizable para tarjetas de curso
  Widget _buildCourseCard(
    BuildContext context,
    Responsive responsive,
    String title,
    String subtitle,
    double progress,
  ) {
    return InkWell(
      onTap: () {
        print('$title presionado');
      },
      child: Container(
        constraints: BoxConstraints(maxWidth: responsive.isTablet ? 600 : double.infinity),
        padding: EdgeInsets.all(responsive.wp(5)),
        margin: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(81, 0, 0, 0),
              spreadRadius: 0.1,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2.2),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: responsive.hp(0.5)),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: responsive.dp(responsive.isTablet ? 1 : 1.5),
                color: Color(0xFF78C800),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: responsive.hp(1)),
            SizedBox(
              height: responsive.hp(1.5),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: const Color.fromARGB(255, 36, 56, 65),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFF78C800),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget reutilizable para iconos de calculadora
  Widget _buildCalculatorIcon(
    BuildContext context,
    Responsive responsive,
    String imagePath,
    String label,
    Color backgroundColor,
  ) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            print('Calculadora $label presionada');
          },
          onLongPress: () {
            print('Calculadora $label long presionada');
          },
          child: Container(
            padding: EdgeInsets.all(responsive.wp(responsive.isTablet ? 1 : 1.5)),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Image.asset(
              imagePath,
              width: responsive.wp(responsive.isTablet ? 10 : 16),
              height: responsive.wp(responsive.isTablet ? 10 : 16),
            ),
          ),
        ),
        SizedBox(height: responsive.hp(0.5)),
        Text(
          label,
          style: TextStyle(
            fontSize: responsive.dp(responsive.isTablet ? 1.2 : 1.8),
          ),
        ),
      ],
    );
  }
}
