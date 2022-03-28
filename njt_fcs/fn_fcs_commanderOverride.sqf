params ["_target","_caller"];

if (isNull cursorObject) then {
	["NO TARGET",1] remoteExec ["njt_fnc_fcs_overrideLocalWarning",commander _target];
} else {
	[_target,[cursorObject,_target unitTurret (gunner _target),true]] remoteExec ["lockCameraTo",gunner _target];
	["TC OVERRIDE",2] remoteExec ["njt_fnc_fcs_overrideLocalWarning",gunner _target];
	_target setVariable ["njt_commanderOverride_cooldown",true,true];
	sleep 3;
	_target setVariable ["njt_commanderOverride_cooldown",false,true];
};