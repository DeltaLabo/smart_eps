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

    // =====================================
    // Operational Entities
    // =====================================

    part Spacecraft : OperationalEntity {
        doc /* The spacecraft as an operational asset in orbit.
             */
        attribute :>> isHuman = false;
    }

    part MissionOperators : OperationalEntity {
        doc /* Ground operators / mission control authority
             */
        attribute :>> isHuman = true;
    }

    part GroundSegment : OperationalEntity {
        doc /* Telemetry, tracking and command infrastructure
             */
        attribute :>> isHuman = false;
    }

    part PowerConsumers : OperationalEntity {
        doc /* Power-consuming subsystems and payloads
             */
        attribute :>> isHuman = false;
    }

    part SpaceEnvironment : OperationalEntity {
        doc /* Operational environment
             */
        attribute :>> isHuman = false;
    }

    // // =====================================
    // // Missions and Operational Capabilities
    // // =====================================

    // // --- Mission definitions ---
    // item def OperationalMission;

    // item def OperationalCapability;

    // item def OA_M1_ProvidePowerService : OperationalMission;
    // item def OA_M2_MaintainEnergySafetySurvivability : OperationalMission;
    // item def OA_M3_EnableAutonomousPowerGovernance : OperationalMission;

    // // --- Capability definitions (lean set) ---
    // item def OC1_1_ProvideRegulatedPowerRails : OperationalCapability;
    // item def OC1_2_ManagePowerDistribution : OperationalCapability;
    // item def OC1_3_SupportPowerAcrossPhases : OperationalCapability;

    // item def OC2_1_PreventUnsafeBatteryConditions : OperationalCapability;
    // item def OC2_2_SurviveEnvironmentConstraints : OperationalCapability;
    // item def OC2_3_EnterMaintainPowerSafeState : OperationalCapability;

    // item def OC3_1_SwitchBetweenSupervisedAndAutonomous : OperationalCapability;
    // item def OC3_2_DetectAndRespondToPowerAnomalies : OperationalCapability;
    // item def OC3_3_ShedAndRecoverLoadsByPriority : OperationalCapability;
    // item def OC3_4_ReportEnergyStateAndActions : OperationalCapability;

    // // --- Traceability-style associations (lightweight, OA-level) ---
    // // If your tool supports relationships, replace these comments with actual links.
    // doc /*
    //   Mission OA_M1 is supported by: OC1_1, OC1_2, OC1_3
    //   Mission OA_M2 is supported by: OC2_1, OC2_2, OC2_3
    //   Mission OA_M3 is supported by: OC3_1, OC3_2, OC3_3, OC3_4
    // */

    // // =====================================
    // // Operational Modes (EPS-relevant only)
    // // =====================================

    // item def OperationalMode;
    // item def SunlightMode  : OperationalMode;
    // item def EclipseMode   : OperationalMode;
    // item def SafeMode      : OperationalMode;
    // item def CommissioningMode : OperationalMode;
    // item def FaultRecoveryMode  : OperationalMode;

    // doc /*
    //   Operational mode intent:
    //   - SunlightMode: generation available; recharge + nominal ops.
    //   - EclipseMode: energy deficit; strict governance + shedding likely.
    //   - SafeMode: survival loads only; protect battery; wait for recovery.
    //   - CommissioningMode: early ops; cautious enablement; high monitoring.
    //   - FaultRecoveryMode: isolate faults; controlled restoration.
    // */

    // // =====================================
    // // Operational Scenarios (automation drivers)
    // // =====================================

    // item def OperationalScenario;

    // item def OA_S1_EclipseEntry_LoadShedding : OperationalScenario;
    // item def OA_S2_BatteryOverTemp_ProtectionAndRecovery : OperationalScenario;
    // item def OA_S3_RailLatchUp_IsolateAndReport : OperationalScenario;
    // item def OA_S4_LossOfGroundContact_AutonomousGovernance : OperationalScenario;
    // item def OA_S5_ReturnToNominal_ControlledLoadRestoration : OperationalScenario;

    // doc /*
    //   Each scenario should later become:
    //   - OA interaction scenario (entities exchange operational signals),
    //   - then SA scenarios (system responsibilities),
    //   - then LA/PA behaviors (how it's implemented).
    // */

    // // =====================================
    // // Minimal Operational Constraints (placeholders)
    // // These are OA "drivers" — not EPS requirements yet.
    // // =====================================

    // // Example metrics/placeholders (you will refine later in SA/requirements)
    // attribute def TimeToShedCriticalLoads :> Real { unit = SI::s; }
    // attribute def MinimumSOCAtEclipseExit :> Real { unit = one; }
    // attribute def MaxAllowedRailDeviation :> Real { unit = one; } // e.g., % or ratio
    // attribute def MaxBatteryTemperature :> Real { unit = SI::K; }

    // // Optional: attach these to missions/capabilities later with relationships.
}
