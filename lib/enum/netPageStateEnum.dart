enum NetPageStateEnum {
  PagaLoading(state: -1),
  PagaError(state: 0),
  PageSuccess(state: 1),
  ;

  final int state;

  const NetPageStateEnum({
    required this.state,
  });
}
