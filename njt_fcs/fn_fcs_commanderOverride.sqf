params ["_target","_caller"];

if (isNull cursorObject) then {
	_caller groupChat "FCS: No object target for commander's override!";
} else {
	[_target,[cursorObject,_target unitTurret (gunner _target),true]] remoteExec ["lockCameraTo",gunner _target];
	_target setVariable ["njt_commanderOverride_cooldown",true,true];
	sleep 3;
	_target setVariable ["njt_commanderOverride_cooldown",false,true];
};