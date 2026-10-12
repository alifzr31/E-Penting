import 'package:bloc/bloc.dart';
import 'package:e_penting/app/configs/dio/exceptions.dart';
import 'package:e_penting/app/models/toddler.dart';
import 'package:e_penting/app/models/toddler_latest_nik.dart';
import 'package:e_penting/app/repositories/toddler_repository.dart';
import 'package:equatable/equatable.dart';

part 'toddler_state.dart';

class ToddlerCubit extends Cubit<ToddlerState> {
  new(this._repository) : super(const ToddlerState());

  final ToddlerRepository _repository;

  int _currentToddlerPage = 1;

  Future<void> fetchToodlerLatestNik({String? nik}) async {
    emit(state.copyWith(toddlerLatestNikStatus: .loading));

    try {
      final toddlerLatestNik = await _repository.fetchToodlerLatestNik(
        nik: nik,
      );

      if (isClosed) return;

      emit(
        state.copyWith(
          toddlerLatestNikStatus: .success,
          toddlerLatestNik: toddlerLatestNik,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          toddlerLatestNikStatus: .error,
          toddlerLatestNikErrorMessage: e.toString(),
        ),
      );
    }
  }

  void refetchToodlerLatestNik({String? nik}) async {
    if (isClosed) return;

    emit(
      state.copyWith(
        toddlerLatestNikStatus: .initial,
        toddlerLatestNik: null,
        toddlerLatestNikErrorMessage: null,
      ),
    );

    await fetchToodlerLatestNik(nik: nik);
  }

  Future<void> fetchLatestToddlers() async {
    emit(state.copyWith(latestToddlerStatus: .loading));

    try {
      final latestToddlers = await _repository.fetchLatestToddlers();

      if (isClosed) return;

      emit(
        state.copyWith(
          latestToddlerStatus: .success,
          latestToddlers: latestToddlers,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          latestToddlerStatus: .error,
          latestToddlerErrorMessage: e.toString(),
        ),
      );
    }
  }

  void refetchLatestToddlers() async {
    if (isClosed) return;

    emit(
      state.copyWith(
        latestToddlerStatus: .initial,
        latestToddlers: const [],
        latestToddlerErrorMessage: null,
      ),
    );

    await fetchLatestToddlers();
  }

  Future<void> fetchToddlers({String? rangeMonthAge}) async {
    if (_currentToddlerPage == 1) {
      emit(state.copyWith(toddlerStatus: .loading));
    }

    try {
      final toddlers = await _repository.fetchToddlers(
        page: _currentToddlerPage,
        rangeMonthAge: rangeMonthAge,
      );

      if (isClosed) return;

      if (toddlers.length < 15) {
        emit(state.copyWith(hasMoreToddler: false));
      }

      emit(
        state.copyWith(
          toddlerStatus: .success,
          toddlers: List.of(state.toddlers)..addAll(toddlers),
        ),
      );
      _currentToddlerPage++;
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          toddlerStatus: .error,
          toddlerErrorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> fetchSearchToddlers({String? keyword}) async {
    emit(state.copyWith(toddlerStatus: .loading));

    try {
      final toddlers = await _repository.fetchSearchToddlers(keyword: keyword);

      if (isClosed) return;

      emit(state.copyWith(toddlerStatus: .success, toddlers: toddlers));
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          toddlerStatus: .error,
          toddlerErrorMessage: e.toString(),
        ),
      );
    }
  }

  void refetchToddlers({String? keyword, String? rangeMonthAge}) async {
    if (isClosed) return;

    if (keyword == null || keyword.isEmpty) {
      _currentToddlerPage = 1;
      emit(
        state.copyWith(
          toddlerStatus: .initial,
          toddlers: const [],
          hasMoreToddler: true,
          toddlerErrorMessage: null,
        ),
      );

      await fetchToddlers(rangeMonthAge: rangeMonthAge);
    } else {
      _currentToddlerPage = 1;
      emit(
        state.copyWith(
          toddlerStatus: .initial,
          toddlers: const [],
          hasMoreToddler: false,
          toddlerErrorMessage: null,
        ),
      );

      await fetchSearchToddlers(keyword: keyword);
    }
  }

  Future<void> fetchDetailToddler({int? id}) async {
    emit(state.copyWith(toddlerDetailStatus: .loading));

    try {
      final toddlerDetail = await _repository.fetchDetailToddler(id: id);

      if (isClosed) return;

      emit(
        state.copyWith(
          toddlerDetailStatus: .success,
          toddlerDetail: toddlerDetail,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          toddlerStatus: .error,
          toddlerErrorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> fetchSearchMoveToddler({String? keyword}) async {
    emit(state.copyWith(toddlerStatus: .loading));

    try {
      final toddlers = await _repository.fetchSearchMoveToddler(
        keyword: keyword,
      );

      if (isClosed) return;

      emit(state.copyWith(toddlerStatus: .success, toddlers: toddlers));
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          toddlerStatus: .error,
          toddlerErrorMessage: e.toString(),
        ),
      );
    }
  }

  void checkToddlerNik({String? nik}) async {
    emit(state.copyWith(checkToddlerNikStatus: .loading));

    try {
      final responseData = await _repository.checkToddlerNik(nik: nik);

      if (isClosed || responseData == null) return;

      emit(
        state.copyWith(
          checkToddlerNikStatus: .success,
          checkToddlerNikResponseData: responseData,
        ),
      );
    } on RequestCancelledException {
      return;
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          checkToddlerNikStatus: .error,
          checkToddlerNikErrorMessage: e.toString(),
        ),
      );
    }
  }

