package 'EPS parts'
{
    // =====================================
    // Imports
    // =====================================

    private import SI::*;
    private import MeasurementReferences::*;
    private import 'System Definitions'::*;
    private import 'Stakeholders'::*;

    // =====================================
    // Atributes
    // =====================================

    attribute def Rail_Voltage :> ElectricPotentialValue;
    attribute def Rail_Voltage_Tolerance :> ScalarValues::Real{
        unit = one;
    }
    attribute def Rail_Current :> ElectricCurrentValue;

    // =====================================
    // Parts
    // =====================================

    part def Power_Rail{
        doc /* A power rail that provides
            * electrical power to the system.
            */
        attribute actual_voltage : Rail_Voltage;
        attribute actual_current : Rail_Current;
    }
}