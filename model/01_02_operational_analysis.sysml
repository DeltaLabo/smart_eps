// =====================================
// What system users most achieve
// =====================================

package 'Operational Analysis'
{
    // =====================================
    // Imports
    // =====================================

    private import OperationalDefinitions::*;

    // // =====================================
    // // Operational Analysis Context
    // // =====================================  

    part spaceEnvironment : SpaceEnvironment{
        out item environmentConditions : EnvironmentConditions;
        out item solarFlux : SolarFlux;        
        perform action imposeOrbitalConditions : ImposeOrbitalConditions{
            out environmentConditions : EnvironmentConditions;
        }
        perform action irradiateSolarEnergy : IrradiateSolarEnergy{
            out solarFlux : SolarFlux;
        }
        binding bind irradiateSolarEnergy.solarFlux = solarFlux;
    }

    part solarPanels : SolarPanels{
        in item environmentConditions : EnvironmentConditions;
        in item solarFlux : SolarFlux;        
        out item power : Power;
        perform action harvestMaxSolarPower : HarvestMaxSolarPower{
            in environmentConditions : EnvironmentConditions;
            in solarFlux : SolarFlux;
            out power : Power;
        }
        binding bind harvestMaxSolarPower.environmentConditions = environmentConditions;
        binding bind harvestMaxSolarPower.solarFlux = solarFlux;
        binding bind harvestMaxSolarPower.power = power;
    }

    part batteries : Batteries{
        in item environmentConditions : EnvironmentConditions;
        port power : Power;
        perform action bufferExcessEnergy : BufferExcessEnergy{
            in environmentConditions : EnvironmentConditions;
            power : Power;
        }
        binding bind bufferExcessEnergy.environmentConditions = environmentConditions;
        binding bind bufferExcessEnergy.power = power;
    }

    part powerDistributionNetwork : PowerDistributionNetwork{
        in item solarIn : Power;
        out item unregOut : Power;
        port batteries : Power;
        perform action distributeUnregulatedPower : DistributePower{
            in solarIn : Power;
            out unregOut : Power;
            batteries : Power;
        }
        binding bind distributeUnregulatedPower.solarIn = solarIn;
        binding bind distributeUnregulatedPower.unregOut = unregOut;
        binding bind distributeUnregulatedPower.batteries = batteries;
    }

    part powerConverters : PowerConverters{
        in item powerIn : Power;
    }
    
    connection solarFluxToSolarPanels : SolarFluxToSolarPanels connect
        spaceEnvironment.solarFlux to solarPanels.solarFlux;

    connection spaceEnvironmentToPanels : SpaceEnvironmentToPower connect
        spaceEnvironment.environmentConditions to solarPanels.environmentConditions;

    connection spaceEnvironmentToBatteries : SpaceEnvironmentToPower connect
        spaceEnvironment.environmentConditions to batteries.environmentConditions;
    
    connection panelsToPDS : UnregulatedPowerFlow connect
        solarPanels.power to powerDistributionNetwork.solarIn;
    
    connection pdsToBatteries : UnregulatedPowerFlow connect
        powerDistributionNetwork.batteries to batteries.power;

    connection pdsToPowerConverters : UnregulatedPowerFlow connect
        powerDistributionNetwork.unregOut to powerConverters.powerIn;

    // part def PowerDistributionNetwork :> OperationalEntity;
    // part def Payloads :> OperationalEntity;
    // part def SpacecraftCommandAndControl :> OperationalEntity;
    // part def GroundSegment :> OperationalEntity;
    // part spacecraftBus : SpacecraftBus {
    //     in item environment : EnvironmentConditions;
    //     in item internalTelemetry : InternalBusTelemetry;
    //     in item commandIn : GroundCommand;
    //     perform action harvestSolar : HarvestSolarEnergy{
    //         in environment : EnvironmentConditions;
    //         out powerOut: Power;
    //     }
    //     perform action storeEnergy : StoreEnergy {
    //         in environment : EnvironmentConditions;
    //         in powerIn : Power;
    //         out powerOut : Power;
    //     }
    //     perform action distributePower : DistributeElectricalPower {
    //         in switchAndControl : PowerSwitchAndControl;
    //         in powerIn : Power;
    //         out powerOut : Power;
    //     }
    //     perform action processCommands : ProcessCommands {
    //         in commandIn : GroundCommand;
    //         out commandProcessed : InternalBusCommand;
    //     }
    //     perform action monitorPowerState : MonitorPowerAndEnergyState {
    //         in telemetryRaw : InternalBusTelemetry;
    //         out telemetryProcessed : InternalBusTelemetry;
    //     }
    //     perform action managePowerUsage : ManagePowerUsageByPriority {
    //         in telemetryProcessed : InternalBusTelemetry;
    //         in commandIn : InternalBusCommand;
    //         out switchAndControl : PowerSwitchAndControl;
    //     }
    //     perform action sendTelemetry : SendTelemetry {
    //         in telemetryIn : InternalBusTelemetry;
    //         out telemetryOut : TelemetryReport;
    //     }
    //     out item powerOut : Power;
    //     out item telemetry : TelemetryReport;

    //     binding bind harvestSolar.environment = environment;
    //     binding bind harvestSolar.powerOut = storeEnergy.powerIn;
    //     binding bind harvestSolar.powerOut = distributePower.powerIn;
    //     binding bind storeEnergy.powerOut = distributePower.powerIn;
    //     binding bind storeEnergy.environment = environment;
    //     binding bind distributePower.powerOut = powerOut;
    //     binding bind processCommands.commandIn = commandIn;
    //     binding bind processCommands.commandProcessed = managePowerUsage.commandIn;
    //     binding bind monitorPowerState.telemetryRaw = internalTelemetry;
    //     binding bind monitorPowerState.telemetryProcessed = managePowerUsage.telemetryProcessed;
    //     binding bind managePowerUsage.switchAndControl = distributePower.switchAndControl;
    //     binding bind sendTelemetry.telemetryIn = monitorPowerState.telemetryProcessed;
    //     binding bind sendTelemetry.telemetryOut = telemetry;
    // }

    // part powerConsumers : PowerConsumers {
    //     in item powerIn : Power;
    //     perform action consumePower : ConsumeElectricalPower {
    //         in power : Power;
    //     }
    //     binding bind consumePower.power = powerIn;
    // }

    // part missionOperators : MissionOperators {
    //     in item telemetry : TelemetryReport;
    //     out item command : GroundCommand;
    //     perform action commandPowerPolicy : CommandPowerPolicy {
    //         in telemetryReport : TelemetryReport;
    //         out groundCommand : GroundCommand;
    //     }
    //     binding bind commandPowerPolicy.telemetryReport = telemetry;
    //     binding bind commandPowerPolicy.groundCommand = command;
    // }

    // part groundSegment : GroundSegment {
    //     in item commandIn : GroundCommand;
    //     in item telemetryIn : TelemetryReport;
    //     out item commandOut : GroundCommand;
    //     out item telemetryOut : TelemetryReport;
    //     perform action sendCommands : SendCommands {
    //         in groundCommandIn : GroundCommand;
    //         out groundCommandOut : GroundCommand;
    //     }
    //     perform action receiveTelemetry : ReceiveTelemetry {
    //         in telemetryReportIn : TelemetryReport;
    //         out telemetryReportOut : TelemetryReport;
    //     }
    //     binding bind sendCommands.groundCommandIn = commandIn;
    //     binding bind sendCommands.groundCommandOut = commandOut;
    //     binding bind receiveTelemetry.telemetryReportIn = telemetryIn;
    //     binding bind receiveTelemetry.telemetryReportOut = telemetryOut;
    // }

    // part spaceEnvironment : SpaceEnvironment {
    //     out item environment : EnvironmentConditions;
    //     perform action imposeOrbitalConditions : ImposeOrbitalConditions {
    //         out environmentConditions : EnvironmentConditions;
    //     }
    //     binding bind imposeOrbitalConditions.environmentConditions = environment;
    // }

    // connection transferPower : TransferPower connect 
    //     spacecraftBus.powerOut to powerConsumers.powerIn;

    // connect spacecraftBus.internalTelemetry to spacecraftBus.internalTelemetry;//Check this

    // connection sendCommandToGS : SendCommandToGS connect
    //     missionOperators.command to groundSegment.commandIn;

    // connection telemetryToMC : TelemetryToMC connect 
    //     groundSegment.telemetryOut to missionOperators.telemetry;
    
    // connection environmentToSC : EnvironmentToSC connect 
    //     spaceEnvironment.environment to spacecraftBus.environment;

    // connection commandToSC : CommandToSC connect 
    //     groundSegment.commandOut to spacecraftBus.commandIn;
    
    // connection telemetryToGS : TelemetryToGS connect 
    //     spacecraftBus.telemetry to groundSegment.telemetryIn;
}
