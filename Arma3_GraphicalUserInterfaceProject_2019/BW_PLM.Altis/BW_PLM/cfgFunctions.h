class BWPLM
{

	class PylonLoadoutMenu 
	{
		file = "BW_PLM\Functions\PLM";
		
		class Menu_Opened;
		class Menu_PylonChanged;		
		class Menu_Presets;
	}
	class MoveOutOFHanger 
	{
		file = "BW_PLM\Functions\Hanger";
		
		class Init_HangerPlayerActions {postInit = 1;};
		class Init_HangerRespawn {postInit = 1;};
		class StoreInHanger;
	};
	
};	