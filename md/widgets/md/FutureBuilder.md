---
title: 'FutureBuilder'
description: '控件介绍'
type: widgets

---

# FutureBuilder

### 展示异步任务状态

当有一个Future（异步）任务需要展示给用户时，可以使用FutureBuilder控件来完成，比如向服务器发送数据成功时显示成功提示：
```
var _future = Future.delayed(Duration(seconds: 3), () {
    return '老孟，一个有态度的程序员';
  });

FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        var widget;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            widget = Icon(
              Icons.error,
              color: Colors.red,
              size: 48,
            );
          } else {
            widget = Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 36,
            );
          }
        } else {
          widget = Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          );
        }

        return Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: widget,
          ),
        );
      },
    );
```
效果如下：

![](../img/FutureBuilder/20200221132718431.gif)

在Future任务中出现异常如何处理，下面模拟出现异常，修改`_future`:
```
var _future = Future.delayed(Duration(seconds: 3), () {
    return Future.error('');
  });
```
效果如下：

![](../img/FutureBuilder/20200221135229907.gif)

`builder`是FutureBuilder的构建函数，在这里可以判断状态及数据显示不同的UI，
ConnectionState的状态包含四种：`none`、`waiting`、`active`、`done`，但我们只需要关注`done`状态，此状态表示Future执行完成，`snapshot`参数的类型是`AsyncSnapshot<T>`。

### ListView加载网络数据

FutureBuilder还有一个比较常用的场景：网络加载数据并列表展示，这是一个非常常见的功能，在网络请求过程中显示loading，请求失败时显示失败UI，成功时显示成功UI。

模拟成功网络请求，通常会返回json字符串：
```
var _future = Future.delayed(Duration(seconds: 3), () {
    return 'json 字符串';
  });
```
构建FutureBuilder控件：
```
FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        var widget;
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            widget = _loadingErrorWidget();
          } else {
            widget = _dataWidget(snapshot.data);
          }
        } else {
          widget = _loadingWidget();
        }
        return widget;
      },
    );
```

构建loading控件：
```
_loadingWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: CircularProgressIndicator(),
      ),
    );
  }
```
构建网络加载失败控件：
```
_loadingErrorWidget() {
    return Center(
      child: Text('数据加载失败，请重试。'),
    );
  }
```
数据加载成功，构建数据展示控件：
```
_dataWidget(data) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          height: 60,
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: TextStyle(fontSize: 20),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: 10,
    );
  }
```
效果如下：

![](../img/FutureBuilder/20200221161622309.gif)

模拟网络加载失败：
```
var _future = Future.delayed(Duration(seconds: 3), () {
    return Future.error('');
  });
```
效果如下：

![](../img/FutureBuilder/2020022114581227.gif)

通过上面的示例说明FutureBuilder控件极大的简化了异步任务相关显示的控件，不再需要开发者自己维护各种状态以及更新时调用`State.setState`。

### 防止FutureBuilder重绘

FutureBuilder是一个StatefulWidget控件，如果在FutureBuilder控件节点的父节点重绘`rebuild`，那么FutureBuilder也会重绘，这不仅耗费不必要的资源，如果是网络请求还会消耗用户的流量，这是非常糟糕的体验，如何解决这个问题？

通过源代码发现FutureBuilder重绘逻辑是这样的：
```
@override
  void didUpdateWidget(FutureBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.future != widget.future) {
      if (_activeCallbackIdentity != null) {
        _unsubscribe();
        _snapshot = _snapshot.inState(ConnectionState.none);
      }
      _subscribe();
    }
  }
```
FutureBuilder在重建时判断旧的`future`和新的`future`是否相等，如果不相等才会重建，所以我们只需要让其相等即可，有人可能会以为设置的`future`是同一个函数，如下：
```
 _future() async{
    ...
  }

FutureBuilder(
	future: _future(),
	...
)
```
上面的方式是不相等的，是错误的用法，可以将_future方法赋值给变量：

```
var _mFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mFuture = _future();
  }

 _future() async{
    ...
  }

FutureBuilder(
	future: _mFuture,
	...
)
```











