import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Surface extends StatelessWidget {
  Surface({super.key, required this.title, required this.onPressed });

  String title;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      margin: EdgeInsets.all(0.0),
      child: Container(
        height: 46,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 12),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      title,
                      style: GoogleFonts.lato(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                )
              ),
              Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: TextButton(
                      onPressed: onPressed,
                      child: Text(
                        "больше".toUpperCase(),
                        style: GoogleFonts.lato(
                          color: Colors.indigo.shade800,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                        ),
                      ),
                    ),
                  ),
                )
              )
            ]
          ),
        )
      ),
    );
  }
}