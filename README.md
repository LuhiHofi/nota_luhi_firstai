# nota_luhi_firstai
Repository for the course nail133 Human-like Artificial Agents on MFF UK  

### Missions:
- sandsail2 solution with the Bonus
- ctp2 with the Bonus
- ttdr with the Bonus
- swampdota exam solution

### Commands:
- *loadUnit* - loads an unit into a transporter
- *loadUnits* - loads units into a transporter
- *unloadUnit* - unloads an unit from a transporter
- *unloadUnits* - unloads units from a transporter on a given area
- *TakeOverHills* - Captures all (hill) positions with a single unit (if enough units are left, otherwise captures as many most important hills (importance measured by ctp2 assignment)) 
- *ForbidLanding* - forbids idle air units to land
- *ForbidLandingParam* - forbids selected air units to land
- *buyUpgrade* - buys a line upgrade
- *buyUnit* - buys an unit
- *carefulAttack* - attack an enemy from the furthest distance possible
- *moveUnit* - moves an unit to a position
- *moveOnPath* - moves an unit along a path


### Sensors:
- *sandsail2* - contains getGroupDef and getWindLine functions
    - getGroupDef returns a definition for the WindLine formation with a leader being the pointman
    - getWindLine returns a line formation in a given angle with a given spacing
- *sandsailDebug* - draws a line in the direction of the wind along with a perpendicular line to signify where the formation should be
- *Wind* - returns the angle and the strength of the wind
- *positionOfFirstUnit* - returns the position of the first unit
- *Maverick* - returns the position and the ID of Maverick
- *IsCommandInQueue* - checks whether a command is in queue of commands of a unit  
- *isAlive* - returns true if unitID is alive and visible, otherwise returns false
- *getEnemyID* - returns the ID of an enemy unit on a selected position
- *ExcludeUnit* - returns a list of units without an excluded one
- *DoubleLineFormation* - returns a Double line formation
- *BEAR* - returns the ID of a BEAR unit from the selected units
- *IsCommandInQueue* - checks whether there is a command in queue
- *GetRescuableUnits* - returns units that are rescuable
- *GetAlive* - returns a filtered list of selected units
- *GetUnitRange* - returns a range of an unit
- *GetClosestEnemy* - returns the closest enemy
- *GetEnemyUnits* - returns a list of visible enemy units
- *UpdateUnitInfo* - updates info of owned units
- *SetupTransport* - setups a swampdota transport
- *TransportFinished* - updates info after a finished transport
- *showPointDebug* - highlights a point on the map

### Behaviours
- *sandsail2* - working sandsail2 hw with the bonus
- *ctp2* - working ctp2 hw with the bonus
- *get_to_enemy* - moves the units in a DoubleLineFormation towards a selected position, presumably where the enemy is, ready to fight
- *fight_enemy* - fights an enemy unit situated on a position, returns SUCCESS if the enemy unit is destroyed
- *ttdr* - working ttdr solution with the bonus
- *PeepersMapScan* - peepers scanning the map
- *scanAndRescue* - scan the map and then use atlases to rescue units
- *moveBehindEnemyBase* - moves behind the enemy lines to the enemy base
- *shopping* - buys units
- *swampdota* - working solution for swampdota
- *swampdotaSetup* - setup for swampdota mission
- *transportUnit* - transports an unit using a safe path to a destination 