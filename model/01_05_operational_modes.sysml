package OperationalModes
{
    // =====================================
    // Imports
    // =====================================
    private import OperationalDefinitions::*;
    public import Arcadia::*;

    // ==========================================================
    // EPS Operational Modes State Machine
    //   Tres dimensiones en paralelo:
    //   1) Authority (quién manda)
    //   2) EnergyCycle (Sunlight/Eclipse)
    //   3) HealthControl (Nominal/FDIR)
    // ==========================================================
    state def EPS_OperationalModes_SM
    {
        in modeEvtPort : OperationalDefinitions::EPSModeEventPort;
        entry;
        then Operational;

        state Operational parallel
        {
            // ======================================================
            // Authority
            // ======================================================
            state Authority
            {
                entry;
                then AutonomousGovernance;

                state AutonomousGovernance {
                }
                state CommandedByOBC {
                }
                state GroundOverride {
                }

                transition Auto_to_Cmd
                    first AutonomousGovernance
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::CommandedModeEnabled)
                    then CommandedByOBC;

                transition Cmd_to_Auto
                    first CommandedByOBC
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::CommandedModeDisabled)
                    then AutonomousGovernance;

                transition Auto_to_Ground
                    first AutonomousGovernance
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::GroundOverrideEnabled)
                    then GroundOverride;

                transition Cmd_to_Ground
                    first CommandedByOBC
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::GroundOverrideEnabled)
                    then GroundOverride;

                transition Ground_to_Auto
                    first GroundOverride
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::GroundOverrideDisabled)
                    then AutonomousGovernance;
            }

            // ======================================================
            // 2) EnergyCycle
            // ======================================================
            state EnergyCycle
            {
                entry;
                then Sunlight_Charge;

                state Sunlight_Charge {
                }
                state Eclipse_Discharge {
                }

                transition Sun_to_Ecl
                    first Sunlight_Charge
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::EnterEclipse)
                    then Eclipse_Discharge;

                transition Ecl_to_Sun
                    first Eclipse_Discharge
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::EnterSunlight)
                    then Sunlight_Charge;
            }

            // ======================================================
            // 3) HealthControl: nominal / contingencia
            // ======================================================
            state HealthControl
            {
                entry;
                then InitCommissioning;

                state InitCommissioning {
                }
                state Nominal {
                }
                state LoadShedding {
                }
                state ProtectionIsolation {
                }
                state Recovery {
                }
                state SafeSurvival {
                }

                // --- Arranque ---
                transition Init_to_Nominal
                    first InitCommissioning
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::InitComplete)
                    then Nominal;

                // --- Energía baja / restauración ---
                transition Nom_to_Shed
                    first Nominal
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::SOC_Low)
                    then LoadShedding;

                transition Shed_to_Nom
                    first LoadShedding
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::SOC_Recovered)
                    then Nominal;

                // --- Fallas o protecciones ---
                transition Nom_to_Prot_Latch
                    first Nominal
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::RailLatchUpDetected)
                    then ProtectionIsolation;

                transition Nom_to_Prot_Temp
                    first Nominal
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::BatteryOverTemp)
                    then ProtectionIsolation;

                transition Shed_to_Prot_Latch
                    first LoadShedding
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::RailLatchUpDetected)
                    then ProtectionIsolation;

                transition Shed_to_Prot_Temp
                    first LoadShedding
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::BatteryOverTemp)
                    then ProtectionIsolation;

                // --- Recuperación / salida de protección ---
                transition Prot_to_Recovery
                    first ProtectionIsolation
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::FaultCleared)
                    then Recovery;

                transition Recovery_to_Nominal
                    first Recovery
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::SOC_Recovered)
                    then Nominal;

                transition Recovery_to_Safe
                    first Recovery
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::RecoveryFailed)
                    then SafeSurvival;

                transition Safe_to_Recovery
                    first SafeSurvival
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::FaultCleared)
                    then Recovery;

                transition Safe_to_Nominal
                    first SafeSurvival
                    accept EPS_Event via modeEvtPort
                    if (modeEvtPort.evt.kind == EPS_EventKind::SOC_Recovered)
                    then Nominal;
            }
        }
    }
}
