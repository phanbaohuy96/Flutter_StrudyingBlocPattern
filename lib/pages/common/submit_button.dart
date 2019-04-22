import 'package:flutter/material.dart';
import '../../styles/ColorsStyle.dart';
import 'dart:async';

class SubmitButton extends StatefulWidget {

  final Size size;
  final Function onTap;
  final Text text;

  const SubmitButton({Key key, this.size, this.onTap, this.text}) : super(key: key);

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}
enum ButtonStatus{
  original,
  tranform,
  loadding,
  rollback
}

class _SubmitButtonState extends State<SubmitButton> with SingleTickerProviderStateMixin{
  
  Size _buttonSize;
  ButtonStatus _buttonStatus = ButtonStatus.original;

  AnimationController _controller;
  Animation<double> _valueWidth, _rollbackWidthValue;


  @override
  void initState()
  {
    _buttonSize = widget.size;
    _controller = new AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _controller.addListener(() => setState(() {}) );
    _controller.addStatusListener((status){
      if(status == AnimationStatus.completed)
      {
        _buttonStatus = ButtonStatus.loadding;
        if(_buttonStatus == ButtonStatus.loadding)
          _buttonSize = Size(widget.size.height, widget.size.height);
      }
    });

    _valueWidth = new Tween(begin: widget.size.width, end: widget.size.height).animate(_controller);
    _rollbackWidthValue = new Tween(begin: widget.size.height, end: widget.size.width).animate(_controller);
    super.initState();
  }

  _getWidth()
  {
    if(_buttonStatus == ButtonStatus.loadding || _buttonStatus == ButtonStatus.tranform)
      return _valueWidth.value;
    else if(_buttonStatus == ButtonStatus.rollback)
      return _rollbackWidthValue.value;
    return widget.size.width;
  }

  _getChild()
  {
    if(_buttonStatus == ButtonStatus.loadding)
      return CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white));
    return widget.text;
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () async {
        if(_buttonStatus != ButtonStatus.loadding)
        {
          if(widget.onTap != null) widget.onTap();
          _buttonStatus = ButtonStatus.tranform;
          _controller.reset();
          await _controller.forward();
          _buttonStatus = ButtonStatus.loadding;
          await Future.delayed(Duration(seconds: 1));
          
          _controller.reset();
          setState(() {
            _buttonStatus = ButtonStatus.rollback;
          });

          await _controller.forward();
          setState(() {
            _buttonStatus = ButtonStatus.original;                
          });
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