import 'package:flutter/material.dart';
import 'screen/adm_usuario.dart';
import 'screen/adm_proyecto.dart';
import 'screen/adm_sprint.dart';
import 'screen/crear_usuario.dart';
import 'screen/crear_proyecto.dart';
import 'screen/crear_sprint.dart';
import 'screen/inicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: " WORKSCRUM",
      debugShowCheckedModeBanner: false,
      initialRoute: '/inicio',
      routes: {
         '/inicio': (context) => const inicio(), 
         '/': (context) => const AdmUsuario(), 
         '/proyectos': (context) => const AdmProyectos(), 
         '/sprints': (context) => const AdmSprint(), 
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/usuarios/crear') {
          return MaterialPageRoute(
            builder: (context) => const CrearUsuario(),
          );
        }else if (settings.name == '/proyectos/crear') {
          return MaterialPageRoute(
            builder: (context) => const CrearProyecto(),
          );
        }else if(settings.name == '/sprints/crear'){
          return MaterialPageRoute(
            builder: (context) => const CrearSprint(),
          );
        }
         return null; 
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Página no encontrada')),
          ),
        );
      },
    );
  }
}
