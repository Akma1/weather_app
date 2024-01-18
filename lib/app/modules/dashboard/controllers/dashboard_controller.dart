import 'dart:developer';
import 'package:get/get.dart';

import '../../../data/models/get_timeline_weather_data_model.dart';
import '../../../data/services/general_service.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController

  final data = Rxn<GetTimelineWeatherDataModel>().obs;
  // final timeLine = Rxn<Timelines>().obs;
  // final location = Rxn<Location>().obs;
  // final minut = Rxn<Minutely>().obs;
  final isLoading = false.obs;
  final listLabelBuyPrice = [1, 2, 3, 4, 5, 6, 6, 7, 8, 8].obs;
  final listLabelSellPrice = [1, 2, 3, 4, 5, 6, 7, 7].obs;

  @override
  void onInit() async {
    // await getTimelineWeatherData();
    getData();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getData() async {
    try {
      await GeneralService.getAPI(city: 'malang').then((value) {
        if (value is GetTimelineWeatherDataModel) {
          data.value.value = value;
          log('DATA : ${data.value.value}');
        }
      });
    } catch (e) {
      log('ERROR NIH : $e');
    }
  }

  // Future getTimelineWeatherData() async {
  //   isLoading(true);
  //   try {
  //     // final res = await GeneralService().getData(
  //     //     endpoint: AppConfig.BASE_URL,
  //     //     query: {
  //     //       "location": '-7.9786372,112.5493811',
  //     //       "apikey": AppConfig.API_KEY,
  //     //     }.toStringMap());
  //     // data.value = GetTimelineWeatherDataModel.fromJson(res.body);
  //     // log('Data NIH : ${data.value}');
  //     await GeneralService.getRecomendationSchoolData(
  //       latlong: '3.1385027,101.6045873', //'42.3478,-71.0466', //'-7.9786372,112.5493811',
  //     ).then((value) {
  //       // log('urls : ${value['location']}');
  //       // location.value.value = Location.fromJson(value['location']);
  //       // minut.value.value = Minutely.fromJson(value['minutely']);

  //       // data.value.value = GetTimelineWeatherDataModel.fromJson(value);
  //       // log('urls 2 nih : ${minut.value.value}');
  //     });
  //   } catch (e) {
  //     isLoading(false);
  //     log('message ERROR : $e');
  //   }
  //   isLoading(false);
  // }
}
