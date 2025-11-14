import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import '../models/course.dart';
import '../services/course_service.dart';
import 'exercise_page.dart';

class ActivityDetailPage extends StatefulWidget {
  final String courseId;
  final Actividad actividad;

  const ActivityDetailPage({
    super.key,
    required this.courseId,
    required this.actividad,
  });

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  final CourseService _courseService = CourseService();
  List<Ejercicio> ejercicios = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEjercicios();
  }

  Future<void> _loadEjercicios() async {
    setState(() => isLoading = true);

    final loadedEjercicios = await _courseService.getEjercicios(
      widget.courseId,
      widget.actividad.id,
    );

    setState(() {
      ejercicios = loadedEjercicios;
      isLoading = false;
    });
  }

  void _startExercises() {
    if (ejercicios.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay ejercicios disponibles'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExercisePage(
          courseId: widget.courseId,
          actividadId: widget.actividad.id,
          ejercicios: ejercicios,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF78C800),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.actividad.nombre,
          style: TextStyle(
            color: Colors.white,
            fontSize: responsive.dp(responsive.isTablet ? 1.8 : 2.5),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF78C800)))
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(responsive.wp(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header de la actividad
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(responsive.wp(5)),
                      decoration: BoxDecoration(
                        color: const Color(0xFF78C800).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: const Color(0xFF78C800),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: responsive.wp(responsive.isTablet ? 12 : 15),
                                height: responsive.wp(responsive.isTablet ? 12 : 15),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF78C800),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${widget.actividad.orden}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsive.dp(responsive.isTablet ? 2 : 2.5),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: responsive.wp(4)),
                              Expanded(
                                child: Text(
                                  widget.actividad.nombre,
                                  style: TextStyle(
                                    fontSize: responsive.dp(responsive.isTablet ? 1.8 : 2.5),
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF243841),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: responsive.hp(3)),

                    // Información de ejercicios
                    Text(
                      'Ejercicios',
                      style: TextStyle(
                        fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2.2),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF243841),
                      ),
                    ),

                    SizedBox(height: responsive.hp(2)),

                    if (ejercicios.isEmpty)
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: responsive.hp(5)),
                          child: Text(
                            'No hay ejercicios disponibles',
                            style: TextStyle(
                              fontSize: responsive.dp(responsive.isTablet ? 1.3 : 1.8),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    else
                      ...ejercicios.map((ejercicio) => Container(
                            margin: EdgeInsets.only(bottom: responsive.hp(1.5)),
                            padding: EdgeInsets.all(responsive.wp(4)),
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                Icon(
                                  ejercicio.tipo == 'multiple_choice'
                                      ? Icons.quiz
                                      : Icons.edit_note,
                                  color: const Color(0xFF78C800),
                                  size: responsive.wp(responsive.isTablet ? 8 : 10),
                                ),
                                SizedBox(width: responsive.wp(4)),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Ejercicio ${ejercicio.orden}',
                                        style: TextStyle(
                                          fontSize: responsive.dp(responsive.isTablet ? 1.3 : 1.8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: responsive.hp(0.5)),
                                      Text(
                                        ejercicio.tipo == 'multiple_choice'
                                            ? 'Opción múltiple'
                                            : ejercicio.tipo,
                                        style: TextStyle(
                                          fontSize: responsive.dp(responsive.isTablet ? 1 : 1.4),
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),

                    SizedBox(height: responsive.hp(3)),

                    // Botón para comenzar
                    if (ejercicios.isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        height: responsive.hp(7),
                        child: ElevatedButton(
                          onPressed: _startExercises,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF78C800),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.play_arrow, color: Colors.white),
                              SizedBox(width: responsive.wp(2)),
                              Text(
                                'Comenzar ejercicios',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    SizedBox(height: responsive.hp(2)),
                  ],
                ),
              ),
            ),
    );
  }
}
