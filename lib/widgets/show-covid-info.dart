import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CovidInfoCard extends StatelessWidget {
  final String title;
  final String data;
  final Color color;
  const CovidInfoCard({Key key, this.title, this.data, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
          style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
              color: color,
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          data,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: color,
              fontSize: 26.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
