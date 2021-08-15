import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:agriunions_logistics/helper/data_store.dart';

class TripDetailsCard extends StatelessWidget {
  TripDetailsCard({
    this.icon,
    this.icon1,
    this.image,
    this.image1,
    required this.title,
    required this.title1,
    required this.subtitle,
    required this.subtitle1,
  });
  final String? image, image1;
  final IconData? icon, icon1;
  final String title, title1;
  final String subtitle, subtitle1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: kElevationToShadow[3],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon != null
                      ? Icon(icon)
                      : Image.asset(
                          image!,
                          scale: 2.8,
                        ),
                  Padding(
                    padding: (dataStore.lang == 'en')
                        ? const EdgeInsets.only(left: 8.0)
                        : const EdgeInsets.only(right: 8.0),
                    child: Text(title,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Text(subtitle),
            ],
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: Divider(
                thickness: 2,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  icon1 != null
                      ? Icon(icon1)
                      : Image.asset(
                          image1!,
                          scale: 2,
                        ),
                  Padding(
                    padding: (dataStore.lang == 'en')
                        ? const EdgeInsets.only(left: 8.0)
                        : const EdgeInsets.only(right: 8.0),
                    child: Text(title1,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Text(subtitle1),
            ],
          ),
        ],
      ),
    );
  }
}
