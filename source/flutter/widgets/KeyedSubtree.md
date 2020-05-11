---
title: 'KeyedSubtree'
description: '将Key附加到子控件上'
type: widgets
---



## KeyedSubtree

KeyedSubtree提供了一种简便的给子控件添加key的方法。

用法如下：

```dart
KeyedSubtree(
  key: GlobalKey(),
  child: Container(),
)
```

通常使用其提供的2个构建方法：`KeyedSubtree.wrap`和`ensureUniqueKeysForList`

`KeyedSubtree.wrap`返回一个带key的组件，用法如下：

```dart
KeyedSubtree.wrap(child, itemIndex)
```

`ensureUniqueKeysForList`返回多个带key的组件，key是当前子控件集合的索引，用法如下：

```dart
KeyedSubtree.ensureUniqueKeysForList(widget.children)
```

