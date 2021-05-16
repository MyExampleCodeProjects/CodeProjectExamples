/*
	BWPLM_fnc_Menu_PylonChanged
*/

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