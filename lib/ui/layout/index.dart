import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

const backgroundStartColor = Color(0xFFFFD500);
const backgroundEndColor = Color(0xFFF6A00C);

class Layout extends StatefulWidget {
  final Widget? child;

  const Layout({Key? key, this.child}) : super(key: key);

  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  @override
  Widget build(BuildContext context) {
    renderHeader() {
      if (Platform.isAndroid) {
        return Container();
      }
      return Container(
        color: Color(0xFF388E3C),
        child: WindowTitleBarBox(
            child: Row(
                children: [Expanded(child: MoveWindow()), WindowButtons()])),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          renderHeader(),
          Expanded(
              child: Container(
            child: widget.child,
          ))
        ],
      ),
    );
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: Color(0xFFFFFFFF),
    mouseOver: Color(0x22000000),
    mouseDown: Color(0x11000000),
    iconMouseOver: Color(0xFFFFFFFF),
    iconMouseDown: Color(0xFFFFFFFF));

final closeButtonColors = WindowButtonColors(
    mouseOver: Color(0xFFD32F2F),
    mouseDown: Color(0xFFB71C1C),
    iconNormal: Color(0xFFFFFFFF),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
