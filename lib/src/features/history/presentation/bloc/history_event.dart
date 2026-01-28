part of 'history_bloc.dart';

abstract class HistoryEvent {
  const HistoryEvent();
}

class LoadHistory extends HistoryEvent {
  const LoadHistory();
}
