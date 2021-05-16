_display = _this select 0; 
BWPLM_LoadoutMenu_Vehicle = cursorTarget; 

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

_subclasses = [configfile >> "CfgVehicles" >> (typeOf BWPLM_LoadoutMenu_Vehicle) >> "Components" >> "TransportPylonsComponent" >> "Pylons" ] call Bis_fnc_getCfgSubClasses;
_count = 1;
_vehicleName = (getText (configfile >> "CfgVehicles" >> (typeOf BWPLM_LoadoutMenu_Vehicle) >> "displayName"));
{
	_index = lbAdd [1500, (format ["%1 Pylon %2",_vehicleName,_count])];
	_count = _count + 1; 
	lbSetData [1500, _index, _x];
	lbSetPicture [1500, _index, "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa"];	
} forEach _subclasses;

lbSetCurSel [1500,0];

/*
if (isNil "BWPLM_LoadoutMenu_NGV_ON") then {BWPLM_LoadoutMenu_NGV_ON = false};
if 

if BWPLM_LoadoutMenu_NGV_ON then {
	camUseNVG false; 
	BWPLM_LoadoutMenu_NGV_ON = false;
} else {
	camUseNVG true; 
	BWPLM_LoadoutMenu_NGV_ON = true;
};