/*
	BWPLM_Fnc_StoreInHanger
	
	Author: Big_Wilk
	
	Params:
	0: object; helicopter plane to be affect this should be placed in it's hanger in the editor.

	
	Example 1: 
	
	0 = [
			_plane,
			[14198.6,6390.31,41.8406], 
			0,
			{},
			[14194.937,6423.126,44.494],
			0,
			{}
		] call BWPLM_Fnc_StoreInHanger; 
		
*/

if !isServer exitWith {};

private ["_aircraft","_deployToPos","_hangerPos"];

_aircraft = param [0, objNull];

_deployToPos = param [1, [0,0,0]];
_deployAngle = param [2, 0];
_deployCode = param [3, {}];

_hangerPos = param [4, [0,0,0]];
_hangerAngle = param [5, 0];
_hangerCode = param [6, {}];

_startStored = param [7, true];

_adjustDimensionTest = param [8, [0,0,0]];

// Setvariables 
_aircraft setVariable ["BWPLM_HangerStorageArray",[_deployToPos,_deployAngle,_deployCode,_hangerPos,_hangerAngle,_hangerCode,_adjustDimensionTest],true];
_aircraft setVariable ["BWPLM_Stored",_startStored,true];