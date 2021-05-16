if isDedicated exitwith {};

player addEventHandler ["respawn",{
	0 = [] call BWPLM_fnc_Init_HangerPlayerActions; 
}];