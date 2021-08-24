import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/upload_campaign_image_body.dart';
import 'package:crowd_funding/app/core/component/domain/repository/campaign/campaign_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'upload_image_campaign_event.dart';
part 'upload_image_campaign_state.dart';

@injectable
class UploadImageCampaignBloc
    extends Bloc<UploadImageCampaignEvent, UploadImageCampaignState> {
  UploadImageCampaignBloc(this._repository)
      : super(UploadImageCampaignInitial());
  CampaignRepository _repository;
  @override
  Stream<UploadImageCampaignState> mapEventToState(
    UploadImageCampaignEvent event,
  ) async* {
    if (event is OnUploadImageCampaign) {
      yield UploadImageCampaignLoading();

      final response = _repository.uploadCampaignImage(event.body);

      await for (final eventRes in response) {
        yield* eventRes.fold((l) async* {
          yield UploadImageCampaignFailure(l.error);
        }, (value) async* {
          yield UploadImageCampaignSuccess();
        });
      }
    }
  }
}
