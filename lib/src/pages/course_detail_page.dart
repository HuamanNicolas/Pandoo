import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import '../models/course.dart';
import '../services/course_service.dart';
import 'activity_detail_page.dart';

class CourseDetailPage extends StatefulWidget {
  final String courseId;

  const CourseDetailPage({super.key, required this.courseId});

  @override
  State<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  final CourseService _courseService = CourseService();
  Course? course;
  List<Actividad> actividades = [];
  bool isSubscribed = false;
  bool isLoading = true;
  bool isSubscribing = false;

  @override
  void initState() {
    super.initState();
    _loadCourseData();
  }

  Future<void> _loadCourseData() async {
    setState(() => isLoading = true);

    // Cargar curso
    final loadedCourse = await _courseService.getCourse(widget.courseId);
    
    // Cargar actividades
    final loadedActividades = await _courseService.getActividades(widget.courseId);
    
    // Verificar suscripción
    final subscribed = await _courseService.isUserSubscribed(widget.courseId);

    setState(() {
      course = loadedCourse;
      actividades = loadedActividades;
      isSubscribed = subscribed;
      isLoading = false;
    });
  }

  Future<void> _subscribeToCourse() async {
    setState(() => isSubscribing = true);

    final success = await _courseService.subscribeToCourse(widget.courseId);

    if (success) {
      setState(() {
        isSubscribed = true;
        isSubscribing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Te has suscrito al curso exitosamente!'),
            backgroundColor: Color(0xFF78C800),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else {
      setState(() => isSubscribing = false);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al suscribirse. Intenta de nuevo.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF78C800)))
          : course == null
              ? const Center(child: Text('Curso no encontrado'))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header con imagen y nombre del curso (estilo Home)
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
                            // Imagen del curso (izquierda como avatar)
                            Positioned(
                              bottom: responsive.hp(2),
                              left: responsive.wp(5),
                              child: Row(
                                children: [
                                  // Avatar/Imagen del curso
                                  Container(
                                    width: responsive.wp(responsive.isTablet ? 12 : 18),
                                    height: responsive.wp(responsive.isTablet ? 12 : 18),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF243841),
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipOval(
                                      child: Container(
                                        color: const Color(0xFF243841),
                                        child: Image.asset(
                                          'assets/images/${course!.imagen}',
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Icon(
                                              Icons.school,
                                              size: responsive.wp(responsive.isTablet ? 8 : 12),
                                              color: Colors.white,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: responsive.wp(3)),
                                  // Nombre del curso
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        course!.nombre,
                                        style: TextStyle(
                                          fontSize: responsive.dp(responsive.isTablet ? 2 : 2.5),
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF243841),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                            Positioned(
                              right: responsive.wp(5),
                              top: 40,
                              bottom: 0,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: responsive.wp(responsive.isTablet ? 10 : 15),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: responsive.hp(3)),

                      // Información del curso
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Estado
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: responsive.wp(3),
                                vertical: responsive.hp(0.5),
                              ),
                              decoration: BoxDecoration(
                                color: course!.estado == 'activo'
                                    ? const Color(0xFF78C800)
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                course!.estado.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsive.dp(responsive.isTablet ? 1 : 1.5),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            SizedBox(height: responsive.hp(3)),

                            // Actividades
                            Text(
                              'Actividades del curso',
                              style: TextStyle(
                                fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2.2),
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF243841),
                              ),
                            ),

                            SizedBox(height: responsive.hp(2)),

                            
                            ...actividades.map((actividad) => InkWell(
                                  onTap: () {
                                    // Validar si el usuario está suscrito antes de acceder
                                    if (!isSubscribed) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Debes suscribirte al curso para acceder a las actividades'),
                                          backgroundColor: Colors.orange,
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                      return;
                                    }
                                    
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ActivityDetailPage(
                                          courseId: widget.courseId,
                                          actividad: actividad,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: responsive.hp(1.5)),
                                    padding: EdgeInsets.all(responsive.wp(4)),
                                    decoration: BoxDecoration(
                                      color: isSubscribed 
                                          ? Colors.white 
                                          : Colors.grey.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: responsive.wp(responsive.isTablet ? 8 : 12),
                                          height: responsive.wp(responsive.isTablet ? 8 : 12),
                                          decoration: BoxDecoration(
                                            color: isSubscribed 
                                                ? const Color(0xFF78C800) 
                                                : Colors.grey,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: isSubscribed
                                                ? Text(
                                                    '${actividad.orden}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )
                                                : Icon(
                                                    Icons.lock,
                                                    color: Colors.white,
                                                    size: responsive.wp(responsive.isTablet ? 5 : 7),
                                                  ),
                                          ),
                                        ),
                                        SizedBox(width: responsive.wp(4)),
                                        Expanded(
                                          child: Text(
                                            actividad.nombre,
                                            style: TextStyle(
                                              fontSize: responsive.dp(responsive.isTablet ? 1.3 : 1.8),
                                              fontWeight: FontWeight.w500,
                                              color: isSubscribed 
                                                  ? Colors.black 
                                                  : Colors.grey,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          isSubscribed 
                                              ? Icons.arrow_forward_ios 
                                              : Icons.lock_outline,
                                          color: isSubscribed 
                                              ? const Color(0xFF78C800) 
                                              : Colors.grey,
                                          size: responsive.wp(responsive.isTablet ? 5 : 6),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),

                            SizedBox(height: responsive.hp(3)),

                            // Botón de suscripción
                            if (!isSubscribed)
                              SizedBox(
                                width: double.infinity,
                                height: responsive.hp(7),
                                child: ElevatedButton(
                                  onPressed: isSubscribing ? null : _subscribeToCourse,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF78C800),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: isSubscribing
                                      ? const CircularProgressIndicator(color: Colors.white)
                                      : Text(
                                          'Suscribirse al curso',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              )
                            else
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(responsive.wp(4)),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF78C800).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: const Color(0xFF78C800),
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF78C800),
                                    ),
                                    SizedBox(width: responsive.wp(2)),
                                    Text(
                                      'Ya estás suscrito a este curso',
                                      style: TextStyle(
                                        color: const Color(0xFF78C800),
                                        fontSize: responsive.dp(responsive.isTablet ? 1.3 : 1.8),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            SizedBox(height: responsive.hp(3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Cursos está en el índice 1
        onTap: (index) {
          if (index == 0) {
            // Volver al Home
            Navigator.pop(context);
          } else if (index == 2) {
            // Navegar a Perfil (si es necesario)
            // Por ahora solo cierra para volver al navigation
            Navigator.pop(context);
          }
          // Si presiona Cursos (index 1), no hace nada porque ya está aquí
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Cursos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
