params ["_vehicle","_caller"];

if (isNull cursorObject) then {
	["NO TARGET",1] remoteExec ["njt_fnc_fcs_overrideLocalWarning",commander _vehicle];
} else {
	_overrideTarget = (cursorObject modelToWorldWorld (boundingCenter cursorObject));
	[_vehicle,[_overrideTarget,_vehicle unitTurret (gunner _vehicle),true]] remoteExec ["lockCameraTo",gunner _vehicle];
	["TC OVERRIDE",2] remoteExec ["njt_fnc_fcs_overrideLocalWarning",gunner _vehicle];
	_vehicle setVariable ["njt_commanderOverride_cooldown",true,true];
	sleep 3;
	_vehicle setVariable ["njt_commanderOverride_cooldown",false,true];
};