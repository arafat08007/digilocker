import 'package:flutter/material.dart';
import 'package:googledriveclone_flutter/Widget/constants.dart';

class quickNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.5),
      ),
      //padding: const EdgeInsets.all(15),
      height: MediaQuery.of(context).size.height/6,

      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index){
            return Container(
              padding: const EdgeInsets.all(5),
              color: Colors.lightGreenAccent,
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 30,),
                  Text(index.toString())
                ],
              ) // RecentWidget(recent: recents[index],),
            );
          }
      ),

    );
  }
}
