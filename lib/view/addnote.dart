import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../constant.dart';
import '../contrrol/helpnote.dart';
import 'homescreen.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var dateTime;

  TextEditingController dateTimeController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();

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
            "Add Note",
            style: TextStyle(color: textcolor, fontSize: fontLarge),
          ),
          backgroundColor: primarydarkcolor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(RadiusCircular),
                  bottomRight: Radius.circular(RadiusCircular))),
        ),

        backgroundColor: primarycolor,
        body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Enter Title",
                      labelStyle: TextStyle(color: green),
                      labelText: "Title",
                      fillColor: primarydarkcolor,
                      helperStyle: TextStyle(color: primarydarkcolor),
                      contentPadding: EdgeInsets.all(DPadding),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                          borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                          disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                          borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                          enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                          borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: dateTimeController,
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      DatePicker.showDatePicker(
                        context,
                        currentTime: DateTime.now(),
                        locale: LocaleType.en,
                        maxTime: DateTime(2030, 1, 1),
                        minTime: DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day),
                        onChanged: (data) {
                          setState(() {
                            dateTime = "${data.year}/${data.month}/${data.day}";
                            dateTimeController.text = dateTime;}); },

                        onConfirm: (data) {
                          setState(() {
                            dateTime = "${data.year}/${data.month}/${data.day}";
                            dateTimeController.text = dateTime;
                          });},); },

                    decoration: InputDecoration(
                      hintText: "",
                      labelStyle: TextStyle(color: green),
                      labelText: "Date",
                      fillColor: primarydarkcolor,
                      helperStyle: TextStyle(color: primarydarkcolor),
                      contentPadding: EdgeInsets.all(DPadding),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                          borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                           disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                          borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                           enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                          borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: discriptionController,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: "Enter Discription",
                      labelStyle: TextStyle(color: green),
                      labelText: "Discription",
                      fillColor: primarydarkcolor,
                      helperStyle: TextStyle(color: primarydarkcolor),
                      contentPadding: EdgeInsets.all(DPadding),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                          borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                           disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                          borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                          enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(DPadding)),
                          borderSide:
                          BorderSide(color: primarydarkcolor, width: 0.5)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(primary: primarydarkcolor),
                    onPressed: () {
                      HelpNote().insertdb({
                        "description": discriptionController.text.toString(),
                        "title": titleController.text.toString(),
                        "date": dateTimeController.text.toString(),
                        "done": "0",
                      }).then((value) {
                        print("value $value");
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return HomeScreen();
                            }),
                                (Route<dynamic> route) => false);});},
                    icon: Icon(Icons.add, color: textcolor),
                    label: Text(
                      "ADD",
                      style: TextStyle(color: textcolor),
                    ),
                  )
                ],
              ),
            ),
           ),
       );
   }
}