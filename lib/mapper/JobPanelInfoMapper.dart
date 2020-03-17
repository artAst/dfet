import 'package:danceframe_et/model/JobPanelData.dart';

class JobPanelInfoMapper {

  static JobPanelData mapFromPanelInfo(panelInfo) {
    JobPanelData jbp = new JobPanelData.fromMap({
      "id": panelInfo["jobPanelId"]
    });

    return jbp;
  }
}