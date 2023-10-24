import 'package:flutter/material.dart';

class AddtoCartIcon extends StatelessWidget {
  const AddtoCartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset("assets/images/blackbag.png")
                     
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Builder(
                    builder: (context) {
                      return CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.black,
                        child: Text(
                          "33",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),


          
      ],
    );
  }
}