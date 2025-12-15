package 'OA_Minimum_Spacecraft_PowerConsumers' {

    // =====================================
    // Imports
    // =====================================
    public import SI::*;
    public import ScalarValues::*;
    public import MeasurementReferences::*;
    public import Arcadia::*;

    // =========================
    // Exchange items (the arrows)
    // =========================
    item def PowerDemand;
    item def PowerGrant;

    // =========================
    // Operational Entity types (classifiers)
    // =========================
    part def OperationalEntity {
        attribute isHuman : Boolean;
    }

    part def Spacecraft      :> OperationalEntity;
    part def PowerConsumers  :> OperationalEntity;

    // =========================
    // Operational Activities (classifiers)
    // =========================
    // PowerConsumers activities (>=2)
    action def RequestPower {
        out demand : PowerDemand;
    }

    action def ConsumeGrantedPower {
        in grant : PowerGrant;
    }

    // Spacecraft activities (>=2)
    action def AssessAndPrioritizeDemand {
        in demand : PowerDemand;
        out grant : PowerGrant;
    }

    action def MonitorPowerState {
        // keep it minimal here; you can add outputs later (telemetry, SOC, etc.)
    }

    // =========================
    // OA Context (entity usages + allocations + interactions)
    // =========================

    part spacecraft : Spacecraft {
        attribute :>> isHuman = false;

        // Ports that carry interaction items (typed)
        port demandIn {
            in item demand : PowerDemand;
        }
        port grantOut {
            out item grant : PowerGrant;
        }

        // Allocate (perform) activities inside the entity usage
        perform action assess : AssessAndPrioritizeDemand {
            in  demand : PowerDemand = demandIn.demand;
            out grant  : PowerGrant  = grantOut.grant;
        }

        perform action monitor : MonitorPowerState;
    }

    part consumers : PowerConsumers {
        attribute :>> isHuman = false;

        port demandOut {
            out item demand : PowerDemand;
        }
        port grantIn {
            in item grant : PowerGrant;
        }

        perform action request : RequestPower {
            out demand : PowerDemand = demandOut.demand;
        }

        perform action consume : ConsumeGrantedPower {
            in grant : PowerGrant = grantIn.grant;
        }
    }

    // =========================
    // Interactions (the arrows between entities)
    // =========================

    // demand: consumers -> spacecraft
    connect consumers.demandOut to spacecraft.demandIn;

    // grant: spacecraft -> consumers
    connect spacecraft.grantOut to consumers.grantIn;

}
