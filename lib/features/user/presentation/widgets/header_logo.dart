import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoHeader extends StatelessWidget {
  final String titulo;
  final VoidCallback? onBackPressed;  // Parámetro opcional para manejar el retroceso
  final Function()? onNavigateBack;   // Navegación opcional para regresar

  const LogoHeader({
    Key? key,
    required this.titulo,
    this.onBackPressed,  // Opcional
    this.onNavigateBack,  // Opcional para una acción de navegación más específica
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width, // Limita el ancho máximo al ancho de la pantalla
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Para que la columna se ajuste al contenido
          children: [
            FittedBox(
              fit: BoxFit.scaleDown, // Permite que el contenido se reduzca si es necesario
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,  // Alinea los elementos al inicio (a la izquierda)
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (onBackPressed != null || onNavigateBack != null)  // Si se pasa alguna acción de retroceso, muestra el IconButton
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: onNavigateBack ?? onBackPressed,  // Llama a la función de navegación pasada como parámetro
                    ),
                  const SizedBox(width: 10), // Espacio horizontal entre la flecha y el texto
                  Text(
                    titulo,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10), // Espacio entre el texto y la imagen
                  SvgPicture.asset(
                    'assets/IconApp.svg',
                    width: 50, // Se ajustará al tamaño disponible si es necesario
                    height: 50, // Lo mismo aquí
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8), // Espacio entre el contenido y la línea
            Container(
              width: double.infinity, // Asegura que el Divider ocupe todo el ancho
              height: 1, // Grosor de la línea
              decoration: BoxDecoration(
                color: Colors.black, // Color de la línea
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Color de la sombra
                    blurRadius: 4, // Radio del desenfoque de la sombra
                    offset: Offset(0, 2), // Desplazamiento de la sombra (hacia abajo)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
