import 'package:flutter/material.dart';
import '../../styles/ColorsStyle.dart';
import 'dart:async';

class SubmitButton extends StatefulWidget {

  final Size size;
  final Function onTap;
  final Text text;
  final ButtonStatus status;

  SubmitButton({ this.size, this.onTap, this.text, this.status}) : super(key: UniqueKey());

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}
enum ButtonStatus{
  original,
  tranform,
  rollback
}

class _SubmitButtonState extends State<SubmitButton> with SingleTickerProviderStateMixin{
  
  Size _buttonSize;

  AnimationController _controller;
  Animation<double> _valueWidth, _rollbackWidthValue;



  @override
  void initState()
  {
    _buttonSize = widget.size;
    _controller = new AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _controller.addListener(() => setState(() {}) );
    _controller.addStatusListener((status) {      
      setState(() {
        
      });
    });

    _valueWidth = new Tween(begin: widget.size.width, end: widget.size.height).animate(_controller);
    _rollbackWidthValue = new Tween(begin: widget.size.height, end: widget.size.width).animate(_controller);
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _getWidth()
  {
    if( widget.status == ButtonStatus.tranform)
      return _valueWidth.value;
    else if(widget.status == ButtonStatus.rollback)
      return _rollbackWidthValue.value;
    return widget.size.width;
  }

  _getChild()
  {
    if(widget.status == ButtonStatus.tranform && _valueWidth.value == _buttonSize.height)
      return CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
    return widget.text;
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () async {
        if(widget.status == ButtonStatus.original || (_controller.status != AnimationStatus.forward && widget.status == ButtonStatus.rollback))
        {
          if(widget.onTap != null) widget.onTap();
        }              
      },
      child: Container(
        width: _getWidth(),
        height: _buttonSize.height,
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_buttonSize.height * 0.5),
          color: primaryColor
        ),
        child: Align(
          alignment: Alignment.center,
          child: _getChild()
        ),
      ),
    );
  }
}