package OperationalDefinitions
{
    // =====================================
    // Imports
    // =====================================
    
    public import SI::*;
    public import ScalarValues::*;
    public import MeasurementReferences::*;
    public import Arcadia::*;

    // // =====================================
    // // Operational Modes
    // // =====================================

    // item ReleaseMode : Mode;
    // item SunlightMode : Mode;
    // item EclipseMode : Mode;
    // item SafeMode : Mode;
    // item FaultRecoveryMode : Mode;

    // // =====================================
    // // Operational Scenarios
    // // =====================================

    // item OA_S1_EclipseEntry_LoadShedding : OperationalScenario;
    // item OA_S2_BatteryOverTemp_ProtectionAndRecovery : OperationalScenario;
    // item OA_S3_RailLatchUp_IsolateAndReport : OperationalScenario;
    // item OA_S4_LossOfGroundContact_AutonomousGovernance : OperationalScenario;
    // item OA_S5_ReturnToNominal_ControlledLoadRestoration : OperationalScenario;

    // =====================================
    // Exchange items
    // =====================================

    item def SolarFlux :> ExchangeItem;
    item def EnvironmentConditions :> ExchangeItem;
    item def PhysicalConditions :> ExchangeItem;
    item def Power :> ExchangeItem;
    item def InternalBusTelemetry :> ExchangeItem;
    item def InternalBusCommand :> ExchangeItem;
    item def ControlData :> ExchangeItem;
    item def StatusData :> ExchangeItem;
    item def FaultData :> ExchangeItem;
    item def DetectionAction :> ExchangeItem;
    item def ProtectionAction :> ExchangeItem;
    item def SensorData :> ExchangeItem;
    item def BehavioralData :> ExchangeItem;
    item def PredictiveData :> ExchangeItem;
    item def BusCommand :> ExchangeItem;
    item def BusTelemetry :> ExchangeItem;
    item def SpaceSegmentTelemetry :> ExchangeItem;
    item def TelemetryReport :> ExchangeItem;
    item def GroundCommand :> ExchangeItem;

    // =====================================
    // Operational Entities
    // =====================================

    part def SpaceEnvironment :> OperationalEntity;
    part def SolarPanels :> OperationalEntity;
    part def Batteries :> OperationalEntity;
    part def PowerDistributionNetwork :> OperationalEntity;
    part def PowerConverters :> OperationalEntity; 
    part def Protections :> OperationalEntity;
    part def AutonomousControl :> OperationalEntity;
    part def Payloads :> OperationalEntity;
    part def SpaceSegmentServices :> OperationalEntity;
    part def GroundSegment :> OperationalEntity;

    // =====================================
    // Operational Activities
    // =====================================

    // Space Environment
    action def ImposeOrbitalConditions :> OperationalActivity{
        out environmentOut : EnvironmentConditions;
    }

    action def IrradiateSolarEnergy :> OperationalActivity{
        out solarFluxOut : SolarFlux;
    }

    // Solar Panels
    action def HarvestMaxSolarPower :> OperationalActivity{
        in environmentIn : EnvironmentConditions;
        in solarFluxOut : SolarFlux;
        out solarPower : Power;
    }

    // Batteries
    action def BufferExcessEnergy :> OperationalActivity{
        in environmentIn : EnvironmentConditions;
        out bufferPower : Power;
        out batteriesCondition : PhysicalConditions;
    }

    action def InterfaceProtectionsBAT :> OperationalActivity{
        in protectionAction : ProtectionAction;
        in bufferPowerIn : Power;
        in batteriesCondition : PhysicalConditions;
        out detectionAction : DetectionAction;
        out bufferPower : Power;
    }

    action def InterfaceSensingBAT :> OperationalActivity{
        in bufferPowerIn : Power;
        in batteriesCondition : PhysicalConditions;
        out bufferPower : Power;
        out sensorData : SensorData;
    } 
    
    // Distribution Network 
    action def DistributeAndSwitchPower :> OperationalActivity{
        in controlData : ControlData;
        in solarPower : Power;
        in bufferPower : Power;
        in regulatedPowerIn : Power;        
        out unregulatedPower : Power;
        out regulatedPower : Power;
        out statusData : StatusData;
    }    

    action def InterfaceProtectionsPDS :> OperationalActivity{
        in protectionAction : ProtectionAction;
        in unregulatedPowerIn : Power;
        in regulatedPowerIn : Power;
        out detectionAction : DetectionAction;
        out unregulatedPower : Power;
        out regulatedPower : Power;
    }

    action def InterfaceSensingPDS :> OperationalActivity{
        in regulatedPowerIn : Power;
        in unregulatedPowerIn : Power;
        out regulatedPower : Power;
        out unregulatedPower : Power;
        out sensorData : SensorData;
    }

    // Power Converters
    action def RegulateAndFilterPowerRails :> OperationalActivity{
        in unregulatedPower : Power;
        out regulatedPower : Power;
    }     

    // Protections
    action def DetectIsolateAndRecoverFromFailures :> OperationalActivity{
        in detectionAction : DetectionAction;
        out protectionAction : ProtectionAction;
        out faultData : FaultData;
    }

    // Autonomous control
    action def ConsolidateDataForTelemetry :> OperationalActivity{
        in sensorData : SensorData;
        in faultData : FaultData;
        in statusData : StatusData;
        in behavioralData : BehavioralData;
        out powerTelemetry : BusTelemetry;        
    }

    action def UpdateBehavioralDataAndCalculatePredictions :> OperationalActivity{
        in sensorData : SensorData;
        in faultData : FaultData;
        in statusData : StatusData;
        out behavioralData : BehavioralData;
        out predictiveData : PredictiveData;
    }

    action def PerformAutonomousControl :> OperationalActivity{
        in predictiveData: PredictiveData;
        in command : BusCommand;
        out controlData : ControlData;
    }

    //Payloads
    action def PerformMission :> OperationalActivity{
        in regulatedPower : Power;
        in controlData : ControlData;
    }

    // Space Segment Services
    action def ConsumePowerForServices :> OperationalActivity{
        in regulatedPower : Power;
    }

    action def ReceiveAndProcessCommand :> OperationalActivity{
        in groundCommand : GroundCommand;
        out busCommand : BusCommand;
    }

    action def ConsolidateAndSendBusTelemetry :> OperationalActivity{
        in busTelemetry : BusTelemetry;
        out spaceSegmentTelemetry : SpaceSegmentTelemetry;
    }

    // Ground Segment
    action def ReceiveTelemetry :> OperationalActivity{
        in spaceSegmentTelemetry : SpaceSegmentTelemetry;
        out telemetryReport : TelemetryReport;
    } 

    action def DefineOperations :> OperationalActivity{
        in telemetryReport : TelemetryReport;
        out groundCommand : GroundCommand;
    }

    action def SendCommands :> OperationalActivity{
        in groundCommandIn : GroundCommand;
        out groundCommandOut : GroundCommand;
    }

    // =====================================
    // Operational Interactions
    // =====================================

    // Space Environment to Solar Panels

    // connection def SolarFluxToSolarPanels :> OperationalInteraction{
    //     end source : SolarFlux;
    //     end sink : SolarFlux;
    //     connection connect source to sink;
    // }

    // connection def SpaceEnvironmentToPower :> OperationalInteraction{
    //     end source : EnvironmentConditions;
    //     end sink : EnvironmentConditions;
    //     connection connect source to sink;
    // }
    
    // connection def UnregulatedPowerFlow :> OperationalInteraction{
    //     end source : Power;
    //     end sink : Power;
    //     connection connect source to sink;
    // }

    // connection def UnregulatedPower :> OperationalInteraction{
    //     end source : Power;
    //     end sink : Power;
    //     connection connect source to sink;
    // }
}
