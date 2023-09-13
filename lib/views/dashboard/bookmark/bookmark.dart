import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/bookmark_provider.dart';
import '../../../provider/person_provider.dart'; 
import '../../../utils/helper_function.dart';
import '../../../utils/responsive_class.dart';
import '../../../utils/string_constant.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_chachenetwork_image.dart';
import '../../../widgets/custom_showdialog.dart';
import '../../../widgets/ratingbar.dart';
import '../home/itemDetail/itemdetail_desktopscreen.dart';
import '../home/itemDetail/itemdetail_screen.dart';

class BookmarkPage extends StatefulWidget {
  const BookmarkPage({super.key});

  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
 @override
void didChangeDependencies() {
  super.didChangeDependencies();
  final bookmarkProvider = Provider.of<BookmarkProvider>(context, listen: false);
  final userData = Provider.of<UserDataProvider>(context, listen: false);
  bookmarkProvider.loadBookmarks(userData.profileData.uid);
}

  @override
  Widget build(BuildContext context) {
    Size size = responseMediaQuery(context);
    final userData = Provider.of<UserDataProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Bookmark Items'),
      body: Consumer<BookmarkProvider>(
         builder: (context, bookmarkProvider, child) {
        final bookmarkedItems = bookmarkProvider.bookmarkedItems;
        return ListView.builder(
          itemCount: bookmarkedItems.length,
          itemBuilder: (context, index) {
            final item = bookmarkedItems[index];
            return Dismissible(
              key: Key(item.name),
              confirmDismiss: (direction) {
                return showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDeleteConfirmationDialog(
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                      onConfirm: () {
                        Navigator.of(context).pop();
                        bookmarkProvider.removeItemFromBookMark(context, item, userData.profileData.uid);
                         setState(() {});
                      },
                      button1text: StringConstant.button1text,
                      button2text: StringConstant.button2text,
                      description: StringConstant.description,
                      heading: StringConstant.heading,
                    );
                  });
              },
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDeleteConfirmationDialog(
                      onCancel: () {
                        Navigator.of(context).pop();
                      },
                      onConfirm: () {
                        Navigator.of(context).pop();
                        bookmarkProvider.removeItemFromBookMark(context, item, userData.profileData.uid);
                        setState(() {});
                      },
                      button1text: StringConstant.button1text,
                      button2text: StringConstant.button2text,
                      description: StringConstant.description,
                      heading: StringConstant.heading,
                    );
                  });
              },
              background: Padding(padding: EdgeInsets.fromLTRB(size.width * 0.04,size.width * 0.025,size.width * 0.04,size.width * 0.025),
                child: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(Icons.delete,color: Colors.white))),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Responsive.isMobile(context)
                        ? IndividualItem(item: item)
                        : IndividualItemDesktop(item: item);
                  }));
                },
                child: Padding(padding: EdgeInsets.all(size.width * 0.03),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),border: Border.all(color: Colors.black)),
                    child: Row(children: [
                        Expanded(flex: 4,
                          child: Padding(padding: EdgeInsets.all(size.width * 0.02),
                            child: Container(
                              height: size.width * 0.3,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: CustomCachedNetworkImage(imageUrl: item.img))))),
                        Expanded(flex: 5,
                          child: Padding(padding: EdgeInsets.only(left: size.width * 0.04,top: size.width * 0.025,bottom: size.width * 0.025),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,children: [
                                  Text(item.name,style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.bold,fontSize: size.width * 0.06)),
                                  Text(item.price,style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.normal,fontSize: size.width * 0.05)),
                                  Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment:CrossAxisAlignment.center,children: [
                                        RatingBarWidget(),
                                        Text("(0 Reviews)",
                                            style: TextStyle(fontFamily: StringConstant.font,fontWeight: FontWeight.normal,fontSize: size.width * 0.03))])]))),
                        Expanded(flex: 1,
                            child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDeleteConfirmationDialog(
                                        onCancel: () {
                                          Navigator.of(context).pop();
                                        },
                                        onConfirm: () {
                                          bookmarkProvider.removeItemFromBookMark(context,item,userData.profileData.uid);
                                              setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                        button1text: StringConstant.button1text,
                                        button2text: StringConstant.button2text,
                                        description:StringConstant.descriptionbookMark,
                                        heading: StringConstant.heading);
                                    });
                                },
                                child: const Icon(Icons.bookmark_added)))])))));
          });
        }));
  }
}
