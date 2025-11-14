import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import '../models/course.dart';
import '../services/course_service.dart';

class ExercisePage extends StatefulWidget {
  final String courseId;
  final String actividadId;
  final List<Ejercicio> ejercicios;

  const ExercisePage({
    super.key,
    required this.courseId,
    required this.actividadId,
    required this.ejercicios,
  });

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  final CourseService _courseService = CourseService();
  int currentExerciseIndex = 0;
  String? selectedAnswer;
  bool showResult = false;
  bool isCorrect = false;
  int correctAnswers = 0;

  Ejercicio get currentExercise => widget.ejercicios[currentExerciseIndex];
  bool get isLastExercise => currentExerciseIndex == widget.ejercicios.length - 1;

  @override
  void initState() {
    super.initState();
  }

  void _selectAnswer(String answer) {
    if (showResult) return;

    setState(() {
      selectedAnswer = answer;
    });
  }

  void _checkAnswer() {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor selecciona una respuesta'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      isCorrect = selectedAnswer == currentExercise.respuesta;
      if (isCorrect) {
        correctAnswers++;
      }
      showResult = true;
    });
  }

  void _nextExercise() {
    if (isLastExercise) {
      _showResults();
    } else {
      setState(() {
        currentExerciseIndex++;
        selectedAnswer = null;
        showResult = false;
        isCorrect = false;
      });
    }
  }

  void _showResults() async {
    final percentage = (correctAnswers / widget.ejercicios.length * 100).round();
    
    // Si aprobó (70% o más), marcar actividad como completada
    if (percentage >= 70) {
      await _courseService.completeActivity(
        widget.courseId,
        widget.actividadId,
      );
    }
    
    if (!mounted) return;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final Responsive responsive = Responsive.of(context);
        
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Icon(
                percentage >= 70 ? Icons.celebration : Icons.info_outline,
                color: percentage >= 70 ? const Color(0xFF78C800) : Colors.orange,
                size: responsive.wp(responsive.isTablet ? 8 : 10),
              ),
              SizedBox(width: responsive.wp(2)),
              Text(
                'Resultados',
                style: TextStyle(
                  fontSize: responsive.dp(responsive.isTablet ? 1.8 : 2.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$correctAnswers de ${widget.ejercicios.length}',
                style: TextStyle(
                  fontSize: responsive.dp(responsive.isTablet ? 3 : 4),
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF78C800),
                ),
              ),
              SizedBox(height: responsive.hp(1)),
              Text(
                'Respuestas correctas',
                style: TextStyle(
                  fontSize: responsive.dp(responsive.isTablet ? 1.3 : 1.8),
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: responsive.hp(2)),
              Text(
                'Puntuación: $percentage%',
                style: TextStyle(
                  fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: responsive.hp(1)),
              Text(
                percentage >= 70
                    ? '¡Excelente trabajo!'
                    : 'Sigue practicando',
                style: TextStyle(
                  fontSize: responsive.dp(responsive.isTablet ? 1.3 : 1.8),
                  color: percentage >= 70 ? const Color(0xFF78C800) : Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar diálogo
                Navigator.pop(context); // Volver a ActivityDetailPage
              },
              child: Text(
                'Finalizar',
                style: TextStyle(
                  fontSize: responsive.dp(responsive.isTablet ? 1.3 : 1.8),
                  color: const Color(0xFF78C800),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
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
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('¿Salir?'),
                content: const Text('Perderás tu progreso actual'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Cerrar diálogo
                      Navigator.pop(context); // Salir de ejercicios
                    },
                    child: const Text('Salir', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
          },
        ),
        title: Text(
          'Ejercicio ${currentExerciseIndex + 1} de ${widget.ejercicios.length}',
          style: TextStyle(
            color: Colors.white,
            fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(responsive.wp(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra de progreso
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (currentExerciseIndex + 1) / widget.ejercicios.length,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF78C800)),
                  minHeight: responsive.hp(1),
                ),
              ),

              SizedBox(height: responsive.hp(4)),

              // Enunciado
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(responsive.wp(5)),
                decoration: BoxDecoration(
                  color: const Color(0xFF243841),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  currentExercise.enunciado,
                  style: TextStyle(
                    fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2),
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: responsive.hp(4)),       
              

              // Opciones
              ...currentExercise.opciones.map((opcion) {
                final isSelected = selectedAnswer == opcion;
                final isCorrectAnswer = opcion == currentExercise.respuesta;
                
                Color backgroundColor = Colors.white;
                Color borderColor = const Color(0xFF243841);
                Color textColor = const Color(0xFF243841);
                
                if (showResult) {
                  if (isCorrectAnswer) {
                    backgroundColor = const Color(0xFF78C800).withOpacity(0.2);
                    borderColor = const Color(0xFF78C800);
                    textColor = const Color(0xFF78C800);
                  } else if (isSelected && !isCorrect) {
                    backgroundColor = Colors.red.withOpacity(0.2);
                    borderColor = Colors.red;
                    textColor = Colors.red;
                  }
                } else if (isSelected) {
                  backgroundColor = const Color(0xFF78C800).withOpacity(0.1);
                  borderColor = const Color(0xFF78C800);
                }

                return Container(
                  margin: EdgeInsets.only(bottom: responsive.hp(2)),
                  child: InkWell(
                    onTap: () => _selectAnswer(opcion),
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: EdgeInsets.all(responsive.wp(4)),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: borderColor, width: 2),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: responsive.wp(responsive.isTablet ? 8 : 10),
                            height: responsive.wp(responsive.isTablet ? 8 : 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected || (showResult && isCorrectAnswer)
                                  ? borderColor
                                  : Colors.transparent,
                              border: Border.all(color: borderColor, width: 2),
                            ),
                            child: showResult && isCorrectAnswer
                                ? const Icon(Icons.check, color: Colors.white, size: 20)
                                : showResult && isSelected && !isCorrect
                                    ? const Icon(Icons.close, color: Colors.white, size: 20)
                                    : null,
                          ),
                          SizedBox(width: responsive.wp(4)),
                          Expanded(
                            child: Text(
                              opcion,
                              style: TextStyle(
                                fontSize: responsive.dp(responsive.isTablet ? 1.3 : 1.8),
                                color: textColor,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              SizedBox(height: responsive.hp(3)),

              // Botón de acción
              SizedBox(
                width: double.infinity,
                height: responsive.hp(7),
                child: ElevatedButton(
                  onPressed: showResult ? _nextExercise : _checkAnswer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF78C800),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    showResult
                        ? (isLastExercise ? 'Ver resultados' : 'Siguiente')
                        : 'Comprobar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: responsive.dp(responsive.isTablet ? 1.5 : 2),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
