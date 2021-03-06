import QtQuick 2.3
import QtQuick.Controls 1.2

import QGroundControl.FactSystem 1.0
import QGroundControl.FactControls 1.0
import QGroundControl.Controls 1.0
import QGroundControl.Controllers 1.0
import QGroundControl.Palette 1.0

FactPanel {
    id:             panel
    anchors.fill:   parent
    color:          qgcPal.windowShadeDark

    QGCPalette { id: qgcPal; colorGroupEnabled: enabled }
    APMAirframeComponentController {
        id:         controller
        factPanel:  panel
    }

    property Fact _frameClass:          controller.getParameterFact(-1, "FRAME_CLASS")
    property Fact _frameType:           controller.getParameterFact(-1, "FRAME_TYPE", false)
    property bool _frameTypeAvailable:  controller.parameterExists(-1, "FRAME_TYPE")

    Column {
        anchors.fill:       parent

        VehicleSummaryRow {
            labelText:  qsTr("Frame Class")
            valueText:  _frameClass.enumStringValue

        }

        VehicleSummaryRow {
            labelText:  qsTr("Frame Type")
            valueText:  visible ? _frameType.enumStringValue : ""
            visible:    _frameTypeAvailable
        }

        VehicleSummaryRow {
            labelText: qsTr("Firmware Version")
            valueText: activeVehicle.firmwareMajorVersion == -1 ? qsTr("Unknown") : activeVehicle.firmwareMajorVersion + "." + activeVehicle.firmwareMinorVersion + "." + activeVehicle.firmwarePatchVersion + activeVehicle.firmwareVersionTypeString
        }
    }
}
