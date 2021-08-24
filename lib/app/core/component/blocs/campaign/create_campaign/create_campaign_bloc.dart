import 'dart:async';
import 'package:crowd_funding/app/core/component/domain/models/request/create_campaign_body.dart';
import 'package:bloc/bloc.dart';
import 'package:crowd_funding/app/core/component/domain/repository/campaign/campaign_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'create_campaign_event.dart';
part 'create_campaign_state.dart';

@injectable
class CreateCampaignBloc
    extends Bloc<CreateCampaignEvent, CreateCampaignState> {
  CreateCampaignBloc(this._repository) : super(CreateCampaignInitial());
  CampaignRepository _repository;
  @override
  Stream<CreateCampaignState> mapEventToState(
    CreateCampaignEvent event,
  ) async* {
    if (event is OnCreateCampaignEvent) {
      yield CreateCampaignLoading();

      final response = _repository.createCampaign(event.body);

      await for (final eventRes in response) {
        yield* eventRes.fold((l) async* {
          yield CreateCampaignFailure(l.error);
        }, (value) async* {
          yield CreateCampaignSuccess();
        });
      }
    }
  }
}