  void createToddler({
    required bool newToddler,
    String? toddlerNik,
    String? toddlerNoKk,
    int? toddlerId,
    String? toddlerName,
    DateTime? toddlerBornDate,
    String? toddlerGender,
    String? toddlerNumber,
    String? toddlerWeight,
    String? toddlerHeight,
    String? toddlerHeadCircumference,
    String? gestationalAge,
    bool? kiaBayiKecil,
    int? hasKiaBook,
    int? imd,
    String? parentNik,
    String? parentName,
    String? parentPhoneNumber,
    String? address,
    String? rt,
    String? rw,
    int? isBandungResident,
    int? districtId,
    int? subDistrictId,
    int? healthFacilityId,
    int? healthPostId,
  }) async {
    emit(state.copyWith(formStatus: .loading));

    try {
      final responseData = await _repository.createToddler(
        newToddler: newToddler,
        toddlerNik: toddlerNik,
        toddlerNoKk: toddlerNoKk,
        toddlerId: toddlerId,
        toddlerName: toddlerName,
        toddlerBornDate: toddlerBornDate,
        toddlerGender: toddlerGender,
        toddlerNumber: toddlerNumber,
        toddlerWeight: toddlerWeight,
        toddlerHeight: toddlerHeight,
        toddlerHeadCircumference: toddlerHeadCircumference,
        gestationalAge: gestationalAge,
        kiaBayiKecil: kiaBayiKecil,
        hasKiaBook: hasKiaBook,
        imd: imd,
        parentNik: parentNik,
        parentName: parentName,
        parentPhoneNumber: parentPhoneNumber,
        address: address,
        rt: rt,
        rw: rw,
        isBandungResident: isBandungResident,
        districtId: districtId,
        subDistrictId: subDistrictId,
        healthFacilityId: healthFacilityId,
        healthPostId: healthPostId,
      );

      if (isClosed || responseData == null) return;

      if (responseData['success']) {
        emit(
          state.copyWith(formStatus: .success, formResponseData: responseData),
        );
      } else {
        emit(
          state.copyWith(
            formStatus: .error,
            formErrorMessage: responseData['message'],
          ),
        );
      }
    } catch (e) {
      if (isClosed) return;

      emit(state.copyWith(formStatus: .error, formErrorMessage: e.toString()));
    }
  }

  void editToddler({
    int? toddlerId,
    String? toddlerNik,
    String? toddlerNoKk,
    String? toddlerName,
    DateTime? toddlerBornDate,
    String? toddlerGender,
    String? toddlerNumber,
    String? toddlerWeight,
    String? toddlerHeight,
    String? toddlerHeadCircumference,
    String? gestationalAge,
    bool? kiaBayiKecil,
    int? hasKiaBook,
    int? imd,
    String? parentNik,
    String? parentName,
    String? parentPhoneNumber,
    String? address,
    String? rt,
    String? rw,
    int? isBandungResident,
    int? districtId,
    int? subDistrictId,
    int? healthFacilityId,
    int? healthPostId,
  }) async {
    emit(
      state.copyWith(toddlerDetail: state.toddlerDetail, formStatus: .loading),
    );

    try {
      final responseData = await _repository.editToddler(
        toddlerId: toddlerId,
        toddlerNik: toddlerNik,
        toddlerNoKk: toddlerNoKk,
        toddlerName: toddlerName,
        toddlerBornDate: toddlerBornDate,
        toddlerGender: toddlerGender,
        toddlerNumber: toddlerNumber,
        toddlerWeight: toddlerWeight,
        toddlerHeight: toddlerHeight,
        toddlerHeadCircumference: toddlerHeadCircumference,
        gestationalAge: gestationalAge,
        kiaBayiKecil: kiaBayiKecil,
        hasKiaBook: hasKiaBook,
        imd: imd,
        parentNik: parentNik,
        parentName: parentName,
        parentPhoneNumber: parentPhoneNumber,
        address: address,
        rt: rt,
        rw: rw,
        isBandungResident: isBandungResident,
        districtId: districtId,
        subDistrictId: subDistrictId,
        healthFacilityId: healthFacilityId,
        healthPostId: healthPostId,
      );

      if (isClosed || responseData == null) return;

      if (responseData['success']) {
        emit(
          state.copyWith(
            toddlerDetail: state.toddlerDetail,
            formStatus: .success,
            formResponseData: responseData,
          ),
        );
      } else {
        emit(
          state.copyWith(
            toddlerDetail: state.toddlerDetail,
            formStatus: .error,
            formErrorMessage: responseData['message'],
          ),
        );
      }
    } catch (e) {
      if (isClosed) return;

      emit(
        state.copyWith(
          toddlerDetail: state.toddlerDetail,
          formStatus: .error,
          formErrorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _repository.cancelAllRequests();
    return super.close();
  }
}
