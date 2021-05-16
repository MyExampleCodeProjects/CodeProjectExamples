class BWPLM_LoadoutMenu {
	
	idd = 9901; 
	onLoad = "BWPLM_LoadoutMenu_Vehicle = vehicle player; 0 = _this spawn BWPLM_fnc_Menu_Opened;";
	onUnload = "BWPLM_LoadoutMenu_Camera cameraEffect [""terminate"",""back""]; camDestroy BWPLM_LoadoutMenu_Camera;";
		

	class Objects
	{
	
	}; 
	

	class controls {

		class BWPLM_Picture_1200: BWPLM_Picture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = -0.000156274 * safezoneW + safezoneX;
			y = -0.028 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 1.023 * safezoneH;
			colorText[] = {0,0,0,0.5};
		};
		
		class BWPLM_Listbox_1500: BWPLM_Listbox
		{
			idc = 1500;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.363 * safezoneH;
			onLBSelChanged = "0 = _this call BWPLM_fnc_Menu_PylonChanged;";
		};
		class BWPLM_Combo_2100: BWPLM_Combo
		{
			idc = 2100;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.687 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.022 * safezoneH;
			//onLBSelChanged = "BWPLM_LoadoutMenu_Vehicle setPylonLoadout [(lbData [1500, (lbCurSel 1500)]), (lbData [2100, (lbCurSel 2100)])];";
			onLBSelChanged = "[BWPLM_LoadoutMenu_Vehicle,[(lbData [1500, (lbCurSel 1500)]), (lbData [2100, (lbCurSel 2100)])]] remoteExec ['setPylonLoadout', BWPLM_LoadoutMenu_Vehicle, false];";
		};
		class BWPLM_Button_1600: BWPLM_Button
		{
			idc = 1600;
			onButtonClick = "if (isNil ""BWPLM_LoadoutMenu_NGV_ON"") then {BWPLM_LoadoutMenu_NGV_ON = false}; if BWPLM_LoadoutMenu_NGV_ON then {camUseNVG false; BWPLM_LoadoutMenu_NGV_ON = false;} else {camUseNVG true; BWPLM_LoadoutMenu_NGV_ON = true;};";

			text = "Night Vision"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.94 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class BWPLM_Button_1601: BWPLM_Button
		{
			idc = 1601;
			onButtonClick = "if (isNil ""BWPLM_LoadoutMenu_FOV"") then {BWPLM_LoadoutMenu_FOV = 0.51;}; BWPLM_LoadoutMenu_FOV = BWPLM_LoadoutMenu_FOV + 0.05; BWPLM_LoadoutMenu_Camera camPrepareFOV BWPLM_LoadoutMenu_FOV; BWPLM_LoadoutMenu_Camera camCommit 0;";

			text = "Increase FOV"; //--- ToDo: Localize;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.94 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class BWPLM_Button_1602: BWPLM_Button
		{
			idc = 1602;
			onButtonClick = "if (isNil ""BWPLM_LoadoutMenu_FOV"") then {BWPLM_LoadoutMenu_FOV = 0.51;}; BWPLM_LoadoutMenu_FOV = BWPLM_LoadoutMenu_FOV - 0.05; BWPLM_LoadoutMenu_Camera camPrepareFOV BWPLM_LoadoutMenu_FOV; BWPLM_LoadoutMenu_Camera camCommit 0;";

			text = "Decrease FOV"; //--- ToDo: Localize;
			x = 0.54125 * safezoneW + safezoneX;
			y = 0.94 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class ResetCam: BWPLM_Button
		{
			idc = 1600;
			onButtonClick = "(boundingBoxReal BWPLM_LoadoutMenu_Vehicle) params [""_arg1"",""_arg2""]; _width = abs ((_arg2 select 0) - (_arg1 select 0)); BWPLM_LoadoutMenuZoom = _width; BWPLM_LoadoutMenu_Camera attachTo [BWPLM_LoadoutMenu_Vehicle, [0, BWPLM_LoadoutMenuZoom, -1.8]]; BWPLM_LoadoutMenu_FOV = 0.51; BWPLM_LoadoutMenu_Camera camPrepareFOV BWPLM_LoadoutMenu_FOV; BWPLM_LoadoutMenu_Camera camCommit 0;";

			text = "Reset"; //--- ToDo: Localize;
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.885 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class ZoomIn: BWPLM_Button
		{
			idc = 1601;
			onButtonClick = "if (isNil 'BWPLM_LoadoutMenuZoom') then {BWPLM_LoadoutMenuZoom = 9;}; BWPLM_LoadoutMenuZoom = BWPLM_LoadoutMenuZoom - 0.1; BWPLM_LoadoutMenu_Camera attachTo [BWPLM_LoadoutMenu_Vehicle, [0, BWPLM_LoadoutMenuZoom, -1.8]]";

			text = "Zoom In"; //--- ToDo: Localize;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.885 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class ZoomOut: BWPLM_Button
		{
			idc = 1602;
			onButtonClick = "if (isNil 'BWPLM_LoadoutMenuZoom') then {BWPLM_LoadoutMenuZoom = 9;}; BWPLM_LoadoutMenuZoom = BWPLM_LoadoutMenuZoom + 0.1; BWPLM_LoadoutMenu_Camera attachTo [BWPLM_LoadoutMenu_Vehicle, [0, BWPLM_LoadoutMenuZoom, -1.8]]";

			text = "Zoom Out"; //--- ToDo: Localize;
			x = 0.54125 * safezoneW + safezoneX;
			y = 0.885 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.044 * safezoneH;
		};

		class Tittle: BWPLM_Text
		{
			idc = 1000;
			text = "Big_Wilk's Pylon Load Out Menu"; //--- ToDo: Localize;
			x = 0.0153125 * safezoneW + safezoneX;
			y = 0.027 * safezoneH + safezoneY;
			w = 0.974531 * safezoneW;
			h = 0.066 * safezoneH;
			sizeEx = 0.05 * safezoneH;
		};
		
		/*
			Preset Loadouts. 
		*/
		class PreSetName: BWPLM_Edit
		{
			idc = 900;
			text = "Your new preset name here here...";
			onMouseButtonClick = "if ((ctrlText 900) == ""Your new preset name here here..."") then {ctrlSetText [900, """"];};";
						
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.72 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class PresetsSaved: BWPLM_Combo
		{
			idc = 901;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.753 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class SaveButton: BWPLM_Button
		{
			idc = 1608;
			text = "Save"; //--- ToDo: Localize;
			onMouseButtonClick = "0 = [""Save""] call BWPLM_fnc_Menu_Presets;";
			
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class BWPLM_Button_1606: BWPLM_Button
		{
			idc = 1606;
			text = "Load"; //--- ToDo: Localize;
			onMouseButtonClick = "0 = [""Load""] call BWPLM_fnc_Menu_Presets;";
			x = 0.0720312 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class BWPLM_Button_1607: BWPLM_Button
		{
			idc = 1607;
			text = "Delete "; //--- ToDo: Localize;
			onMouseButtonClick = "0 = [""Del""] call BWPLM_fnc_Menu_Presets;";
			
			x = 0.139062 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.022 * safezoneH;
		};
		
		class nameOfVeh: BWPLM_Text
		{
			idc = 3000;
			text = "";

			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.022 * safezoneH;
		};

		/*
			Rearm / Refuel 
		*/
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Big_W, v1.063, #Bogito)
		////////////////////////////////////////////////////////
		class BWPLM_Text_1002: BWPLM_Text
		{
			idc = 500;
			text = "Fuel:"; //--- ToDo: Localize;
	x = 0.0101562 * safezoneW + safezoneX;
	y = 0.2558 * safezoneH + safezoneY;
	w = 0.185625 * safezoneW;
	h = 0.022 * safezoneH;
		};		
		class BWPLM_Text_1003: BWPLM_Text
		{
			idc = 501;
			text = "Health:"; //--- ToDo: Localize;
	x = 0.0101562 * safezoneW + safezoneX;
	y = 0.2844 * safezoneH + safezoneY;
	w = 0.185625 * safezoneW;
	h = 0.022 * safezoneH;
		};
		class BWPLM_Slider_1900: BWPLM_Progress
		{
			idc = 502;
			colorBar[] = {0.2,0,0,0.6};
	x = 0.0101562 * safezoneW + safezoneX;
	y = 0.2558 * safezoneH + safezoneY;
	w = 0.185625 * safezoneW;
	h = 0.022 * safezoneH;
		};

		class BWPLM_Slider_1901: BWPLM_Progress
		{
			idc = 503;
			colorBar[] = {0,0,0.2,0.6};
	x = 0.0101562 * safezoneW + safezoneX;
	y = 0.2844 * safezoneH + safezoneY;
	w = 0.185625 * safezoneW;
	h = 0.022 * safezoneH;
		};

		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Big_W, v1.063, #Hokaxu)
		////////////////////////////////////////////////////////
		class flashFuel: BWPLM_Picture
		{
			idc = 100;

			text = "\A3\ui_f\data\igui\cfg\simpleTasks\types\refuel_ca.paa"; //--- ToDo: Localize;

			x = 0.21125 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
			colorText[] = {1,0,0,0.45};
			fade = 1;
		};
		class flashHealth: BWPLM_Picture
		{
			idc = 101;

			text = "\A3\ui_f\data\igui\cfg\simpleTasks\types\repair_ca.paa"; //--- ToDo: Localize;
			x = 0.21125 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
			colorText[] = {0,0,1,0.45};
			fade = 1; 
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////

	};
	
};