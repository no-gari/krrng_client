import 'dart:convert';
import 'dart:math';

import 'package:krrng_client/repositories/hospital_repository/src/hospital_repository.dart';
import 'package:krrng_client/repositories/hospital_repository/models/hospital_detail.dart';
import 'package:krrng_client/repositories/hospital_repository/models/review.dart';
import 'package:krrng_client/support/networks/network_exceptions.dart';
import 'package:krrng_client/support/networks/api_result.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_parser/http_parser.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

part 'writing_review_state.dart';

class WritingReviewCubit extends Cubit<WritingReviewState> {
  WritingReviewCubit({this.hospitalRepository, this.hospitalDetail})
      : super(const WritingReviewState());

  final HospitalRepository? hospitalRepository;
  final HospitalDetail? hospitalDetail;

  Future getImages(List<Asset> images) async {
    List<Asset> resultList = <Asset>[];
    resultList = await MultiImagePicker.pickImages(
        maxImages: 10, enableCamera: true, selectedAssets: images);

    emit(state.copyWith(receiptImages: resultList));
  }

  Future getReviewImages(List<Asset> images) async {
    List<Asset> resultList = <Asset>[];
    resultList = await MultiImagePicker.pickImages(
        maxImages: 10, enableCamera: true, selectedAssets: images);
    emit(state.copyWith(receiptImages: resultList));
  }

  Future<void> createReview() async {
    var random = Random.secure();
    var values = List<int>.generate(16, (i) => random.nextInt(255));
    var randomId = base64UrlEncode(values);

    final writingImages = state.writingImages ?? [];
    final recieptImage = state.receiptImages ?? [];

    List<MultipartFile> multipart_writingImages = [];
    for (int i = 0; i < writingImages.length; i++) {
      final bytes = (await writingImages[i].getThumbByteData(200, 200))
          .buffer
          .asUint8ClampedList();
      final multipart = MultipartFile.fromBytes(bytes,
          filename: randomId + 'write' + i.toString(),
          contentType: MediaType("image", "jpeg"));
      multipart_writingImages.add(multipart);
    }

    List<MultipartFile> multipart_recieptImage = [];
    for (int i = 0; i < recieptImage.length; i++) {
      final bytes = (await recieptImage[i].getThumbByteData(200, 200))
          .buffer
          .asUint8ClampedList();
      final multipart = await MultipartFile.fromBytes(bytes,
          filename: randomId + 'reciept' + i.toString(),
          contentType: MediaType("image", "jpeg"));
      multipart_recieptImage.add(multipart);
    }

    var data = FormData.fromMap({
      "hospital": hospitalDetail!.id!,
      "diagnosis": state.disease,
      "content": state.reviewContent,
      "rates": state.rates,
      "reviewImage": multipart_writingImages,
      "recieptImage": multipart_recieptImage
    });

    var response = await hospitalRepository!.createReview(data);
    response.when(success: (Map? review) {
      emit(state.copyWith(
        isComplete: true,
      ));
    }, failure: (NetworkExceptions? error) {
      emit(state.copyWith(
          error: error,
          errorMessage: NetworkExceptions.getErrorMessage(error!)));
    });
  }

  Future<void> getMyReviews() async {
    emit(state.copyWith(isComplete: false));

    ApiResult<List<dynamic>> apiResult =
        await hospitalRepository!.getMyReviews();

    apiResult.when(success: (List? listResponse) {
      emit(state.copyWith(
          reviews: listResponse!.map((e) => Review.fromJson(e)).toList(),
          isComplete: true));
    }, failure: (NetworkExceptions? error) {
      print(error);
    });
  }
}
