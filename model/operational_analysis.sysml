// =====================================
// What system users most achieve
// =====================================

package 'Operational Analysis'
{
    // =====================================
    // Imports
    // =====================================

    private import OperationalAnalysisDefinitions::*;

    // // =====================================
    // // Operational Analysis Context
    // // =====================================  

    part spacecraftBus : SpacecraftBus {
        in item environment : EnvironmentConditions;
        in item telemetry : InternalBusTelemetry;
        perform action harvestSolar : HarvestSolarEnergy{
            in environment : EnvironmentConditions;
            out powerOut: Power;
        }
        perform action storeEnergy : StoreEnergy {
            in environment : EnvironmentConditions;
            in powerIn : Power;
            out powerOut : Power;
        }
        perform action distributePower : DistributeElectricalPower {
            in switchAndControl : PowerSwitchAndControl;
            in powerIn : Power;
            out powerOut : Power;
        }
        perform action monitorPowerState : MonitorPowerAndEnergyState {
            in telemetryRaw : InternalBusTelemetry;
            out telemetryProcessed : InternalBusTelemetry;
        }
        perform action managePowerUsage : ManagePowerUsageByPriority {
            in telemetryProcessed : InternalBusTelemetry;
            out switchAndControl : PowerSwitchAndControl;
        }
        out item powerOut : Power;

        binding bind harvestSolar.environment = environment;
        binding bind harvestSolar.powerOut = storeEnergy.powerIn;
        binding bind harvestSolar.powerOut = distributePower.powerIn;
        binding bind storeEnergy.powerOut = distributePower.powerIn;
        binding bind storeEnergy.environment = environment;
        binding bind distributePower.powerOut = powerOut;
        binding bind monitorPowerState.telemetryRaw = telemetry;
        binding bind monitorPowerState.telemetryProcessed = managePowerUsage.telemetryProcessed;
        binding bind managePowerUsage.switchAndControl = distributePower.switchAndControl;
    }

    part powerConsumers : PowerConsumers {
        in item powerIn : Power;
        perform action consumePower : ConsumeElectricalPower {
            in power : Power;
        }
        binding bind consumePower.power = powerIn;
    }

    part missionOperators : MissionOperators {
        in item telemetry : TelemetryReport;
        out item command : GroundCommand;
        perform action commandPowerPolicy : CommandPowerPolicy {
            in telemetryReport : TelemetryReport;
            out groundCommand : GroundCommand;
        }
        binding bind commandPowerPolicy.telemetryReport = telemetry;
        binding bind commandPowerPolicy.groundCommand = command;
    }

    part groundSegment : GroundSegment {
        in item commandIn : GroundCommand;
        in item telemetryIn : TelemetryReport;
        out item commandOut : GroundCommand;
        out item telemetryOut : TelemetryReport;
        perform action sendCommands : SendCommands {
            in groundCommandIn : GroundCommand;
            out groundCommandOut : GroundCommand;
        }
        perform action receiveTelemetry : ReceiveTelemetry {
            in telemetryReportIn : TelemetryReport;
            out telemetryReportOut : TelemetryReport;
        }
        binding bind sendCommands.groundCommandIn = commandIn;
        binding bind sendCommands.groundCommandOut = commandOut;
        binding bind receiveTelemetry.telemetryReportIn = telemetryIn;
        binding bind receiveTelemetry.telemetryReportOut = telemetryOut;
    }

    part spaceEnvironment : SpaceEnvironment {
        out item environment : EnvironmentConditions;
        perform action imposeOrbitalConditions : ImposeOrbitalConditions {
            out environmentConditions : EnvironmentConditions;
        }
        binding bind imposeOrbitalConditions.environmentConditions = environment;
    }

    // =====================================
    // Operational Interactions
    // =====================================  

    connect spacecraftBus.powerOut to powerConsumers.powerIn;
    connect spacecraftBus.telemetry to spacecraftBus.telemetry;
    connect missionOperators.command to groundSegment.commandIn;
    connect groundSegment.telemetryOut to missionOperators.telemetry;
    connect spaceEnvironment.environment to spacecraftBus.environment;


    // part Ejemplo {
    //     part spacecraft : Spacecraft{
    //         port power;
    //     }
    //     part powerConsumers : PowerConsumers{
    //         port power;
    //     }
    //     connection PowerRequestInteraction : OperationalInteraction connect
    //         powerConsumers.power to spacecraft.power {
    //             flow of power : Power {
    //                 end ::> fromOA;
    //                 end ::> toOA;
    //             }
    //         }
    // }
}
