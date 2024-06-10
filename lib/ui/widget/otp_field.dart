import 'package:flutter/material.dart';

class OTPTextField extends StatefulWidget {
  final int ?length;

  final double? width;

  final double ?fieldWidth;

  final TextInputType ?keyboardType;

  final TextStyle ?style;

  final MainAxisAlignment ?textFieldAlignment;

  final bool ?obscureText;

  final ValueChanged<String>? onChanged;

  final ValueChanged<String> ?onCompleted;

  OTPTextField(
      {Key? key,
        this.length = 4,
        this.width = 10,
        this.fieldWidth = 30,
        this.keyboardType = TextInputType.number,
        this.style = const TextStyle(),
        this.textFieldAlignment = MainAxisAlignment.spaceBetween,
        this.obscureText = false,
        this.onChanged,
        this.onCompleted})
      : assert(length! > 1);

  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  List<FocusNode>? _focusNodes;
  List<TextEditingController>? _textControllers;

  List<Widget>? _textFields;
  List<String>? _pin;

  @override
  void initState() {
    super.initState();
    _focusNodes = List<FocusNode?>.filled(widget.length!, null, growable: false).cast<FocusNode>();
    _textControllers = List<TextEditingController?>.filled(widget.length!, null, growable: false).cast<TextEditingController>();
    _pin = List.generate(widget.length!, (int i) {
      return '';
    });
    _textFields = List.generate(widget.length!, (int i) {
      return buildTextField(context, i);
    });
  }

  @override
  void dispose() {
    _textControllers!
        .forEach((TextEditingController controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,

      child: Row(
        mainAxisAlignment: widget.textFieldAlignment!,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _textFields!,
      ),
    );
  }

  Widget buildTextField(BuildContext context, int i) {
    if (_focusNodes![i] == null) _focusNodes![i] = new FocusNode();

    if (_textControllers![i] == null)
      _textControllers![i] = new TextEditingController();

    return Container(
      width: widget.fieldWidth,
      child: TextField(
        controller: _textControllers![i],
        keyboardType: widget.keyboardType,
        textAlign: TextAlign.center,
        style: widget.style,
        focusNode: _focusNodes![i],
        obscureText: widget.obscureText!,
        decoration: InputDecoration(
            counterText: "",
            border: UnderlineInputBorder(
                borderSide: BorderSide(width: widget.fieldWidth!))),
        onChanged: (String str) {
          if (str.length > 1) {
            _handlePaste(str);
            return;
          }

          if (str.isEmpty) {
            if (i == 0) return;
            _focusNodes![i].unfocus();
            _focusNodes![i - 1].requestFocus();
          }

          setState(() {
            _pin![i] = str;
          });

          if (str.isNotEmpty) _focusNodes![i].unfocus();

          if (i + 1 != widget.length && str.isNotEmpty)
            FocusScope.of(context).requestFocus(_focusNodes![i + 1]);

          String currentPin = _getCurrentPin();

          if (!_pin!.contains(null) &&
              !_pin!.contains('') &&
              currentPin.length == widget.length) {
            widget.onCompleted!(currentPin);
          }

          widget.onChanged!(currentPin);
        },
      ),
    );
  }

  String _getCurrentPin() {
    String currentPin = "";
    _pin!.forEach((String value) {
      currentPin += value;
    });
    return currentPin;
  }

  void _handlePaste(String str) {
    if (str.length > widget.length!) {
      str = str.substring(0, widget.length);
    }

    for (int i = 0; i < str.length; i++) {
      String digit = str.substring(i, i + 1);
      _textControllers![i].text = digit;
      _pin![i] = digit;
    }

    FocusScope.of(context).requestFocus(_focusNodes![widget.length! - 1]);

    String currentPin = _getCurrentPin();

    if (!_pin!.contains(null) &&
        !_pin!.contains('') &&
        currentPin.length == widget.length) {
      widget.onCompleted!(currentPin);
    }

    widget.onChanged!(currentPin);
  }
}
