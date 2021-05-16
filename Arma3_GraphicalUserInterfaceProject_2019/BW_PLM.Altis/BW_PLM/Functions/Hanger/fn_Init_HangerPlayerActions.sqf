/*
	No Params Adds player actions for the hanger system as play joins game.
*/

if isDedicated exitWith {};

//Default Values
if (isNil "BW_PLY_MenuZonesArray") 	then {BW_PLY_MenuZonesArray = [];};
if (isNil "BW_PLY_DriverOnly") then {BW_PLY_DriverOnly = false;};

[ 
	player,												// Object the action is attached to
	"<t color='#4DB0E2'>Pylon Loadout</t>",									// Title of the action
	"\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa",	// Idle icon shown on screen
	"\A3\ui_f\data\igui\cfg\simpleTasks\letters\L_ca.paa",	// Progress icon shown on screen
	"(isTouchingGround vehicle player) AND (vehicle player != player) AND ({(vehicle player distance (_x select 0)) < (_x select 1)} count BW_PLY_MenuZonesArray > 0) AND (if BW_PLY_DriverOnly then {driver vehicle player == player} else {true})", // Condition for the action to be shown
	//"true",
	"(isTouchingGround vehicle player) AND (vehicle player != player) AND ({(vehicle player distance (_x select 0)) < (_x select 1)} count BW_PLY_MenuZonesArray > 0)",	// Condition for the action to progress
	{}, 												// Code executed when action starts
	{},													// Code executed on every progress tick
	{createDialog "BWPLM_LoadoutMenu";},				// Code executed on completion
	{},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	1,													// Action duration [s]
	1,													// Priority
	false,												// Remove on completion
	false												// Show in unconscious state 
] call BIS_fnc_holdActionAdd; 

[ 
	player,												// Object the action is attached to
	"<t color='#4DB0E2'>Deploy Vehicle</t>",									// Title of the action
	"\A3\ui_f\data\igui\cfg\simpleTasks\letters\D_ca.paa",	// Idle icon shown on screen
	"\A3\ui_f\data\igui\cfg\simpleTasks\letters\D_ca.paa",	// Progress icon shown on screen
	"(count (cursorTarget getVariable [""BWPLM_HangerStorageArray"",[]]) > 0) AND (cursorTarget getVariable [""BWPLM_Stored"",true])",						// Condition for the action to be shown
	"(count (cursorTarget getVariable [""BWPLM_HangerStorageArray"",[]]) > 0) AND (cursorTarget getVariable [""BWPLM_Stored"",true]) AND (alive cursorTarget) AND (alive player)",// Condition for the action to progress
	{}, 												// Code executed when action starts
	{},													// Code executed on every progress tick
	{ 
	
		// "BWPLM_HangerStorageArray" = [_deployToPos,_deployAngle,_deployCode,_hangerPos,_hangerAngle,_hangerCode]
		private ["_veh","_variables","_width","_length","_height"];

		_veh = cursorTarget;
		_variables = (_veh getVariable ["BWPLM_HangerStorageArray",true]);

		(boundingBoxReal _veh) params ["_arg1","_arg2"];
		_width = abs ((_arg2 select 0) - (_arg1 select 0)); 
		_length = abs ((_arg2 select 1) - (_arg1 select 1)); 
		_height = abs ((_arg2 select 2) - (_arg1 select 2)); 

		_vehiclesArray = vehicles inAreaArray [ 
			(_variables select 0),  
			_width +1,  
			_length + 1,  
			(_variables select 1),  
			false,  
			(((_variables select 0) select 2) + _height + 1)
		];

		if ({_x isKindOf "Tank" OR _x isKindOf "CAR" OR _x isKindOf "AIR"} count _vehiclesArray < 1) then {

			_veh setPosATL (_variables select 0);
			_veh setDir (_variables select 1);
			
			_veh setVariable ["BWPLM_Stored",false,true];
			_veh setVehicleLock "UNLOCKED";
			
			_veh call (_variables select 2);
			
		} else {

			titleText ["<t color='#4DB0E2' size='1.5'><br/><br/><br/><br/><br/><br/><br/><br/><br/>Can't Move, Target Area Blocked</t>", "PLAIN", 3, true, true];
			playSound "addItemFailed";

		};

		
	},													// Code executed on completion
	{},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	1,													// Action duration [s]
	0,													// Priority
	false,												// Remove on completion
	false												// Show in unconscious state 
] call BIS_fnc_holdActionAdd; 

[ 
	player,												// Object the action is attached to
	"<t color='#4DB0E2'>Store Vehicle</t>",											// Title of the action
	"\A3\ui_f\data\igui\cfg\simpleTasks\letters\S_ca.paa",	// Idle icon shown on screen
	"\A3\ui_f\data\igui\cfg\simpleTasks\letters\S_ca.paa",	// Progress icon shown on screen
	"(count (cursorTarget getVariable [""BWPLM_HangerStorageArray"",[]]) > 0) AND !(cursorTarget getVariable [""BWPLM_Stored"",true]) AND (cursorTarget distance ((cursorTarget getVariable [""BWPLM_HangerStorageArray"",[0,1,2,[0,0,0]]]) select 3) < 100)",	// Condition for the action to be shown
	"(count (cursorTarget getVariable [""BWPLM_HangerStorageArray"",[]]) > 0) AND !(cursorTarget getVariable [""BWPLM_Stored"",true]) AND (alive cursorTarget) AND (alive player) AND isTouchingGround cursorTarget", // Condition for the action to progress
	{}, 												// Code executed when action starts
	{},													// Code executed on every progress tick
	{ 

		// "BWPLM_HangerStorageArray" = [_deployToPos,_deployAngle,_deployCode,_hangerPos,_hangerAngle,_hangerCode,adjustTestSize]
		private ["_veh","_variables","_width","_length","_height"];

		_veh = cursorTarget;
		_variables = (_veh getVariable ["BWPLM_HangerStorageArray",true]);

(boundingBoxReal _veh) params ["_arg1","_arg2"];
_width = abs ((_arg2 select 0) - (_arg1 select 0)); 
_length = abs ((_arg2 select 1) - (_arg1 select 1)); 
_height = abs ((_arg2 select 2) - (_arg1 select 2)); 

_vehiclesArray = vehicles inAreaArray [ 
	(_variables select 3),  
	_width + ((_variables select 6) select 0),  
	_length + ((_variables select 6) select 1),  
	(_variables select 4),  
	false,  
	(((_variables select 3) select 2) + _height + ((_variables select 6) select 2))
];
		
		hint str _vehiclesArray; 
		
		if ({_x isKindOf "Tank" OR _x isKindOf "CAR" OR _x isKindOf "AIR"} count _vehiclesArray < 1) then {

			_veh setDir (_variables select 4);
			_veh setPosATL (_variables select 3);
			
			_veh setVariable ["BWPLM_Stored",true,true];
			_veh setVehicleLock "UNLOCKED";
			
			_veh call (_variables select 5);
			
		} else {

			titleText ["<t color='#4DB0E2' size='1.5'><br/><br/><br/><br/><br/><br/><br/><br/><br/>Can't Move, Target Area Blocked</t>", "PLAIN", 3, true, true];
			playSound "addItemFailed";

		};

		
	},		// Code executed on completion
	{},													// Code executed on interrupted
	[],													// Arguments passed to the scripts as _this select 3
	1,													// Action duration [s]
	0,													// Priority
	false,												// Remove on completion
	false												// Show in unconscious state 
] call BIS_fnc_holdActionAdd; 