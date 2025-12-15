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
    connection def OperationalInteraction {
        in In : OperationalActivity;
        out Out : OperationalActivity;
        in : ExchangeItem;
    }
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
    // *BehavioralExchangeScenario
    // *CommunicationMeans
    
    // Data and inteface model
    // *Class
    // *ExchangeItem
    
    // =====================================
    // System needs analysis (23.3.2)
    // =====================================   

    // Functional concepts

    // *SystemMission
    // *SystemCapability
    action def SystemFunction;
    // *FunctionalPort
    // *FunctionalExchange
    // *FuntionalChain
    // *FunctionScenario

    // *Mode
    // *State
    // *Transition
    // *Configuration
    // *Situation

    // Structural concepts
    // *Actor
    // *System
    // *BehavioralPort 
    // *BehavioralExchange
    // *BehavioralExchangeScenario
    
    // *Actor
    // *System
    // *PhysicalPort
    // *PhysicalLink

    // Data and inteface model
    // *Class
    // *ExchangeItem
    // *Interface

    // =====================================
    // Logical architecture (23.3.3)
    // =====================================   
    
    // Functional concepts
    // *SystemMission
    // *SystemCapability
    action def LogicalFunction;
    // *FunctionalPort
    // *FunctionalExchange
    // *FuntionalChain
    // *FunctionScenario
    
    // *Mode
    // *State
    // *Transition
    // *Configuration
    // *Situation

    // Structural concepts
    // *Actor
    // *System
    // *BehavioralPort 
    // *BehavioralExchange
    item def LogicalComponent;
    // *BehavioralExchangeScenario
    item def FunctionalPath;

    // *Actor
    // *System
    // *PhysicalPort
    // *PhysicalLink

    // =====================================
    // Physical architecture (23.3.4)
    // ===================================== 

    // Functional concepts
    // *SystemMission
    // *SystemCapability
    action def PhysicalFunction;
    // *FunctionalPort
    // *FunctionalExchange
    // *FuntionalChain
    // *FunctionScenario

    // *Mode
    // *State
    // *Transition
    // *Configuration
    // *Situation

    // Structual concepts
    // *Actor
    // *System
    // *BehavioralPort 
    // *BehavioralExchange
    item def BehavioralComponent;
    // *BehavioralExchangeScenario
    // *FunctionalPath

    // *Actor
    // *System
    // *PhysicalPort
    // *PhysicalLink
    item def HostingPhysicalComponent;
    item def PhysicalPath;

    // Data and inteface model
    // *Class
    // *ExchangeItem
    // *Interface

    // =====================================
    // Shared
    // =====================================   

    // Functional concepts
    port def FunctionalPort;
    item def FunctionalExchange;
    action def FuntionalChain;
    action def FunctionScenario;

    item def Mode;
    item def State;
    item def Transition;
    item def Configuration;
    item def Situation;

    // Structural concepts
    use case def SystemMission;
    use case def SystemCapability;
    action def BehavioralExchangeScenario;
    part def Actor;
    part def System;
    port def BehavioralPort;
    item def BehavioralExchange;
    port def PhysicalPort;
    part def PhysicalLink;
    
    // Data and inteface model
    item def Class;
    item def ExchangeItem;
    item def Interface;

}