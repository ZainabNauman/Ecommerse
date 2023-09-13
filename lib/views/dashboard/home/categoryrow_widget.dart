import 'package:ecommerse/models/category_model.dart';
import 'package:ecommerse/utils/color_constant.dart';
import 'package:ecommerse/utils/helper_function.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_chachenetwork_image.dart';
import 'category_add.dart';

class CategoryRow extends StatefulWidget {
  final void Function(int) onCategoryTapped;
  String personBrand;

  CategoryRow({super.key, required this.onCategoryTapped, required this.personBrand});

  @override
  State<CategoryRow> createState() => _CategoryRowState();
}

class _CategoryRowState extends State<CategoryRow> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Size size = responseMediaQuery(context);
    return StreamBuilder<List<CategoryModel>>(
      stream: getCategoryData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(color: ColorConstant.primaryColor, strokeWidth: 2);
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List<CategoryModel>? categories = snapshot.data;
        if (categories == null || categories.isEmpty) {
          return const Text('No categories found.');
        }
        return Container(
          color: Colors.transparent,
          height: size.width * 0.25,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  widget.onCategoryTapped(index);
                },
                child: Stack(children: [
                    Container(
                      margin: EdgeInsets.only(left: size.width * 0.03, right: size.width * 0.03, top: size.width * 0.01),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.transparent),
                      child: ClipRRect(borderRadius: BorderRadius.circular(15),
                        child: Column(children: [
                            ClipRRect(borderRadius: BorderRadius.circular(15),
                              child: CustomCachedNetworkImage(
                                imageUrl: categories[index].imageUrl,
                                height: responseSize(screenWidth * 0.18, context),
                                errorWidth: size.width * 0.2)),
                            SizedBox(height: screenWidth * 0.012),
                            Text(categories[index].title,
                              style: const TextStyle(color: Colors.black, fontSize: 14),
                              textAlign: TextAlign.center)]))),
                    if (widget.personBrand.trim().isNotEmpty)
                      Positioned(right: size.width * 0,top: size.width * 0,
                        child: Material(
                          elevation: 7, 
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryAddScreen(index: index, context: context)));
                            },
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.white),
                              child: const Icon(Icons.add, color: ColorConstant.primaryColor)))))]));
            }));
      });
  }
}
