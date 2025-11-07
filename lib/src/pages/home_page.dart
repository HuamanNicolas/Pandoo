import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 135,
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
                  bottom: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hola,', style: TextStyle(fontSize: 24)),
                      Text(
                        'Nico!',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 0,
                  bottom: 0,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, top: 25, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cursos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print('presionado');
                      },
                      onLongPress: () {
                        print('long presionado');
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 36, 56, 65),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/images/Redes.png',
                          width: 65,
                          height: 65,
                        ),
                      ),
                    ),
                    Text('Redes', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print('presionado');
                      },
                      onLongPress: () {
                        print('long presionado');
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 36, 56, 65),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/images/Ingles.png',
                          width: 65,
                          height: 65,
                        ),
                      ),
                    ),
                    Text('Inglés', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print('presionado');
                      },
                      onLongPress: () {
                        print('long presionado');
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 36, 56, 65),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/images/Eyfc.png',
                          width: 65,
                          height: 65,
                        ),
                      ),
                    ),
                    Text('EyFC', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print('presionado');
                      },
                      onLongPress: () {
                        print('long presionado');
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 36, 56, 65),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image.asset(
                          'assets/images/Ayrp.png',
                          width: 65,
                          height: 65,
                        ),
                      ),
                    ),
                    Text('AyRP', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 350,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tus cursos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text('Ver todos', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              print('presionado');
            },
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              margin: EdgeInsets.only(left: 20, right: 20),
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
                  SizedBox(height: 10),
                  Text(
                    'Redes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Unidad 2 - Capa de apliación',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF78C800),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 13,
                    child: LinearProgressIndicator(
                      value: 0.7, // 70% de progreso (valor entre 0.0 y 1.0)
                      backgroundColor: const Color.fromARGB(255, 36, 56, 65),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF78C800),
                      ), // Verde
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            onTap: () {
              print('presionado');
            },
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
              margin: EdgeInsets.only(left: 20, right: 20),
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
                  SizedBox(height: 10),
                  Text(
                    'Inglés',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Unidad 2 - Actividad 4',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF78C800),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 13,
                    child: LinearProgressIndicator(
                      value: 0.3, // 70% de progreso (valor entre 0.0 y 1.0)
                      backgroundColor: const Color.fromARGB(255, 36, 56, 65),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Color(0xFF78C800),
                      ), // Verde
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, top: 25, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              'Calculadoras',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print('presionado');
                      },
                      onLongPress: () {
                        print('long presionado');
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 0, 122, 204),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset(
                          'assets/images/Calculate.png',
                          width: 65,
                          height: 65,
                        ),
                      ),
                    ),
                    Text('Redes', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print('presionado');
                      },
                      onLongPress: () {
                        print('long presionado');
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 155, 81, 224),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset(
                          'assets/images/Calculate.png',
                          width: 65,
                          height: 65,
                        ),
                      ),
                    ),
                    Text('EyFC', style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () {
                        print('presionado');
                      },
                      onLongPress: () {
                        print('long presionado');
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 122, 0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset(
                          'assets/images/Calculate.png',
                          width: 65,
                          height: 65,
                        ),
                      ),
                    ),
                    Text('AyRP', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
