// =====================================
// What system users most achieve
// =====================================

package 'Operational Analysis'
{
    // =====================================
    // Imports
    // =====================================

    private import OperationalDefinitions::*;

    // // =====================================
    // // Operational Analysis Context
    // // =====================================  

    part spaceEnvironment : SpaceEnvironment{
        out item environmentConditions : EnvironmentConditions;
        out item solarFlux : SolarFlux;        
        perform action imposeOrbitalConditions : ImposeOrbitalConditions{
            out environmentConditions : EnvironmentConditions;
        }
        perform action irradiateSolarEnergy : IrradiateSolarEnergy{
            out solarFlux : SolarFlux;
        }
        binding bind irradiateSolarEnergy.solarFlux = solarFlux;
        binding bind imposeOrbitalConditions.environmentConditions = environmentConditions;
    }
    connect spaceEnvironment.solarFlux to solarPanels.solarFlux;
    connect spaceEnvironment.environmentConditions to solarPanels.environmentConditions;
    connect spaceEnvironment.environmentConditions to batteries.environmentConditions;

    part solarPanels : SolarPanels{
        in item environmentConditions : EnvironmentConditions;
        in item solarFlux : SolarFlux;        
        out item solarPower : Power;
        perform action harvestMaxSolarPower : HarvestMaxSolarPower{
            in environmentConditions : EnvironmentConditions;
            in solarFlux : SolarFlux;
            out solarPower : Power;
        }
        binding bind harvestMaxSolarPower.environmentConditions = environmentConditions;
        binding bind harvestMaxSolarPower.solarFlux = solarFlux;
        binding bind harvestMaxSolarPower.solarPower = solarPower;
    }
    connect solarPanels.solarPower to powerDistributionNetwork.solarPower;
    
    part batteries : Batteries{
        in item environmentConditions : EnvironmentConditions;
        in item protectionAction : ProtectionAction;
        out item bufferPower : Power;
        out item detectionAction : DetectionAction;
        out item sensorData : SensorData;
        perform action bufferExcessEnergy : BufferExcessEnergy{
            in environmentConditions : EnvironmentConditions;
            out bufferPower: Power;
            out batteriesCondition : PhysicalConditions;
        }
        perform action interfaceProtections : InterfaceProtectionsBAT{
            in protectionAction : ProtectionAction;
            in bufferPowerIn : Power;
            in batteriesCondition : PhysicalConditions;
            out detectionAction : DetectionAction;
            out bufferPower : Power;
        }
        perform action interfaceSensing : InterfaceSensingBAT{
            in bufferPowerIn : Power;
            in batteriesCondition : PhysicalConditions;
            out bufferPower : Power;
            out sensorData : SensorData;
        }
        binding bind bufferExcessEnergy.environmentConditions = environmentConditions;
        binding bind bufferExcessEnergy.bufferPower = interfaceProtections.bufferPowerIn;
        binding bind bufferExcessEnergy.batteriesCondition = interfaceProtections.batteriesCondition;
        binding bind bufferExcessEnergy.batteriesCondition = interfaceSensing.batteriesCondition;
        binding bind interfaceProtections.protectionAction = protectionAction;
        binding bind interfaceProtections.detectionAction = detectionAction;
        binding bind interfaceProtections.bufferPower = interfaceSensing.bufferPowerIn;
        binding bind interfaceSensing.bufferPower = bufferPower;
        binding bind interfaceSensing.sensorData = sensorData;
    }    
    connect batteries.bufferPower to powerDistributionNetwork.bufferPower;
    connect batteries.sensorData to autonomousControl.sensorData;
    connect batteries.detectionAction to protections.detectionAction;

    part powerDistributionNetwork : PowerDistributionNetwork{
        in controlData : ControlData;
        in item solarPower : Power;
        in item bufferPower: Power;
        in item regulatedPowerIn : Power;
        in item protectionAction : ProtectionAction;
        out item unregulatedPower : Power;
        out item regulatedPower : Power;
        out item detectionAction : DetectionAction;
        out item sensorData : SensorData;
        out item statusData : StatusData;
        perform action distributeAndSwitchPower : DistributeAndSwitchPower{
            in controlData : ControlData;
            in solarPower : Power;
            in bufferPower : Power;
            in regulatedPowerIn : Power;        
            out unregulatedPower : Power;
            out regulatedPower : Power;
            out statusData : StatusData;
        }
        perform action interfaceProtections : InterfaceProtectionsPDS{
            in protectionAction : ProtectionAction;
            in unregulatedPowerIn : Power;
            in regulatedPowerIn : Power;
            out detectionAction : DetectionAction;
            out unregulatedPower : Power;
            out regulatedPower : Power;
        }
        perform action interfaceSensing : InterfaceSensingPDS{
            in regulatedPowerIn : Power;
            in unregulatedPowerIn : Power;
            out unregulatedPower : Power;
            out regulatedPower : Power;
            out sensorData : SensorData;
        }
        binding bind distributeAndSwitchPower.controlData = controlData;
        binding bind distributeAndSwitchPower.solarPower = solarPower;
        binding bind distributeAndSwitchPower.bufferPower = bufferPower;
        binding bind distributeAndSwitchPower.regulatedPowerIn = regulatedPowerIn;
        binding bind distributeAndSwitchPower.unregulatedPower = interfaceProtections.unregulatedPowerIn;
        binding bind distributeAndSwitchPower.regulatedPower = interfaceProtections.regulatedPowerIn;
        binding bind distributeAndSwitchPower.statusData = statusData;
        binding bind interfaceProtections.protectionAction = protectionAction;
        binding bind interfaceProtections.detectionAction = detectionAction;
        binding bind interfaceProtections.unregulatedPower = interfaceSensing.unregulatedPowerIn;
        binding bind interfaceProtections.regulatedPower = interfaceSensing.regulatedPowerIn;
        binding bind interfaceSensing.unregulatedPower = unregulatedPower;
        binding bind interfaceSensing.regulatedPower = regulatedPower;
        binding bind interfaceSensing.sensorData = sensorData;
    }
    connect powerDistributionNetwork.unregulatedPower to powerConverters.unregulatedPower;
    connect powerDistributionNetwork.regulatedPower to payloads.regulatedPower;
    connect powerDistributionNetwork.regulatedPower to spaceSegmentServices.regulatedPower;
    connect powerDistributionNetwork.detectionAction to protections.detectionAction;
    connect powerDistributionNetwork.sensorData to autonomousControl.sensorData;
    connect powerDistributionNetwork.statusData to autonomousControl.statusData;

    part powerConverters : PowerConverters{
        in item unregulatedPower : Power;
        out item regulatedPower : Power;
        perform action regulateAndFilterPowerRails : RegulateAndFilterPowerRails{
            in unregulatedPower : Power;
            out regulatedPower : Power;
        }
        binding bind regulateAndFilterPowerRails.unregulatedPower = unregulatedPower;
        binding bind regulateAndFilterPowerRails.regulatedPower = regulatedPower;
    }
    connect powerConverters.regulatedPower to powerDistributionNetwork.regulatedPowerIn;

    part protections : Protections{
        in item detectionAction : DetectionAction;
        out item protectionAction : ProtectionAction;
        out item faultData : FaultData;
        perform action detectIsolateAndRecoverFromFailures : DetectIsolateAndRecoverFromFailures{
            in detectionAction : DetectionAction;
            out protectionAction : ProtectionAction;
            out faultData : FaultData;
        }    
        binding bind detectIsolateAndRecoverFromFailures.detectionAction = detectionAction;
        binding bind detectIsolateAndRecoverFromFailures.protectionAction = protectionAction;
        binding bind detectIsolateAndRecoverFromFailures.faultData = faultData;  
    }
    connect protections.protectionAction to batteries.protectionAction;
    connect protections.protectionAction to powerDistributionNetwork.protectionAction;
    connect protections.faultData to autonomousControl.faultData;

    part autonomousControl : AutonomousControl{
        in item sensorData : SensorData;
        in item faultData : FaultData;
        in item statusData : StatusData;
        in item busCommand : BusCommand;
        out item powerTelemetry : BusTelemetry;
        out item controlData : ControlData;
        perform action consolidateDataForTelemetry : ConsolidateDataForTelemetry{
            in sensorData : SensorData;
            in faultData : FaultData;
            in statusData : StatusData;
            in behavioralData : BehavioralData;
            out powerTelemetry : BusTelemetry;
        }
        perform action updateBehavioralDataAndCalculatePredictions : UpdateBehavioralDataAndCalculatePredictions{
            in sensorData : SensorData;
            in faultData : FaultData;
            in statusData : StatusData;
            out behavioralData : BehavioralData;
            out predictiveData : PredictiveData;
        }
        perform action performAutonomousControl : PerformAutonomousControl{
            in predictiveData: PredictiveData;
            in busCommand : BusCommand;
            out controlData : ControlData;
        }
        binding bind consolidateDataForTelemetry.sensorData = sensorData;
        binding bind consolidateDataForTelemetry.faultData = faultData;
        binding bind consolidateDataForTelemetry.statusData = statusData;
        binding bind consolidateDataForTelemetry.behavioralData = updateBehavioralDataAndCalculatePredictions.behavioralData;
        binding bind consolidateDataForTelemetry.powerTelemetry = powerTelemetry;
        binding bind updateBehavioralDataAndCalculatePredictions.sensorData = sensorData;
        binding bind updateBehavioralDataAndCalculatePredictions.faultData = faultData;
        binding bind updateBehavioralDataAndCalculatePredictions.statusData = statusData;
        binding bind updateBehavioralDataAndCalculatePredictions.predictiveData = performAutonomousControl.predictiveData;
        binding bind performAutonomousControl.busCommand = busCommand;
        binding bind performAutonomousControl.controlData = controlData;
    }
    connect autonomousControl.powerTelemetry to spaceSegmentServices.powerTelemetry;
    connect autonomousControl.controlData to powerDistributionNetwork.controlData;

    part payloads : Payloads{
        in item regulatedPower : Power;
        in item controlData : ControlData;
        perform action performMission : PerformMission{
            in regulatedPower : Power;
            in controlData : ControlData;
        }
        binding bind performMission.regulatedPower = regulatedPower;
        binding bind performMission.controlData = controlData;
    }

    part spaceSegmentServices : Payloads{
        in item regulatedPower : Power;
        in item groundCommand : GroundCommand;
        in item powerTelemetry : BusTelemetry;
        out item busCommand : BusCommand;
        out item spaceSegmentTelemetry : SpaceSegmentTelemetry;
        perform action consumePowerForServices : ConsumePowerForServices{
            in regulatedPower : Power;
        }
        perform action receiveAndProcessCommand : ReceiveAndProcessCommand{
            in groundCommand : GroundCommand;
            out busCommand : BusCommand;
        }
        perform action consolidateAndSendBusTelemetry : ConsolidateAndSendBusTelemetry{
            in powerTelemetry : BusTelemetry;
            out spaceSegmentTelemetry : SpaceSegmentTelemetry;
        }
        binding bind consumePowerForServices.regulatedPower = regulatedPower;
        binding bind receiveAndProcessCommand.groundCommand = groundCommand;
        binding bind receiveAndProcessCommand.busCommand = busCommand;
        binding bind consolidateAndSendBusTelemetry.powerTelemetry = powerTelemetry;
        binding bind consolidateAndSendBusTelemetry.spaceSegmentTelemetry = spaceSegmentTelemetry;
    }
    connect spaceSegmentServices.busCommand to autonomousControl.busCommand;
    connect spaceSegmentServices.spaceSegmentTelemetry to groundSegment.spaceSegmentTelemetry;

    part groundSegment : GroundSegment{
        in item spaceSegmentTelemetry : SpaceSegmentTelemetry;
        out item groundCommand : GroundCommand;
        perform action receiveTelemetry : ReceiveTelemetry{
            in spaceSegmentTelemetry : SpaceSegmentTelemetry;
            out telemetryReport : TelemetryReport;
        }
        perform action defineOperations : DefineOperations{
            in telemetryReport : TelemetryReport;
            out groundCommand : GroundCommand;
        }
        perform action sendCommands : SendCommands{
            in groundCommandIn : GroundCommand;
            out groundCommand : GroundCommand;
        }
        binding bind receiveTelemetry.spaceSegmentTelemetry = spaceSegmentTelemetry;
        binding bind receiveTelemetry.telemetryReport = defineOperations.telemetryReport;
        binding bind defineOperations.groundCommand = sendCommands.groundCommandIn;
        binding bind defineOperations.groundCommand = groundCommand;
    }
    connect groundSegment.groundCommand to spaceSegmentServices.groundCommand;
}
