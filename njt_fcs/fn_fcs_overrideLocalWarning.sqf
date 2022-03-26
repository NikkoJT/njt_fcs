if (cameraView == "GUNNER") then {
	_overrideWarningDisplay = findDisplay 46 ctrlCreate ["RscStructuredText", 4404];
	_overrideWarningDisplay ctrlSetPosition [0.5, 0.7,0.5,0.5];
	_overrideWarningDisplay ctrlSetStructuredText parseText "<t shadow='0' size='1.1'>TC OVERRIDE</t>";
	_overrideWarningDisplay ctrlSetTextColor [1,0.1,0.1,1];
	_overrideWarningDisplay ctrlSetFont "PuristaBold";
	_overrideWarningDisplay ctrlCommit 0;
	sleep 2;
	ctrlDelete _overrideWarningDisplay;
};