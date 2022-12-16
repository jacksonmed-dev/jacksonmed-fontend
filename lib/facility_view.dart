import 'package:flutter/material.dart';

import 'patient_form.dart';
import 'patients.dart';

class FacilityView extends StatefulWidget {
  const FacilityView({super.key});

  @override
  State<FacilityView> createState() => _FacilityViewState();
}

class _FacilityViewState extends State<FacilityView> {
  final facilityName = 'Jackson Medical Solutions';

  bool isSelectionMode = false;
  final int listLength = 30;
  late List<bool> _selected;
  bool _selectAll = false;
  bool _isGridMode = false;

  List<Patient> patients = [];

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    _selected = List<bool>.generate(listLength, (_) => false);
  }

  @override
  void dispose() {
    _selected.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Facility Overview',
          ),
          leading: isSelectionMode
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      isSelectionMode = false;
                    });
                    initializeSelection();
                  },
                )
              : const SizedBox(),
          actions: <Widget>[
            if (_isGridMode)
              IconButton(
                icon: const Icon(Icons.grid_on),
                onPressed: () {
                  setState(() {
                    _isGridMode = false;
                  });
                },
              )
            else
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  setState(() {
                    _isGridMode = true;
                  });
                },
              ),
            if (isSelectionMode)
              TextButton(
                  child: !_selectAll
                      ? const Text(
                          'select all',
                          style: TextStyle(color: Colors.white),
                        )
                      : const Text(
                          'unselect all',
                          style: TextStyle(color: Colors.white),
                        ),
                  onPressed: () {
                    _selectAll = !_selectAll;
                    setState(() {
                      _selected =
                          List<bool>.generate(listLength, (_) => _selectAll);
                    });
                  }),
          ],
        ),
        body: _isGridMode
            ? GridBuilder(
                isSelectionMode: isSelectionMode,
                selectedList: _selected,
                onSelectionChange: (bool x) {
                  setState(() {
                    isSelectionMode = x;
                  });
                },
              )
            : ListBuilder(
                isSelectionMode: isSelectionMode,
                selectedList: _selected,
                onSelectionChange: (bool x) {
                  setState(() {
                    isSelectionMode = x;
                  });
                },
              ));
  }
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final Function(bool)? onSelectionChange;
  final List<bool> selectedList;

  @override
  GridBuilderState createState() => GridBuilderState();
}

class GridBuilderState extends State<GridBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.selectedList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (_, int index) {
          return InkWell(
            onTap: () => _toggle(index),
            onLongPress: () {
              if (!widget.isSelectionMode) {
                setState(() {
                  widget.selectedList[index] = true;
                });
                widget.onSelectionChange!(true);
              }
            },
            child: GridTile(
                child: Container(
              child: widget.isSelectionMode
                  ? Checkbox(
                      onChanged: (bool? x) => _toggle(index),
                      value: widget.selectedList[index])
                  : const Icon(Icons.image),
            )),
          );
        });
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final List<bool> selectedList;
  final Function(bool)? onSelectionChange;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  void _toggle(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(16),
      itemCount: widget.selectedList.length,
      itemBuilder: (_, int index) {
        return Container(
          height: 256,
          color: Colors.grey,
          child: Row(
            children: [
              Column(),
              Column(),
              ElevatedButton(onPressed: null, child: null),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 16,
      ),
    );
  }
}


//DraggableScrollableSheet would be fantastic for the facility grid view,
//otherwise, we would have to do filtering options...
//>> filter by: fname, lname, bday (age), brisk, frisk, room#, even length of
//stay or weight... but those last 2 probably would not be approrpiate for the
//context https://docs.flutter.dev/development/ui/widgets/interaction

//silvers are extremely neat too, check out CustomScrollView
//https://api.flutter.dev/flutter/widgets/CustomScrollView-class.html


/*
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: name.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 256,
            color: Color.lerp(Colors.green, Colors.red, bRisk[index]),
            child: Row(
              children: [
                Container(
                  color: Colors.grey,
                  width: 128,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.image,
                        size: 128,
                      ),
                      Text(
                        name[index],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.favorite),
                        Text('${hr[index]}', textAlign: TextAlign.center),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Icon(Icons.account_circle),
                        Text('${rr[index]}', textAlign: TextAlign.center),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      */