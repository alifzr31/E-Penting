import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:epenting/app/models/balita.dart';
import 'package:epenting/app/repositories/balita_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'balita_state.dart';

class BalitaCubit extends Cubit<BalitaState> {
  BalitaCubit(this._repository) : super(const BalitaState());

  final BalitaRepository _repository;
  int currentPage = 1;

  void resetState() {
    emit(
      state.copyWith(
        balitaStatus: BalitaStatus.initial,
        hasMoreBalita: true,
        balitas: const [],
        balitaError: null,
        selectedFilter: null,
        formStatus: FormStatus.initial,
        formResponse: null,
        formError: null,
        detailStatus: DetailStatus.initial,
        detailBalita: null,
        detailError: null,
      ),
    );
  }

  Future<void> fetchAllBalita() async {
    if (currentPage == 1) {
      emit(state.copyWith(balitaStatus: BalitaStatus.loading));
    }

    try {
      final balitas = await _repository.fetchAllBalita(
        page: currentPage,
        ageFilter: state.selectedFilter,
      );

      if (balitas.length < 15) {
        emit(state.copyWith(hasMoreBalita: false));
      }

      emit(
        state.copyWith(
          balitaStatus: BalitaStatus.success,
          balitas: List.of(state.balitas)..addAll(balitas),
        ),
      );
      currentPage++;
    } on DioException catch (e) {
      emit(
        state.copyWith(
          balitaStatus: BalitaStatus.error,
          balitaError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void refetchAllBalita({
    bool isSearch = false,
    String? filter,
    String? search,
  }) async {
    currentPage = 1;
    emit(
      state.copyWith(
        balitaStatus: BalitaStatus.initial,
        hasMoreBalita: true,
        balitas: const [],
        balitaError: null,
        selectedFilter: filter,
      ),
    );

    if (isSearch) {
      await fetchSearchBalita(name: search);
    } else {
      await fetchAllBalita();
    }
  }

  Future<void> fetchSearchBalita({String? name}) async {
    emit(state.copyWith(balitaStatus: BalitaStatus.loading));

    try {
      final balitas = await _repository.fetchSearchBalita(name: name);

      emit(
        state.copyWith(balitaStatus: BalitaStatus.success, balitas: balitas),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          balitaStatus: BalitaStatus.error,
          balitaError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void resetAddFormState() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      emit(
        state.copyWith(
          checkNikStatus: CheckNikStatus.initial,
          checkNikMessage: null,
          checkNikError: null,
          formStatus: FormStatus.initial,
          formResponse: null,
          formError: null,
        ),
      );
    });
  }

  void checkNikBalita({String? nik}) async {
    emit(state.copyWith(checkNikStatus: CheckNikStatus.loading));

    try {
      final message = await _repository.checkNikBalita(nik: nik);

      emit(
        state.copyWith(
          checkNikStatus: CheckNikStatus.success,
          checkNikMessage: message,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          checkNikStatus: CheckNikStatus.error,
          checkNikError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  void createBalita({
    String? statusBalita,
    int? idBalita,
    String? nik,
    String? noKk,
    String? namaBalita,
    String? tglLahir,
    String? jenisKelamin,
    String? anakKe,
    String? beratLahir,
    String? tinggiLahir,
    String? lingkarKepalaLahir,
    String? usiaKehamilan,
    String? kiaBayiKecil,
    String? bukuKia,
    String? imd,
    String? nikOrtu,
    String? namaOrtu,
    String? noTelp,
    String? alamat,
    String? rt,
    String? rw,
    int? idKecamatan,
    int? idKelurahan,
    int? idPuskesmas,
    int? idPosyandu,
    String? pendudukBandung,
  }) async {
    emit(state.copyWith(formStatus: FormStatus.loading));

    try {
      final response =
          statusBalita == 'baru'
              ? await _repository.addBalita(
                nik: nik,
                noKk: noKk,
                namaBalita: namaBalita,
                tglLahir: tglLahir,
                jenisKelamin: jenisKelamin,
                anakKe: anakKe,
                beratLahir: beratLahir,
                tinggiLahir: tinggiLahir,
                lingkarKepalaLahir: lingkarKepalaLahir,
                usiaKehamilan: usiaKehamilan,
                kiaBayiKecil: kiaBayiKecil,
                bukuKia: bukuKia,
                imd: imd,
                nikOrtu: nikOrtu,
                namaOrtu: namaOrtu,
                noTelp: noTelp,
                alamat: alamat,
                rt: rt,
                rw: rw,
                idKecamatan: idKecamatan,
                idKelurahan: idKelurahan,
                idPuskesmas: idPuskesmas,
                idPosyandu: idPosyandu,
                pendudukBandung: pendudukBandung,
              )
              : await _repository.pindahBalita(
                idBalita: idBalita,
                nik: nik,
                noKk: noKk,
                namaBalita: namaBalita,
                tglLahir: tglLahir,
                jenisKelamin: jenisKelamin,
                anakKe: anakKe,
                beratLahir: beratLahir,
                tinggiLahir: tinggiLahir,
                lingkarKepalaLahir: lingkarKepalaLahir,
                usiaKehamilan: usiaKehamilan,
                kiaBayiKecil: kiaBayiKecil,
                bukuKia: bukuKia,
                imd: imd,
                nikOrtu: nikOrtu,
                namaOrtu: namaOrtu,
                noTelp: noTelp,
                alamat: alamat,
                rt: rt,
                rw: rw,
                idKecamatan: idKecamatan,
                idKelurahan: idKelurahan,
                idPuskesmas: idPuskesmas,
                idPosyandu: idPosyandu,
                pendudukBandung: pendudukBandung,
              );

      emit(
        state.copyWith(formStatus: FormStatus.success, formResponse: response),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          formStatus: FormStatus.error,
          formError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  FutureOr<List<Balita>?> searchPindahBalita(String keyword) async {
    if (keyword.isNotEmpty) {
      try {
        final balitas = await _repository.fetchSearchPindahBalita(
          name: keyword,
        );

        return balitas
            .where(
              (element) => element.namaAnak.toString().toLowerCase().contains(
                keyword.toLowerCase(),
              ),
            )
            .toList();
      } on DioException catch (e) {
        if (kDebugMode) {
          print(e.response?.data);
        }
        return const [];
      }
    } else {
      return const [];
    }
  }

  void resetEditFormState() async {
    await Future.delayed(const Duration(milliseconds: 500), () {
      emit(
        state.copyWith(
          detailStatus: DetailStatus.initial,
          detailBalita: null,
          detailError: null,
          formStatus: FormStatus.initial,
          formResponse: null,
          formError: null,
        ),
      );
    });
  }

  Future<void> fetchDetailBalita({int? balitaId}) async {
    emit(state.copyWith(detailStatus: DetailStatus.loading));

    try {
      final detailBalita = await _repository.fetchDetailBalita(
        balitaId: balitaId,
      );

      emit(
        state.copyWith(
          detailStatus: DetailStatus.success,
          detailBalita: detailBalita,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          detailStatus: DetailStatus.error,
          detailError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }

  FutureOr<List<Balita>?> searchBalita(String keyword) async {
    try {
      final balitas = await _repository.fetchSearchBalita(name: keyword);

      return balitas
          .where(
            (element) => element.namaAnak.toString().toLowerCase().contains(
              keyword.toLowerCase(),
            ),
          )
          .toList();
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.response?.data);
      }
      return const [];
    }
  }

  void updateBalita({
    int? balitaId,
    String? nikAnak,
    String? noKk,
    String? namaAnak,
    String? tglLahir,
    String? jenisKelamin,
    String? anakKe,
    String? beratLahir,
    String? tinggiLahir,
    String? lingkarKepala,
    String? usiaKehamilan,
    bool? kiaBayiKecil,
    int? bukuKia,
    int? imd,
    String? nikOrtu,
    String? namaOrtu,
    String? noTelpOrtu,
    String? alamat,
    String? rt,
    String? rw,
    int? pendudukBandung,
    int? idKecamatan,
    int? idKelurahan,
    int? idPuskesmas,
    int? idPosyandu,
  }) async {
    emit(
      state.copyWith(
        detailBalita: state.detailBalita,
        formStatus: FormStatus.loading,
      ),
    );

    try {
      final response = await _repository.updateBalita(
        balitaId: balitaId,
        nikAnak: nikAnak,
        noKk: noKk,
        namaAnak: namaAnak,
        tglLahir: tglLahir,
        jenisKelamin: jenisKelamin,
        anakKe: anakKe,
        beratLahir: beratLahir,
        tinggiLahir: tinggiLahir,
        lingkarKepala: lingkarKepala,
        usiaKehamilan: usiaKehamilan,
        kiaBayiKecil: kiaBayiKecil,
        bukuKia: bukuKia,
        imd: imd,
        nikOrtu: nikOrtu,
        namaOrtu: namaOrtu,
        noTelpOrtu: noTelpOrtu,
        alamat: alamat,
        rt: rt,
        rw: rw,
        pendudukBandung: pendudukBandung,
        idKecamatan: idKecamatan,
        idKelurahan: idKelurahan,
        idPuskesmas: idPuskesmas,
        idPosyandu: idPosyandu,
      );

      emit(
        state.copyWith(
          detailBalita: state.detailBalita,
          formStatus: FormStatus.success,
          formResponse: response,
        ),
      );
    } on DioException catch (e) {
      emit(
        state.copyWith(
          detailBalita: state.detailBalita,
          formStatus: FormStatus.error,
          formError:
              e.response?.data['message'] ?? 'Ups sepertinya terjadi kesalahan',
        ),
      );
    }
  }
}
