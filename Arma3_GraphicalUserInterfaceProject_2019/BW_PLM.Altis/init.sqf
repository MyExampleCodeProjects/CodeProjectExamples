/*
	BWPLM Features:
	* Change the weapon attached to each of your heliocpter/aircrafts weapon pylons.
	* Automatic repair/refuel/rearm of heliocpter/aircrafts while the menu is open.
	
	BWPLM Variables:
	* The variables/explanaitons cotained within this file will help you coustomize the Plyon Loadout Menu for your senario.
	* Experianced Users Note: These variables can be local to each client (such as in this init.sqf example), or global and controled by the server, but should never be server only. 
*/

/*
	BW_PLY_MenuZonesArray
	
	* The BW_PLY_MenuZonesArray Array is for creating Rearm/Repair Points: [Object, Max Distance From Object]
	* A player in a jet or helicopter that is touching the ground and within the max defined distance of the object can open the Plyon Loadout Menu.
*/
BW_PLY_MenuZonesArray = [
	[Repair1,20], // Repair1 is Red Arrow at the main Airport 
	[Repair2,20], // Repair2 is the invisable helipad at the main Airport 
	[USSFreedom,200] // USSFreedom is the Aircraft Carrier
];

/*
	The following variables control how long it takes for the aircraft/helicopters to repair and fuel.
	
	* Longer intervals and smaller increments will incrase the time it takes to repair and fuel and vice versa.
	* Increments is a value tha determines how much health/fuel is given on each interval.
	* Intervals is the time in seconds between each increment. 
	* Intervals and increments values are editable so the health/fuel bar increases smoothly.  
	* All the Increments/Intervals variables are optional you can delete them and defaults values will be used. 
	* NOTE: In Arma full/min health/fuel is value between 0 and 1.
*/
BW_PLY_RepairInterval = 0.025; // Time inbetween repair increments when menu is open. (Optional; you can delete this varaible and it's default will take over 0.025)
BW_PLY_RepairIncrement = 0.001; // Amount of damage removed from vehilce each interval (Optional; you can delete this varaible and it's default default incriment is 0.0025)

BW_PLY_Refuelnterval = 0.1; // Time inbetween refueling increments when menu is open. (Optional; you can delete this varaible and it's default will take over 0.025)
BW_PLY_RefuelIncrement = 0.01; // Amount of fuel added from vehilce each interval (Optional; you can delete this varaible and it's default default incriment is 0.01)

/*
	BW_PLY_isDriver

	* If false everyone in a plane/helicopter can acsess the menu (driver, gunner, commander, passanger)
	* If true only the player in the driver (pilot) seat can acsess the menu. 
	* BW_PLY_isDriver is optional you can delete this variable and a default of FALSE will be used. 
*/
BW_PLY_DriverOnly = false; 

/*
	View Distance (not needed)
*/
setViewDistance 6000;