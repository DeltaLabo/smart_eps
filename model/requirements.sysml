package 'EPS Requirement Definitions'
{
    // =====================================
    // Imports
    // =====================================

    public import SI::*;
    public import ISQ::*;
    public import MeasurementReferences::*;
    public import ScalarValues::*;
    public import 'Stakeholders'::*;
    public import 'System Definitions'::*;
    public import 'EPS parts'::*;

    // =====================================
    // Definitions
    // =====================================

    requirement def <EPS01> 'Power Rail Requirement' {
        doc /* The power rail shall provide
            * a stable voltage of a certain 
            * value and tolerance with a 
            * maximum current of a ceratain
            * value. 
            */
        subject pr : Power_Rail;
        stakeholder et : EPS_team;
        attribute atr_rail_voltage : Rail_Voltage;
        attribute atr_rail_voltage_tolerance : Rail_Voltage_Tolerance;
        attribute atr_rail_current : Rail_Current;
        require constraint { pr.actual_voltage > (atr_rail_voltage * (1 - atr_rail_voltage_tolerance) ) }
        require constraint { pr.actual_voltage < (atr_rail_voltage * (1 + atr_rail_voltage_tolerance) ) }
        require constraint { pr.actual_current <= atr_rail_current }
    }
}
package 'Smart EPS Requirements'
{
    // =====================================
    // Imports
    // =====================================
    private import 'EPS Requirement Definitions'::*;
    private import 'Smart EPS Parts'::*;

    requirement <'SPS01.01'> powerRail1 : 'Power Rail Requirement' {
        subject :>> pr = sps.rail5V0;
        attribute :>> atr_rail_voltage = 5.0 [V];
        attribute :>> atr_rail_voltage_tolerance = 0.1 [one];
        attribute :>> atr_rail_current = 2.0 [A];
    }
    requirement <'SPS01.02'> powerRail2 : 'Power Rail Requirement' {
        attribute :>> atr_rail_voltage = 3.3 [V];
        attribute :>> atr_rail_voltage_tolerance = 0.1 [one];
        attribute :>> atr_rail_current = 1.0 [A];
    }
}