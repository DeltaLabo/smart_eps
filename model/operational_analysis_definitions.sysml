package OperationalAnalysisDefinitions
{
    // =====================================
    // Imports
    // =====================================
    public import SI::*;
    public import ScalarValues::*;
    public import MeasurementReferences::*;
    public import Arcadia::*;

    // // =====================================
    // // Missions and Operational Capabilities
    // // =====================================

    // use case OA_M1_ProvideElectricalPower : OperationalMission {
    //     use case OC1_1_ProvideUnregulatedPowerRail : OperationalCapability;
    //     use case OC1_2_ProvideRegulatedPowerRails : OperationalCapability;
    //     use case OC1_3_ManagePowerDistribution : OperationalCapability;
    //     use case OC1_4_SupportPowerAcrossPhases : OperationalCapability;
    // }

    // use case OA_M2_MaintainEnergySafetySurvivability : OperationalMission{
    //     use case OC2_1_PreventUnsafeBatteryConditions : OperationalCapability;
    //     use case OC2_2_SurviveEnvironmentConstraints : OperationalCapability;
    //     use case OC2_3_EnterMaintainPowerSafeState : OperationalCapability;
    // }

    // use case OA_M3_EnableAutonomousPowerGovernance : OperationalMission{
    //     use case OC3_1_SwitchBetweenSupervisedAndAutonomous : OperationalCapability;
    //     use case OC3_2_DetectAndRespondToPowerAnomalies : OperationalCapability;
    //     use case OC3_3_ShedAndRecoverLoadsByPriority : OperationalCapability;
    //     use case OC3_4_ReportEnergyStateAndActions : OperationalCapability;
    // }

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

    item def EnvironmentConditions :> ExchangeItem;
    item def Power :> ExchangeItem;
    item def InternalBusTelemetry :> ExchangeItem;
    item def InternalBusCommand :> ExchangeItem;
    item def PowerSwitchAndControl :> ExchangeItem;
    item def GroundCommand :> ExchangeItem;
    item def TelemetryReport :> ExchangeItem;
    item def AnomalyReport :> ExchangeItem;

    // =====================================
    // Operational Entities
    // =====================================

    part def SpaceEnvironment :> OperationalEntity {
        doc /* Operational environment
            */
        attribute :>> isHuman = false;
    }

    part def SpacecraftBus :> OperationalEntity {
        doc /* The spacecraft bus, includes solar arrays and battery
            */
        attribute :>> isHuman = false;
    }

    part def PowerConsumers :> OperationalEntity {
        doc /* Power-consuming subsystems and payloads
            */
        attribute :>> isHuman = false;
    }

    part def MissionOperators :> OperationalEntity {
        doc /* Ground operators / mission control authority
            */
        attribute :>> isHuman = true;
    }

    part def GroundSegment :> OperationalEntity {
        doc /* Telemetry, tracking and command infrastructure
            */
        attribute :>> isHuman = false;
    }

    // =====================================
    // Operational Activities
    // =====================================

    // SpacecraftBus
    action def HarvestSolarEnergy :> OperationalActivity{
        in environment : EnvironmentConditions;
        out powerOut : Power;
    }

    action def StoreEnergy :> OperationalActivity{
        in environment : EnvironmentConditions;
        in powerIn : Power;
        out powerOut : Power;
    }
    
    action def DistributeElectricalPower :> OperationalActivity{
        in switchAndControl : PowerSwitchAndControl;
        in powerIn : Power;
        out powerOut : Power;
    }    

    action def ManagePowerUsageByPriority :> OperationalActivity{
        in telemetryProcessed : InternalBusTelemetry;
        out switchAndControl : PowerSwitchAndControl;
    }

    action def MonitorPowerAndEnergyState :> OperationalActivity{
        in telemetryRaw : InternalBusTelemetry;
        out telemetryProcessed : InternalBusTelemetry;
    }

    action def ProcessCommands :> OperationalActivity{
        in commandIn : GroundCommand;
        out commandOut : InternalBusCommand;
    }

    // PowerConsumers
    action def ConsumeElectricalPower :> OperationalActivity{
        in power : Power;
    }

    // MissionOperators
    action def CommandPowerPolicy :> OperationalActivity{
        in telemetryReport : TelemetryReport;
        out groundCommand : GroundCommand;
    }

    // GroundSegment
    action def SendCommands :> OperationalActivity{
        in groundCommandIn : GroundCommand;
        out groundCommandOut : GroundCommand;
    }

    action def ReceiveTelemetry :> OperationalActivity{
        in telemetryReportIn : TelemetryReport;
        out telemetryReportOut : TelemetryReport;
    }

    // SpaceEnvironment
    action def ImposeOrbitalConditions :> OperationalActivity{
        out environmentConditions : EnvironmentConditions;
    }
}