package Arcadia {
    // =====================================
    // Imports
    // =====================================

    public import SI::*;
    public import ScalarValues::*;

    // =====================================
    // Operational Analysis Concepts (23.3.1)
    // =====================================   

    // Functional concepts 
    use case def OperationalMission;
    use case def OperationalCapability;

    action def OperationalActivity;
    action def OperationalInteraction;
    action def OperationalProcess;
    action def OperationalScenario;

    item def OperationalMode;
    item def OperationalState;
    item def OperationalTransition;
    item def OperationalConfiguration;
    item def OperationalSituation;

    // Structural concepts
    part def OperationalEntity {
        attribute isHuman : Boolean;
    }
    part def OperationalActor :> OperationalEntity;
     // BehavioralExchangeScenario
     // CommunicationMeans
    
    // Data and inteface model
     // Class
     // ExchangeItem
    
    // =====================================
    // System needs analysis (23.3.2)
    // =====================================   

    // Functional concepts

     // SystemMission
     // SystemCapability
    action def SystemFunction;
     // FunctionalPort
     // FunctionalExchange
     // FuntionalChain
     // FunctionalScenario


    item def SystemMode;
    item def SystemState;
    item def SystemTransition;
    item def SystemConfiguration;
    item def SystemSituation;

    // Structural concepts
     // Actor
     // System
    port def BehavioralPort;
    item def BehavioralExchange;
     // BehavioralExchangeScenario
    
     // Actor
     // System
    port def PhysicalPort;
    part def PhysicalLink;

    // Data and inteface model
     // Class
     // ExchangeItem
     // Interface

    // =====================================
    // Logical architecture (23.3.3)
    // =====================================   
    
    // Functional concepts
     // SystemMission
     // SystemCapability
    action def LogicalFunction;
     // FunctionalPort
     // FunctionalExchange
     // FuntionalChain
     // FunctionalScenario

    // =====================================
    // Shared
    // =====================================   

    // Functional concepts
    port def FunctionalPort;
    item def FunctionalExchange;
    action def FuntionalChain;
    action def FunctionalScenario;
    
    // Structural concepts
    use case def SystemMission;
    use case def SystemCapability;
    action def BehavioralExchangeScenario;
    part def Actor;
    part def System;
    
    // Data and inteface model
    item def OperationalClass;
    item def ExcangeItem;

    



}