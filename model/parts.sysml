package 'EPS parts'
{
    // =====================================
    // Imports
    // =====================================

    public import SI::*;
    public import MeasurementReferences::*;
    public import 'System Definitions'::*;
    public import 'Stakeholders'::*;

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
package 'Smart EPS Parts'
{
    // =====================================
    // Imports
    // =====================================

    private import 'EPS parts'::*;

    // =====================================
    // Parts
    // =====================================

    part sps : SPS {
        doc /* Smart Power System
            */
        part rail5V0 : Power_Rail {
            attribute :>> actual_voltage = 5.0 [V];
            attribute :>> actual_current = 0.0 [A]; // Initial current is zero
        }
        part rail3V3 : Power_Rail {
            attribute :>> actual_voltage = 3.3 [V];
            attribute :>> actual_current = 0.0 [A]; // Initial current is zero
        }
    }
}