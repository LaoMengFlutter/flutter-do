import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

const Duration _duration = Duration(seconds: 1);

///
/// des:
///
class ContainerAnimationsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: OpenContainer(
          transitionDuration: _duration,
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return Container(
              width: 300,
              height: 45,
              padding: EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(.5))),
              alignment: Alignment.centerLeft,
              child: Icon(Icons.search,color: Colors.black,),
            );
          },
          openBuilder: (BuildContext context, VoidCallback _) {
            return _DetailPage();
          },
        ),
      ),
      body: _buildListView(),
      floatingActionButton: OpenContainer(
        openBuilder: (BuildContext context, VoidCallback _) {
          return _DetailPage();
        },
        transitionDuration: _duration,
        closedElevation: 6.0,
        closedShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        closedColor: Theme.of(context).colorScheme.secondary,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return SizedBox(
            height: 50,
            width: 50,
            child: Center(
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          );
        },
      ),
    );
  }

  _buildGridView() {
    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 2, mainAxisSpacing: 4),
      itemBuilder: (context, index) {
        return OpenContainer(
          transitionDuration: _duration,
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return Container(
              child: Image.asset(
                'assets/images/b.jpg',
                fit: BoxFit.fitWidth,
              ),
            );
          },
          openBuilder: (BuildContext context, VoidCallback _) {
            return _DetailPage();
          },
        );
      },
      itemCount: 50,
    );
  }

  _buildListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return OpenContainer(
          transitionDuration: _duration,
          closedBuilder: (BuildContext _, VoidCallback openContainer) {
            return Card(
              child: Container(
                height: 45,
                alignment: Alignment.center,
                child: Text('$index'),
              ),
            );
          },
          openBuilder: (BuildContext context, VoidCallback _) {
            return _DetailPage();
          },
        );
      },
      itemCount: 50,
    );
  }
}

class _OpenContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionDuration: _duration,
      closedBuilder: (BuildContext _, VoidCallback openContainer) {
        return Container(
          child: Image.asset(
            'assets/images/b.jpg',
            fit: BoxFit.fitWidth,
          ),
        );
      },
      openBuilder: (BuildContext context, VoidCallback _) {
        return _DetailPage();
      },
    );
  }
}

class _DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          'assets/images/b.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
