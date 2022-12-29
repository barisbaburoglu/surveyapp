import 'package:flutter/material.dart';
import 'package:surveyapp/question_pageview.dart';

class Options extends StatefulWidget {
  final List wrongRightList;
  final OptionSelectedCallback onOptionsSelected;
  final int selectedPosition;
  final int index;

  Options({
    required this.wrongRightList,
    required this.onOptionsSelected,
    required this.selectedPosition,
    required this.index,
  });

  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  int selectedIndex = 99;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: widget.wrongRightList[widget.index].length,
          itemBuilder: (context, position) {
            return Card(
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 3),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.platform,
                checkColor: Colors.lightGreen[800],
                activeColor: Colors.lightGreen[100],
                selectedTileColor: Colors.lightGreen[800],
                selected: selectedIndex == position,
                title: Text(
                    '${widget.wrongRightList[widget.index].elementAt(position).choice}'),
                value: selectedIndex == position,
                onChanged: (bool? newValue) {
                  widget.onOptionsSelected(
                      widget.wrongRightList[widget.index].elementAt(position));
                  setState(
                    () {
                      selectedIndex = position;
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
