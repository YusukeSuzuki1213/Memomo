import 'package:flutter/material.dart';

class ListTileWithId extends ListTile{
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final bool isThreeLine;
  final bool dense;
  final bool enabled;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPress;
  final bool selected;
  final int index;

  ListTileWithId({
    Key key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine: false,
    this.dense,
    this.enabled: true,
    this.onTap,
    this.onLongPress,
    this.selected: false,
    this.index,
  }) :super(
      key:key,
      leading:leading,
      title:title,
      subtitle:subtitle,
      trailing:trailing,
      isThreeLine:isThreeLine,
      dense:dense,
      enabled:enabled,
      onTap:onTap,
      onLongPress:onLongPress,
      selected:selected);

  int get getIndex => index;
}
