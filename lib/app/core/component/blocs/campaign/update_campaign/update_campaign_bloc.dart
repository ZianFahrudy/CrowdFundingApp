import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crowd_funding/app/core/component/domain/repository/campaign/campaign_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:crowd_funding/app/core/component/domain/models/request/create_campaign_body.dart';

part 'update_campaign_event.dart';
part 'update_campaign_state.dart';

@injectable
class UpdateCampaignBloc
    extends Bloc<UpdateCampaignEvent, UpdateCampaignState> {
  UpdateCampaignBloc(this._repository) : super(UpdateCampaignInitial());
  CampaignRepository _repository;
  @override
  Stream<UpdateCampaignState> mapEventToState(
    UpdateCampaignEvent event,
  ) async* {
    if (event is OnUpdateCampaignEvent) {
      yield UpdateCampaignLoading();

      final response = _repository.updateCampaign(event.body, event.id);

      await for (final eventRes in response) {
        yield* eventRes.fold((l) async* {
          yield UpdateCampaignFailure(l.error);
        }, (value) async* {
          yield UpdateCampaignSuccess();
        });
      }
    }
  }
}
