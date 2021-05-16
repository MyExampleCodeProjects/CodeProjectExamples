/*
	BWPLM_fnc_Menu_Opened
*/

// Check Repair/Refuel variables exist 
if (isNil "BW_PLY_RepairInterval") 	then {BW_PLY_RepairInterval = 0.025;};
if (isNil "BW_PLY_RepairIncrement") then {BW_PLY_RepairIncrement = 0.001;};

if (isNil "BW_PLY_Refuelnterval")  	then {BW_PLY_Refuelnterval = 0.1;};
if (isNil "BW_PLY_RefuelIncrement") then {BW_PLY_RefuelIncrement = 0.01;};

// Open Dialog
_display = _this select 0; 
BWPLM_LoadoutMenu_Vehicle = vehicle player; 

// Engine off to stop the weird foward creep of vehicles when dialogs are open. 
if (driver BWPLM_LoadoutMenu_Vehicle == player) then {
	player action ["engineOff", BWPLM_LoadoutMenu_Vehicle];
};

// vehicle dimensions 
(boundingBoxReal BWPLM_LoadoutMenu_Vehicle) params ["_arg1","_arg2"]; 
_width = abs ((_arg2 select 0) - (_arg1 select 0));
BWPLM_LoadoutMenuZoom = _width;
  
/*_length = abs ((_arg2 select 1) - (_arg1 select 1));  
_height = abs ((_arg2 select 2) - (_arg1 select 2));*/ 

BWPLM_LoadoutMenuZoom = _width;

// Create Camera
BWPLM_LoadoutMenu_Camera = "camera" camcreate [0,0,0]; 
BWPLM_LoadoutMenu_Camera cameraeffect ["internal", "back"]; 
BWPLM_LoadoutMenu_Camera attachTo [BWPLM_LoadoutMenu_Vehicle, [0, BWPLM_LoadoutMenuZoom, -1.8]]; 
BWPLM_LoadoutMenu_Camera camPrepareFOV 0.51; 
BWPLM_LoadoutMenu_Camera camSetTarget BWPLM_LoadoutMenu_Vehicle;
BWPLM_LoadoutMenu_Camera camCommit 0; 
showCinemaBorder true;

if (currentVisionMode player == 0) then {
	BWPLM_LoadoutMenu_NGV_ON = false;
	camUseNVG false;
} else {
	BWPLM_LoadoutMenu_NGV_ON = true;
	camUseNVG true;
};

_subclasses = [configfile >> "CfgVehicles" >> (typeOf BWPLM_LoadoutMenu_Vehicle) >> "Components" >> "TransportPylonsComponent" >> "Pylons" ] call Bis_fnc_getCfgSubClasses;
_count = 1;
_vehicleName = (getText (configfile >> "CfgVehicles" >> (typeOf BWPLM_LoadoutMenu_Vehicle) >> "displayName"));

{
	private ["_index"];
	
	_countText = (if (_count < 10) then {("0" + str _count)} else {str _count});
	
	if ( (count (BWPLM_LoadoutMenu_Vehicle getCompatiblePylonMagazines _count)) > 0 ) then {
		_index = lbAdd [1500, (format ["Pylon %2 - Select To Customize",_vehicleName,_countText])];
	} else {
		_index = lbAdd [1500, (format ["Pylon %2 - Removed From Airframe",_vehicleName,_countText])];
		lbSetColor [1500, _index, [1, 0, 0, 1]];
	};
	
	_count = _count + 1; 
	lbSetData [1500, _index, _x];
	lbSetPicture [1500, _index, "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa"];	
} forEach _subclasses;

if (count _subclasses > 0) then {
	lbSetCurSel [1500,0];
} else {
	_index = lbAdd [1500, "This Vehicle Has No Pylons"];
	lbSetData [1500, _index, "This Vehicle Has No Pylons"];
	lbSetPicture [1500, _index, "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa"];	
	
	{
		ctrlEnable [_x, false];
	} forEach [1607,1606,1608,901,900,1500,2100];
};

ctrlSetText [3000, (getText (configfile >> "CfgVehicles" >> (typeOf BWPLM_LoadoutMenu_Vehicle) >> "displayName"))];

0 = [] call BWPLM_fnc_Menu_Presets;

/*
	Service Vehicle. 
*/

BWPLM_LoadoutMenu_Vehicle setVehicleAmmo 1;

_health = getDammage BWPLM_LoadoutMenu_Vehicle;
_healthBar = (_display displayCtrl 503);
_healthBar ctrlCommit 0;
_healthBar progressSetPosition (1 - _health); 

