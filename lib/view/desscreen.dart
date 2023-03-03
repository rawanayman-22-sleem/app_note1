import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:share_plus/share_plus.dart';
import '../constant.dart';
import '../contrrol/helpnote.dart';
import 'homescreen.dart';


class DescriptionScreen extends StatefulWidget {
  var id;
  var description;
  var title;
  var date;
  var done;
  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
  DescriptionScreen({
    required this.id,
    required this.description,
    required this.title,
    required this.date,
    required this.done,
  });
}


class _DescriptionScreenState extends State<DescriptionScreen> {
  HawkFabMenuController hawkFabMenuController = HawkFabMenuController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: textcolor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text(
          "Note",
          style: TextStyle(color: textcolor, fontSize: fontLarge),
        ),
        backgroundColor: primarydarkcolor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(RadiusCircular),
                bottomRight: Radius.circular(RadiusCircular))),
      ),
      backgroundColor: primarycolor,
      body: HawkFabMenu(
        icon: AnimatedIcons.menu_arrow,
        fabColor: primarydarkcolor,
        iconColor: primarycolor,
        hawkFabMenuController: hawkFabMenuController,
        items: [
          HawkFabMenuItem(
            label: 'Delete',
            ontap: () {
              HelpNote().delet_DB_ByID(int.parse('${widget.id}')).then((value) {
                print("value $value");
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return HomeScreen();
                    }), (Route<dynamic> route) => false);
              });
            },
            icon: const Icon(Icons.delete),
            color: Colors.black,
            labelColor: Colors.black
          ),
          HawkFabMenuItem(
              label: 'Edit',
              ontap: () {
                _displayTextInputDialog(context, "${widget.description}");
              },
              icon: const Icon(Icons.edit),
              labelColor: textcolor,
              labelBackgroundColor: primarydarkcolor,
              color: primarydarkcolor),
          HawkFabMenuItem(
            label: 'Share',
            ontap: () {
              Share.share("""From ToDo App ( ^ _ ' ) ${widget.title} ${widget.date} ${widget.description}"""); },
            icon: const Icon(Icons.share_outlined),
          ), ],

        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.title}",
                    style: TextStyle(
                        color: textcolor,
                        fontSize: fontXSmall,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${widget.date}",
                      style: TextStyle(
                          color: textcolor,
                          fontSize: fontsubtitel,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizedBoxheight,
              ),
              Text(
                "${widget.description}",
                style: TextStyle(
                    color: textcolor,
                    fontSize: fontsubtitel,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String? valueText;
  TextEditingController discriptionController = TextEditingController();
  Future<void> _displayTextInputDialog(
      BuildContext context, String Discription) async {
    discriptionController.text = Discription;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Discription'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;});  },
              controller: discriptionController,
              decoration: InputDecoration(hintText: "Text "),
            ),
            actions: <Widget>[
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: primarydarkcolor),
                onPressed: () {
                  HelpNote()
                      .update_DB_ByID(
                      discriptionController.text, int.parse('${widget.id}'))
                      .then((value) {
                    Navigator.of(context).pop();}); },
                icon: Icon(Icons.add, color: textcolor),
                label: Text(
                  "ADD",
                  style: TextStyle(color: textcolor),
                ),
              )
            ],
          );
       });
    }
}