import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';

class VehicleGridCard extends StatelessWidget {
  VehicleGridCard({
    required this.image,
    required this.title,
    required this.onTap,
  });

  final String image;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: kElevationToShadow[3],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Image.asset(
                    image,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    title,
                    maxLines: 2,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: TextSizes.notice,
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
