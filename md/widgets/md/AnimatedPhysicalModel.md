---
title: 'AnimatedPhysicalModel'
description: '对PhysicalModel组件进行动画'
type: widgets
---



# AnimatedPhysicalModel

AnimatedPhysicalModel组件为动画组件，对PhysicalModel组件进行动画，用法如下：


```dart
@override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            child: Text('动画'),
            onPressed: () {
              setState(() {
                _animated = !_animated;
              });
            },
          ),
          _buildAnimatedPhysicalModel(),
        ],
      ),
    );
  }

  bool _animated = false;

  _buildAnimatedPhysicalModel() {
    return AnimatedPhysicalModel(
      borderRadius: BorderRadius.circular(_animated ? 20 : 10),
      shape: BoxShape.rectangle,
      color: _animated ? Colors.blue : Colors.red,
      elevation: _animated ? 18 : 8,
      shadowColor: !_animated ? Colors.blue : Colors.red,
      child: Container(
        height: 100,
        width: 100,
      ),
      duration: Duration(seconds: 1),
    );
  }
```

效果如下：

![](../img/AnimatedPhysicalModel/AnimatedPhysicalModel_1.gif)

