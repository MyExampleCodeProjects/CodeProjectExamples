/*
	Manages Data saved to users profiles DO NOT USE OR EDIT THIS SCRIPT.
	but if you do fuck around with it and break your Pylon Load Out menu run the bellow line to refresh:
	profileNamespace setVariable ["BWPLM_PylonPresets",[],false];
*/

_caseType = param [0, ""];

switch _caseType do {
    case "Save": {
	
		_currentPresets = profileNamespace getVariable ["BWPLM_PylonPresets",[]];
		_currentPresets pushBack [(ctrlText 900),(typeOf BWPLM_LoadoutMenu_Vehicle),(getPylonMagazines vehicle player)];
		
		profileNamespace setVariable ["BWPLM_PylonPresets",_currentPresets];
		
		ctrlSetText [900, ""];
		
		0 = [] call BWPLM_fnc_Menu_Presets;
		
	};
    case "Load": {

		_index = lbCurSel 901;
		
		_currentPresets = profileNamespace getVariable ["BWPLM_PylonPresets",[]];
		_currentMenuPresets = [];
		{
			if ((_x select 1) == (typeOf BWPLM_LoadoutMenu_Vehicle)) then {_currentMenuPresets pushBack _x;};
		} forEach (profileNamespace getVariable ["BWPLM_PylonPresets",[]]);
		
		_presetSelected = (_currentMenuPresets select _index);
		
		_presetName = _presetSelected select 0;
		_presetClassNameIntendedFor = _presetSelected select 1;
		_presetWepaons = _presetSelected select 2;
		

		
		_pylonClassnames = ([configfile >> "CfgVehicles" >> (typeOf BWPLM_LoadoutMenu_Vehicle) >> "Components" >> "TransportPylonsComponent" >> "Pylons" ] call Bis_fnc_getCfgSubClasses);
		
		//copyToClipboard format ["%1 %2", _presetWepaons, _pylonClassnames];

		for "_i" from 0 to (count _presetWepaons) do {
			[
				BWPLM_LoadoutMenu_Vehicle,
				[
					(_i + 1), 
					(_presetWepaons select _i)
				]
			] remoteExec ['setPylonLoadout', BWPLM_LoadoutMenu_Vehicle, false];
		};
		
		0 = [] call BWPLM_fnc_Menu_PylonChanged;
		
	};
    case "Del": {
	
		_index = lbCurSel 901;
		
		_currentPresets = profileNamespace getVariable ["BWPLM_PylonPresets",[]];
		_currentMenuPresets = [];
		{
			if ((_x select 1) == (typeOf BWPLM_LoadoutMenu_Vehicle)) then {_currentMenuPresets pushBack _x;};
		} forEach (profileNamespace getVariable ["BWPLM_PylonPresets",[]]);
		
		_currentPresets = _currentPresets - [(_currentMenuPresets select _index)];
		
		profileNamespace setVariable ["BWPLM_PylonPresets",_currentPresets];
		
		0 = [] spawn BWPLM_fnc_Menu_Presets;	
		
	};
    default {
		
		lbClear 901;
		
		{
			if ((_x select 1) == (typeOf BWPLM_LoadoutMenu_Vehicle)) then {
				_index = lbAdd [901, (_x select 0)];
				lbSetData [901, _index, (_x select 0)];
				lbSetPicture [901, _index, "\A3\ui_f\data\igui\cfg\simpleTasks\types\rearm_ca.paa"];	
			};
		} forEach (profileNamespace getVariable ["BWPLM_PylonPresets",[]]);
		
		lbSetCurSel [901,0];

		if (lbCurSel 901 < 0) then {

			_editorPresets = ((configfile >> "CfgVehicles" >> (typeOf BWPLM_LoadoutMenu_Vehicle) >> "Components" >> "TransportPylonsComponent" >> "Presets") call BIS_fnc_getCfgSubClasses);
			{
				_classname = (typeOf BWPLM_LoadoutMenu_Vehicle); 
				
				_name = (gettext (configfile >> "CfgVehicles" >> _classname >> "Components" >> "TransportPylonsComponent" >> "Presets" >> _x >> "displayName"));
				_loadout = (getArray (configfile >> "CfgVehicles" >> _classname >> "Components" >> "TransportPylonsComponent" >> "Presets" >> _x >> "attachment"));
				
				if !(_name in ["Empty","Default"]) then {
					_currentPresets = profileNamespace getVariable ["BWPLM_PylonPresets",[]];
					_currentPresets pushBack [_name,_classname,_loadout];
					
					profileNamespace setVariable ["BWPLM_PylonPresets",_currentPresets];
				};
				
			} forEach _editorPresets;
			
			if (count _editorPresets > 0) then {
				0 = [] call BWPLM_fnc_Menu_Presets;
			};
			
		};

	};
};

true;

/*
lbClear 2100; 
_ammo = BWPLM_LoadoutMenu_Vehicle getCompatiblePylonMagazines (lbCurSel 1500); 
//hint str _ammo; 

_currentMagazine = (getPylonMagazines BWPLM_LoadoutMenu_Vehicle) select (lbCurSel 1500);
{	
	_index = lbAdd [2100, (gettext (configfile >> "CfgMagazines" >> _x >> "displayName"))]; 
	lbSetData [2100, _index, _x];
	lbSetPicture [2100, _index, "\A3\ui_f\data\igui\cfg\simpleTasks\types\target_ca.paa"];	
	if (_x == _currentMagazine) then {lbSetCurSel [2100,_index];};
} forEach ([''] + (BWPLM_LoadoutMenu_Vehicle getCompatiblePylonMagazines (lbCurSel 1500 + 1))); 

if (lbCurSel 2100 < 0) then {
	lbSetCurSel [2100,0];
};