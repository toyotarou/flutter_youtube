class DraggableList {
  const DraggableList({
    required this.header,
    required this.items,
  });

  final String header;
  final List<DraggableListItem> items;
}

class DraggableListItem {
  const DraggableListItem({required this.title});

  final String title;
}
