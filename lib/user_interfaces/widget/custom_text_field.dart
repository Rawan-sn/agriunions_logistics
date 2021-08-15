import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    required this.width,
    this.margin = EdgeInsets.zero,
    required this.label,
    required this.onChanged,
    required this.onSubmitted,
    required this.onTap,
    required this.prefixIcon,
    this.focusNode,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  final double width;
  final EdgeInsets margin;
  final String label;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final Function() onTap;
  final Widget prefixIcon;
  final FocusNode? focusNode;
  final bool isPassword;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _showEye = false;
  bool _passwordIsEncrypted = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800),
      width: widget.width,
      padding: widget.margin,
      child: TextField(
        focusNode: widget.focusNode != null ? widget.focusNode : null,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          contentPadding:
              new EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
          labelText: widget.label,
          labelStyle: TextStyle(
            fontSize: 15.0,
            color: Colors.black45,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45, width: 1.5),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black45, width: 1.5),
            borderRadius: BorderRadius.circular(30),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: Colors.transparent,
          prefixIcon: Container(
            padding:
                const EdgeInsets.only(left: 10, top: 4, right: 18, bottom: 4),
            width: 20,
            child: widget.prefixIcon,
          ),
          suffixIcon: widget.isPassword
              ? _showEye
                  ? GestureDetector(
                      child: _passwordIsEncrypted
                          ? Container(
                              width: 25,
                              height: 25,
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage('assets/icons/hidden.png'),
                                width: 20,
                                color: Colors.black45,
                              ),
                            )
                          : Container(
                              width: 25,
                              height: 25,
                              padding: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage('assets/icons/visible.png'),
                                width: 20,
                                color: Colors.black45,
                              ),
                            ),
                      onTap: () {
                        setState(() {
                          _passwordIsEncrypted = !_passwordIsEncrypted;
                        });
                      },
                    )
                  : null
              : null,
        ),
        obscureText: widget.isPassword
            ? _showEye
                ? _passwordIsEncrypted
                : true
            : false,
        style: TextStyle(
          color: Colors.black45,
          fontSize: 15, //FontSizes.text
        ),
        onTap: widget.onTap,
        onChanged: (enteredValue) {
          widget.onChanged(enteredValue);
          if (widget.isPassword) {
            if (enteredValue.isEmpty) {
              setState(() {
                _showEye = false;
              });
            } else {
              if (!_showEye) {
                setState(() {
                  _showEye = !_showEye;
                });
              }
            }
          }
        },
        onSubmitted: widget.onSubmitted,
      ),
    );
  }
}
