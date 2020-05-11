import 'package:flutter/material.dart';

class ChipsTextField extends StatefulWidget {
  @override
  _ChipsTextFieldState createState() => _ChipsTextFieldState();
}

class _ChipsTextFieldState extends State<ChipsTextField> {
  double initialSize = 150;
  double textFieldWidth = 150;
  double wordWidth = 14;
  TextEditingController controller = TextEditingController();
  List<String> elements = [];
  List<String> recommendedOptions = [
    "Raul Rodriguez",
    "",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    List<Widget> _children = [];
    elements.forEach((String element) {
      _children.add(Chip(label: Text(element)));
    });
    _children.add(_buildTextField());

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Wrap(children: _children),
          Container(),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      width: textFieldWidth,
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 12),
        maxLines: null,
        onChanged: (String value) {
          if (value.length * wordWidth < MediaQuery.of(context).size.width) {
            setState(() {
              if (value.length * wordWidth >= initialSize) {
                textFieldWidth = value.length * wordWidth;
              } else {
                textFieldWidth = initialSize;
              }
            });
          }
        },
        onSubmitted: (String value) {
          setState(() {
            elements.add(value);
          });
        },
        decoration: InputDecoration(
            hintText: "Type here...",
            suffixIcon: _buildAddButton(),
            border: InputBorder.none),
      ),
    );
  }

  Widget _buildAddButton() {
    return FlatButton.icon(
      color: Colors.grey,
      icon: Icon(
        Icons.add,
        color: Colors.white,
      ),
      onPressed: () {
        setState(() {
          elements.add(controller.value.text);
        });
      },
      label: Text(
        "add",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
