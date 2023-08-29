import 'package:flutter/material.dart';

import '../models/item_model.dart';

class ItemGrid extends StatelessWidget {
  final List<ItemModel> projects;

  const ItemGrid(this.projects, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        //mainAxisSpacing: 10.0,
        //crossAxisSpacing: 10.0,
      ),
      itemCount: projects.length,
      itemBuilder: (BuildContext context, int index) {
        return GridTile(       
          child: Padding(
            padding:  EdgeInsets.all(screenWidth*0.01),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(projects[index].img,height: screenWidth*0.3,width: screenWidth*0.3),
                  SizedBox(height: screenWidth*0.03),
                  Text(projects[index].name),
                  Text(projects[index].price),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}