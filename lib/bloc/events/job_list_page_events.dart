class MyJobListPageEvents {}

class LoadJobListEvent extends MyJobListPageEvents {
  final int typeId;
  LoadJobListEvent({required this.typeId});
}
