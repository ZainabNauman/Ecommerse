import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  final List<String> categories;

  const CategoryRow(this.categories, {super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.transparent,
      height: 
      screenWidth<650 ?screenWidth*0.15
      :screenWidth>650&&screenWidth<750 ?screenWidth*0.13
      :screenWidth>750&&screenWidth<850 ?screenWidth*0.11
      :screenWidth>850&&screenWidth<950 ?screenWidth*0.11
      :screenWidth>950&&screenWidth<1050 ?screenWidth*0.1
      :screenWidth>1050&&screenWidth<1150 ?screenWidth*0.09
      :screenWidth>1150&&screenWidth<1250 ?screenWidth*0.09
      :screenWidth>1250&&screenWidth<1350 ?screenWidth*0.09
      :screenWidth>1350&&screenWidth<1450 ?screenWidth*0.085
      :screenWidth>1450&&screenWidth<1600 ?screenWidth*0.08
      :screenWidth*0.1,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:  EdgeInsets.all(screenWidth*0.015),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  categories[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
