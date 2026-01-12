package 'Operational Requirements'
{

    // =====================================
    // Imports
    // =====================================

    public import Arcadia::*;
    private import OperationalDefinitions::*;

    // =====================================
    // Solar Panels
    // =====================================

    requirement <OR01> 'Solar Energy Provision Requirement' {
        doc
        /* Solar panels shall provide electrical
         * energy whenever operational illumination
         * conditions allow, in order to support
         * spacecraft operations.
         */
    
        subject sp : SolarPanels;
    }

    requirement <OR02> 'Solar Maximum Power Requirement' {
        doc
        /* Solar panels shall provide maximum
         * power under the environmental conditions
         * present
         */

        subject sp : SolarPanels;
    }

    // =====================================
    // Batteries
    // =====================================

    requirement <OR03> 'Energy Storage Availability Requirement' {
        doc
        /* Batteries shall store electrical
         * energy to sustain operations when
         * power generation is unavailable
         * or insufficient.
         */

        subject bat : Batteries;
    }

    requirement <OR04> 'Energy Storage Safety Requirement' {
        doc
        /* Batteries shall operate within
         * safe conditions during charge,
         * discharge, and storage phases.
         */

        subject bat : Batteries;
    }

    // =====================================
    // Power Distribution Network
    // =====================================

    requirement <OR05> 'Power Distribution Service Requirement' {
        doc
        /* The power distribution network
         * shall deliver electrical power
         * to operational consumers when
         * power is available.
         */

        subject pdn : PowerDistributionNetwork;
    }

    requirement <OR06> 'Load Switching Support Requirement' {
        doc
        /* The power distribution network
         * shall support switching of
         * power delivery to loads
         */

        subject pdn : PowerDistributionNetwork;
    }

    requirement <OR07> 'Interfacing Requirement' {
        doc
        /* The power distribution network
         * shall interface the physical components 
         * needed for sensing and protection
         */

        subject pdn : PowerDistributionNetwork;
    }

    // =====================================
    // Power Converters
    // =====================================

    requirement <OR08> 'Power Conversion Availability Requirement' {
        doc
        /* Power converters shall convert
         * electrical power according to the
         * requirements of consumers.
         */

        subject pc : PowerConverters;
    }

    requirement <OR09> 'Power Conversion Stability Requirement' {
        doc
        /* Power converters shall provide
         * stable power conversion across
         * expected operational conditions.
         */

        subject pc : PowerConverters;
    }

    // =====================================
    // Protections
    // =====================================

    requirement <OR10> 'Fault Detection Capability Requirement' {
        doc
        /* Protection means shall be capable
         * of detecting abnormal electrical
         * conditions during operation.
         */

        subject prot : Protections;
    }

    requirement <OR11> 'Fault Mitigation Capability Requirement' {
        doc
        /* Protection means shall be capable
         * of mitigating detected faults to
         * prevent operational degradation.
         */

        subject prot : Protections;
    }

    // =====================================
    // Autonomous Control
    // =====================================

    requirement <OR12> 'Autonomous Governance Availability Requirement' {
        doc
        /* Autonomous control shall support
        * autonomous governance of power-related
        * operations when supervision is not
        * available or not desired.
        */

        subject ac : AutonomousControl;
    }

    requirement <OR13> 'Autonomous Decision Support Requirement' {
        doc
        /* Autonomous control shall support
        * decision-making related to power
        * generation, storage, distribution,
        * and protection during operations.
        */

        subject ac : AutonomousControl;
    }

    requirement <OR14> 'Operational Telemetry Provision Requirement' {
        doc
        /* Autonomous control shall provide
        * operational telemetry to Space
        * Segment Services to support planning
        * and execution of operations.
        */

        subject ac : AutonomousControl;
    }

    requirement <OR15> 'Sensor Data Telemetry Requirement' {
        doc
        /* Autonomous control shall provide
        * sensor data over operational telemetry
        * to Space Segment Services.
        */

        subject ac : AutonomousControl;
    }

    requirement <OR16> 'Prediction Data Telemetry Requirement' {
        doc
        /* Autonomous control shall provide
        * prediction data over operational
        * telemetry when required to support
        * operational planning.
        */

        subject ac : AutonomousControl;
    }

    requirement <OR17> 'Operational Command Interface Requirement' {
        doc
        /* Autonomous control shall interface
        * operational commands issued by Space
        * Segment Services.
        */

        subject ac : AutonomousControl;
    }

    requirement <OR18> 'Command Actuation Support Requirement' {
        doc
        /* Autonomous control shall actuate
        * control actions based on commands
        * received from Space Segment Services.
        */

        subject ac : AutonomousControl;
    }

    requirement <OR19> 'Operational Data Reception and Consolidation Requirement' {
        doc
        /* Autonomous control shall receive
        * operational sensor, status, and
        * fault data from operational entities
        * and consolidate this information
        * into a coherent operational view.
        */

        subject ac : AutonomousControl;
    }

    requirement <OR21> 'Behavioral Data Update Requirement' {
        doc
        /* Autonomous control shall calculate
        * and update behavioral data based on
        * observed operational behavior.
        */

        subject ac : AutonomousControl;
    }

    requirement <OR22> 'Prediction Generation Requirement' {
        doc
        /* Autonomous control shall calculate
        * operational predictions based on
        * behavioral data.
        */

        subject ac : AutonomousControl;
    }

    requirement <OR23> 'Adaptive Control Support Requirement' {
        doc
        /* Autonomous control shall adapt
        * control decisions based on updated
        * behavioral data and predictions.
        */

        subject ac : AutonomousControl;
    }

}
