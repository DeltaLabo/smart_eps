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
        // port powerPort {
        //     out item power : Power;
        // }
        // port powerControlPort {
        //     out item powerSAC : PowerSwitchingAndControl;
        // }
        // port environmentConditionsPort {
        //     in item environmentConditions : EnvironmentConditions;
        // }
        // port internalBusTelemetryProcessPort {
        //     in item internalBusTelemetryProcessIn : InternalBusTelemetry;
        //     out item internalBusTelemetryProcessOut : InternalBusTelemetry;
        // }
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
        // port powerPort {
        //     in item power : Power;
        // }
        in item powerIn : Power;

        perform action consumePower : ConsumeElectricalPower {
            in powerIn : Power;
        }
    }

    // =====================================
    // Operational Interactions
    // =====================================  

    connect spacecraftBus.powerOut to powerConsumers.powerIn;
    connect spacecraftBus.telemetry to spacecraftBus.telemetry;


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
