part of 'onboard_cubit.dart';

enum PageStatus { initial, first, last }

class OnboardState extends Equatable {
  final PageStatus pageStatus;

  const new({this.pageStatus = PageStatus.initial});

  OnboardState copyWith({PageStatus? pageStatus}) {
    return OnboardState(pageStatus: pageStatus ?? this.pageStatus);
  }

  @override
  List<Object?> get props => [pageStatus];
}