_1p = 100/1;
_healthPercent = if (((1 - _health) * _1p) > 100) then {100} else {round ((1 - _health) * _1p)};
_text = (format ["Repairs Progress: %1",_healthPercent]); 
_textFinal = _text + "%";
ctrlSetText [501, _textFinal];

_fuel = (fuel BWPLM_LoadoutMenu_Vehicle);
_fuelBar = (_display displayCtrl 502);
_fuelBar ctrlCommit 0;
_fuelBar progressSetPosition _fuel; 

_1p = 100/1;
_fuelPercent = if (_fuel*_1p > 100) then {100} else {round (_fuel*_1p)};
_text = (format ["Refuel Progress: %1",_fuelPercent]); 
_textFinal = _text + "%";
ctrlSetText [500, _textFinal];
	
_repairPictureBlink = _display displayCtrl 101;
while {((getDammage BWPLM_LoadoutMenu_Vehicle) > 0) AND dialog} do {

	if ((ctrlAngle _repairPictureBlink select 0) == 0) then {
		_repairPictureBlink ctrlSetAngle [360, 0.5, 0.5, false];
		_repairPictureBlink ctrlCommit 7;
	} else {
		if ((ctrlAngle _repairPictureBlink select 0) == 360) then {
			_repairPictureBlink ctrlSetAngle [0, 0.5, 0.5, false];
			_repairPictureBlink ctrlCommit 0;
		};	
	};
		
	if (ctrlFade _repairPictureBlink == 0) then {
		_repairPictureBlink ctrlSetFade 1;
		_repairPictureBlink ctrlCommit 1.2;	
	} else {
		if (ctrlFade _repairPictureBlink > 0.75) then {
			_repairPictureBlink ctrlSetFade 0;
			_repairPictureBlink ctrlCommit 1.2;	
		};
	};	
	
	_health = (getDammage BWPLM_LoadoutMenu_Vehicle) - BW_PLY_RepairIncrement;
	
	_1p = 100/1;
	_healthPercent = if (((1 - _health) * _1p) > 100) then {100} else {round ((1 - _health) * _1p)};

	_text = (format ["Repairs Progress: %1",_healthPercent]); 
	_textFinal = _text + "%";
	
	ctrlSetText [501, _textFinal];

	BWPLM_LoadoutMenu_Vehicle setDamage _health;
	_healthBar progressSetPosition (1 - _health); 
	
	sleep BW_PLY_RepairInterval;
		
}; 
_repairPictureBlink ctrlSetAngle [0, 0.5, 0.5, false];
_repairPictureBlink ctrlSetFade 1;
_repairPictureBlink ctrlCommit 0;	

//player sideChat "damage repaired";

sleep 0.1;
//if ((fuel BWPLM_LoadoutMenu_Vehicle) > 0.99) then {BWPLM_LoadoutMenu_Vehicle setFuel 1;}; // stop refuel icon been triggered for small top ups. 

_refuelPictureBlink = _display displayCtrl 100;
while {((fuel BWPLM_LoadoutMenu_Vehicle) < 1) AND dialog} do {

	if ((ctrlAngle _refuelPictureBlink select 0) == 0) then {
		_refuelPictureBlink ctrlSetAngle [360, 0.5, 0.5, false];
		_refuelPictureBlink ctrlCommit 7;
	} else {
		if ((ctrlAngle _refuelPictureBlink select 0) == 360) then {
			_repairPictureBlink ctrlSetAngle [0, 0.5, 0.5, false];
			_refuelPictureBlink ctrlCommit 0;
		};	
	};
		
	if (ctrlFade _refuelPictureBlink == 0) then {
		_refuelPictureBlink ctrlSetFade 1;
		_refuelPictureBlink ctrlCommit 1.2;	
	} else {
		if (ctrlFade _refuelPictureBlink > 0.75) then {
			_refuelPictureBlink ctrlSetFade 0;
			_refuelPictureBlink ctrlCommit 1.2;	
		};
	};
	
	_fuel = (fuel BWPLM_LoadoutMenu_Vehicle) + BW_PLY_RefuelIncrement;
	
	_1p = 100/1;
	_fuelPercent = if (_fuel*_1p > 100) then {100} else {round (_fuel*_1p)};
	
	_text = (format ["Refuel Progress: %1",_fuelPercent]); 
	_textFinal = _text + "%";
	
	ctrlSetText [500, _textFinal];

	BWPLM_LoadoutMenu_Vehicle setFuel _fuel;
	_fuelBar progressSetPosition _fuel; 
	
	sleep BW_PLY_Refuelnterval;
	
}; 
_refuelPictureBlink ctrlSetAngle [0, 0.5, 0.5, false];
_refuelPictureBlink ctrlSetFade 1;
_refuelPictureBlink ctrlCommit 0;

//player sideChat "fueled";