// =====================================
// What system users most achieve
// =====================================

package 'Operational Analysis'
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

    item PowerDemand : ExchangeItem;
    item PowerDelivery : ExchangeItem;
    item GroundCommand : ExchangeItem;
    item TelemetryReport : ExchangeItem;
    item AnomalyReport : ExchangeItem;

    // =====================================
    // Operational Entities and Activities
    // =====================================

    part Spacecraft : OperationalEntity {
        doc /* The spacecraft as an operational asset in orbit.
            */
        attribute :>> isHuman = false;
        action ProvideElectricalPower : OperationalActivity;
        action ManagePowerUsageByPriority : OperationalActivity;
        action MonitorPowerAndEnergyState : OperationalActivity;
    }

    part MissionOperators : OperationalEntity {
        doc /* Ground operators / mission control authority
            */
        attribute :>> isHuman = true;
        action CommandPowerPolicy : OperationalActivity;
    }

    part GroundSegment : OperationalEntity {
        doc /* Telemetry, tracking and command infrastructure
            */
        attribute :>> isHuman = false;
        action SendCommands : OperationalActivity;
        action ReceiveTelemetry : OperationalActivity;
    }

    part PowerConsumers : OperationalEntity {
        doc /* Power-consuming subsystems and payloads
            */
        attribute :>> isHuman = false;
        action RequestElectricalPower : OperationalActivity;
        action ConsumeElectricalPower : OperationalActivity;
    }

    part SpaceEnvironment : OperationalEntity {
        doc /* Operational environment
            */
        attribute :>> isHuman = false;
        action ImposeOrbitalConditions : OperationalActivity; 
    }

    // =====================================
    // Operational Interactions
    // =====================================  

    action PowerRequestInteraction : OperationalInteraction {
        in source = PowerConsumers.RequestElectricalPower;
        in target = Spacecraft.ProvideElectricalPower;
        in conveyed = PowerDelivery;
    }
}
