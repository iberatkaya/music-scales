import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  final void Function() onPressed;
  final Widget icon;
  final String title;
  final String subtitle;
  final Color color;
  final int titleSize;
  final int subtitleSize;
  const ButtonCard({
    @required this.onPressed,
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    @required this.color,
    @required this.titleSize,
    @required this.subtitleSize,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onPressed: onPressed,
      color: color,
      padding: EdgeInsets.symmetric(vertical: 36),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: titleSize.toDouble(),
                    fontWeight: FontWeight.w300),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: icon,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: subtitleSize.toDouble(),
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.center,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
