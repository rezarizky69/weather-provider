import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imgSrc;
  final String title;
  final String weather;
  final VoidCallback press;
  const CategoryCard({
    Key? key,
    required this.imgSrc,
    required this.title,
    required this.press,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(5, 18),
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  imgSrc,
                  width: 100,
                  height: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: Colors.black,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  weather,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 12,
                        //fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent,
                      ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
