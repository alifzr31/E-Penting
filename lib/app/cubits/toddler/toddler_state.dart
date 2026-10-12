part of 'toddler_cubit.dart';

enum Status { initial, loading, success, error }

class ToddlerState extends Equatable {
  final Status toddlerLatestNikStatus;
  final ToddlerLatestNik? toddlerLatestNik;
  final String? toddlerLatestNikErrorMessage;
  final Status latestToddlerStatus;
  final List<Toddler> latestToddlers;
  final String? latestToddlerErrorMessage;
  final Status toddlerStatus;
  final List<Toddler> toddlers;
  final bool hasMoreToddler;
  final String? toddlerErrorMessage;
  final Status toddlerDetailStatus;
  final Toddler? toddlerDetail;
  final String? toddlerDetailErrorMessage;
  final Status checkToddlerNikStatus;
  final Map<String, dynamic>? checkToddlerNikResponseData;
  final String? checkToddlerNikErrorMessage;
  final Status formStatus;
  final Map<String, dynamic>? formResponseData;
  final String? formErrorMessage;

  const new({
    this.toddlerLatestNikStatus = .initial,
    this.toddlerLatestNik,
    this.toddlerLatestNikErrorMessage,
    this.latestToddlerStatus = .initial,
    this.latestToddlers = const [],
    this.latestToddlerErrorMessage,
    this.toddlerStatus = .initial,
    this.toddlers = const [],
    this.hasMoreToddler = true,
    this.toddlerErrorMessage,
    this.toddlerDetailStatus = .initial,
    this.toddlerDetail,
    this.toddlerDetailErrorMessage,
    this.formStatus = .initial,
    this.formResponseData,
    this.formErrorMessage,
    this.checkToddlerNikStatus = .initial,
    this.checkToddlerNikResponseData,
    this.checkToddlerNikErrorMessage,
  });

  ToddlerState copyWith({
    Status? toddlerLatestNikStatus,
    ToddlerLatestNik? toddlerLatestNik,
    String? toddlerLatestNikErrorMessage,
    Status? latestToddlerStatus,
    List<Toddler>? latestToddlers,
    String? latestToddlerErrorMessage,
    Status? toddlerStatus,
    List<Toddler>? toddlers,
    bool? hasMoreToddler,
    String? toddlerErrorMessage,
    Status? toddlerDetailStatus,
    Toddler? toddlerDetail,
    String? toddlerDetailErrorMessage,
    Status? formStatus,
    Map<String, dynamic>? formResponseData,
    String? formErrorMessage,
    Status? checkToddlerNikStatus,
    Map<String, dynamic>? checkToddlerNikResponseData,
    String? checkToddlerNikErrorMessage,
  }) {
    return ToddlerState(
      toddlerLatestNikStatus:
          toddlerLatestNikStatus ?? this.toddlerLatestNikStatus,
      toddlerLatestNik: toddlerLatestNik,
      toddlerLatestNikErrorMessage: toddlerLatestNikErrorMessage,
      latestToddlerStatus: latestToddlerStatus ?? this.latestToddlerStatus,
      latestToddlers: latestToddlers ?? this.latestToddlers,
      latestToddlerErrorMessage: latestToddlerErrorMessage,
      toddlerStatus: toddlerStatus ?? this.toddlerStatus,
      toddlers: toddlers ?? this.toddlers,
      hasMoreToddler: hasMoreToddler ?? this.hasMoreToddler,
      toddlerErrorMessage: toddlerErrorMessage,
      toddlerDetailStatus: toddlerDetailStatus ?? this.toddlerDetailStatus,
      toddlerDetail: toddlerDetail,
      toddlerDetailErrorMessage: toddlerDetailErrorMessage,
      formStatus: formStatus ?? this.formStatus,
      formResponseData: formResponseData,
      formErrorMessage: formErrorMessage,
      checkToddlerNikStatus:
          checkToddlerNikStatus ?? this.checkToddlerNikStatus,
      checkToddlerNikResponseData: checkToddlerNikResponseData,
      checkToddlerNikErrorMessage: checkToddlerNikErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    toddlerLatestNikStatus,
    toddlerLatestNik,
    toddlerLatestNikErrorMessage,
    latestToddlerStatus,
    latestToddlers,
    latestToddlerErrorMessage,
    toddlerStatus,
    toddlers,
    hasMoreToddler,
    toddlerErrorMessage,
    toddlerDetailStatus,
    toddlerDetail,
    toddlerDetailErrorMessage,
    formStatus,
    formResponseData,
    formErrorMessage,
    checkToddlerNikStatus,
    checkToddlerNikResponseData,
    checkToddlerNikErrorMessage,
  ];
}
