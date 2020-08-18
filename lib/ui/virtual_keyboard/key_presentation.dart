part of virtual_keyboard;

class KeyPresentation extends StatefulWidget {
  KeyPresentation({@required this.symbols, this.alt = false});

  final Pair<dynamic, dynamic> symbols;
  final bool alt;

  @override
  State<StatefulWidget> createState() {
    return _KeyPresentation();
  }
}

class _KeyPresentation extends State<KeyPresentation> {
  @override
  Widget build(BuildContext context) {
    final symbols = widget.symbols;
    final alt = widget.alt;
    final viewValue = (alt ? symbols.second : symbols.first) ?? symbols.first;
    final altViewValue = (alt ? symbols.first : symbols.second) ?? null;
    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: viewValue is String
              ? Text(viewValue)
              : viewValue is IconData ? Icon(viewValue) : viewValue,
        ),
        _getAltValue(altViewValue)
      ],
    );
  }

  Widget _getAltValue(dynamic val) {
    final symbols = widget.symbols;
    return (val == null || symbols.second == null)
        ? Container()
        : Container(
            alignment: Alignment.topRight,
            padding: EdgeInsets.all(10),
            child: val is String
                ? Text(val, style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.5)))
                : (val is IconData
                    ? Icon(val, size: 10, color: Colors.white.withOpacity(0.5))
                    : null));
  }
}
