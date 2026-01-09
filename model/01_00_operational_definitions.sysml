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
    item def Power :> ExchangeItem;
    item def InternalBusTelemetry :> ExchangeItem;
    item def InternalBusCommand :> ExchangeItem;
    item def ControlData :> ExchangeItem;
    item def FaultData :> ExchangeItem;
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
    part def PowerConverters :> OperationalEntity; 
    part def PowerDistributionNetwork :> OperationalEntity;
    part def Payloads :> OperationalEntity;
    part def SpacecraftCommandAndControl :> OperationalEntity;
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
        out powerOut : Power;
    }

    // Batteries
    action def BufferExcessEnergy :> OperationalActivity{
        in environmentIn : EnvironmentConditions;
        in powerIn : Power;
        out powerOut : Power;
    }

    // Power Converters
    action def RegulatePowerRails :> OperationalActivity{
        in powerIn : Power;
        out powerOut : Power;
    }      

    action def FilterPowerRails :> OperationalActivity{
        in powerIn : Power;
        out powerOut : Power;
    } 
    
    // Distribution Network 
    action def DistributePower :> OperationalActivity{
        in powerIn : Power;
        out powerOut : Power;
    }    

    action def SwitchPowerLines :> OperationalActivity{
        in control : ControlData;
        in powerIn : Power;
        in powerOut : Power;
    }

    // Protections
    action def DetectUnsafeElectricalConditions :> OperationalActivity{
        in powerIn : Power;
        out powerOut : Power;
        out faultData : FaultData;
    }

    action def IsolateFailures :> OperationalActivity{
        in powerIn : Power;
        out powerOut : Power;
    }

    action def EnableRecovery :> OperationalActivity{
        in powerIn : Power;
        out powerOut : Power;
    }

    // Autonomous control
    action def SenseAndConsolidate :> OperationalActivity{
        in powerIn : Power;
        out powerOut : Power;
        out sensorData : SensorData;
    }

    action def UpdateBehavioralData :> OperationalActivity{
        in sensorData : SensorData;
        in behavioralDataIn : BehavioralData;
        out behavioralDataOut : BehavioralData;
    }    

    action def CalculatePredictions :> OperationalActivity{
        in behavioralData : BehavioralData;
        out predictiveData : PredictiveData;
    }

    action def AutonomousControl :> OperationalActivity{
        in predictiveData: PredictiveData;
        in command : BusCommand;
        out control : ControlData;
    }

    action def ConstructPowerTelemetry :> OperationalActivity{
        in sensorData : SensorData;
        in faultData : FaultData;
        out powerTelemetry : BusTelemetry;
    }

    // Spacecraft Command and Control
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

    connection def SolarFluxToSolarPanels :> OperationalInteraction{
        end source : SolarFlux;
        end sink : SolarFlux;
        connection connect source to sink;
    }

    connection def SpaceEnvironmentToPower :> OperationalInteraction{
        end source : EnvironmentConditions;
        end sink : EnvironmentConditions;
        connection connect source to sink;
    }
    
    connection def UnregulatedPowerFlow :> OperationalInteraction{
        end source : Power;
        end sink : Power;
        connection connect source to sink;
    }

    connection def UnregulatedPower :> OperationalInteraction{
        end source : Power;
        end sink : Power;
        connection connect source to sink;
    }

    // connection def TelemetryToMC :> OperationalInteraction{
    //     end source : TelemetryReport;
    //     end sink : TelemetryReport;
    //     connection connect source to sink;
    // }



    // connection def CommandToSC :> OperationalInteraction{
    //     end source : GroundCommand;
    //     end sink : GroundCommand;
    //     connection connect source to sink;
    // }

    // connection def TelemetryToGS :> OperationalInteraction{
    //     end source : TelemetryReport;
    //     end sink : TelemetryReport;
    //     connection connect source to sink;
    //}
}
