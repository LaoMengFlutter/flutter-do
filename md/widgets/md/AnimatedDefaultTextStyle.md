---
title: 'AnimatedDefaultTextStyle'
description: '控件介绍'
type: widgets
---



## AnimatedDefaultTextStyle

TextStyle属性动画，用法如下：

```dart
class AnimationDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimationDemo();
}

class _AnimationDemo extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  TextStyle _style;
  @override
  void initState() {
    _style=TextStyle(color: Colors.blue, fontSize: 14);
  super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 200,),
        AnimatedDefaultTextStyle(
          style: _style,
          duration: Duration(seconds: 2),
          child: Text('老孟'),
        ),
        SizedBox(height: 100,),
        RaisedButton(
          onPressed: (){
            setState(() {
              _style = TextStyle(color: Colors.red, fontSize: 24);
            });
          },
        )
      ],
    );
  }

}
```

效果如下：

![](../img/AnimatedDefaultTextStyle/DefaultTextStyleTransition.gif)

