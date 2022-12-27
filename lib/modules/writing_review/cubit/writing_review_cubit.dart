import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krrng_client/repositories/hospital_repository/models/hospital_detail.dart';
import 'package:krrng_client/repositories/hospital_repository/models/review.dart';
import 'package:krrng_client/repositories/hospital_repository/src/hospital_repository.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

part 'writing_review_state.dart';

class WritingReviewCubit extends Cubit<WritingReviewState> {
  WritingReviewCubit(this._hospitalRepository, this.hospitalDetail): super(const WritingReviewState());

  final HospitalRepository _hospitalRepository;
  final HospitalDetail hospitalDetail;

  Future getImages(List<Asset> images) async {
    List<Asset> resultList = <Asset>[];
    resultList = await MultiImagePicker.pickImages(maxImages: 10, enableCamera: true, selectedAssets: images);

    emit(state.copyWith(
      receiptImages: resultList
    ));
  }

  Future getReviewImages(List<Asset> images) async {
    List<Asset> resultList = <Asset>[];
    resultList = await MultiImagePicker.pickImages(maxImages: 10, enableCamera: true, selectedAssets: images);
    emit(state.copyWith(
        receiptImages: resultList
    ));
  }

  Future<void> createReview() async {
    // MultipartFile? recieptImage = state.receiptImages == null ? null : state.receiptImages!.map((e) => await MultipartFile.fromFile(e!));

    Map<String, dynamic> body = {
      "hospital": hospitalDetail.id!,
      "diagnosis": state.disease,
      "content": state.reviewContent,
      "rates": state.rates,
      "reviewContent": [],
      "recieptImage": []
    };

    var response = await _hospitalRepository.createReview(body);
    response.when(success: (Review? review) {
      print(review);

    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  /*
  hospital
    diagnosis
    content
    rates
    reviewImage

  * */
}