package OperationalMissions
{
    // =====================================
    // Imports
    // =====================================
    // public import SI::*;
    // public import ScalarValues::*;
    // public import MeasurementReferences::*;
    public import Arcadia::*;
    private import OperationalDefinitions::*;

    // =====================================
    // Missions and Operational Capabilities
    // =====================================

    // Solar energy conversion
    use case OA_M1_ConvertSolarEnergy : OperationalMission {
        doc /* Convert solar energy into electrical energy
            to sustain the energy needs of the spacecraft bus and payloads. */
        use case OA_M1_OC1_HarvestAndMaximizeSolarPower : OperationalCapability;
    }

    // Energy storage
    use case OA_M2_StoreEnergy : OperationalMission {
        doc /* Store excess energy from solar conversion to enable 
        operation during eclipse. */
        use case OA_M2_OC1_ChargeAndDischargeStorage : OperationalCapability;
    }

    // Conditioning (regulation and filtering)
    use case OA_M3_ConditionPower : OperationalMission {
        doc /* Regulate and filter power to meet bus 
        and payload voltage levels, quality and stability requirements. */
        use case OA_M3_OC1_RegulateAndFilterPower : OperationalCapability;
    }

    // Distribution
    use case OA_M4_DistributePower : OperationalMission {
        doc /* Distribute power to spacecraft services and payloads
        according to demand and priority. */
        use case OA_M4_OC1_RoutePowerToLoads : OperationalCapability;
    }

    // Protection
    use case OA_M5_ProtectPowerSystem : OperationalMission {
        doc /* Prevent, detect, and isolate unsafe electrical 
        conditions to safeguard the space segment. */
        use case OA_M5_OC1_DetectAndIsolateFaults : OperationalCapability;
        use case OA_M5_OC2_ContainAndPreventPropagation : OperationalCapability;
        use case OA_M5_OC3_EnableSafeRecovery : OperationalCapability;
    }

    // Automation (sensing and control)
    use case OA_M6_EnableAutonomousOps : OperationalMission {
        doc /* Govern power safely and effectively without ground intervention 
        when in autonomous mode. */
        use case OA_M6_OC1_SenseControlAndReportPowerState : OperationalCapability;
        use case OA_M6_OC2_RunAutonomousPowerGovernance : OperationalCapability;
        use case OA_M6_OC3_TransitionBetweenGroundAndAutonomy : OperationalCapability;
    }

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
}