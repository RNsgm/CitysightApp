import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPanel extends StatefulWidget {
  SearchPanel({super.key, required this.query});

  TextEditingController query = TextEditingController();

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF7087FE),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 1,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90.0),
            color: Colors.black26,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.all(0),
              hintText: "Поиск",
              hintStyle: TextStyle(color: Color(0xB2FFFFFF)),
              icon: Icon(Icons.search, color: Color(0xB2FFFFFF),),
            ),
            style: GoogleFonts.lato(color: Colors.white),
            controller: widget.query,
          ),
        ),
      ),
    );
  }
}