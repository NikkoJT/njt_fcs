// NikkoJT FCS failure simulator: persistent effects
// Called from njt_fnc_FCS_failure

params ["_target"];

// It's all a big loop
while {(_target getVariable ["fcs_failure",false]) && (alive _target)} do {

	// Check whether there is a gunner
	if !(isNull (gunner _target)) then {
		_currentGunner = gunner _target;
		{
			// Get the muzzles for every weapon on the main turret and force set their zeroing
			private _targetWeapon = _x;
			private _targetWeaponMuzzles = getArray (configFile >> "CfgWeapons" >> _x >> "muzzles");
			{
				_targetMuzzle = _targetWeapon;
				if !(_x == "this") then {
					_targetMuzzle = _x;
				};
				_zeroCheck = _currentGunner setWeaponZeroing [_targetWeapon,_targetMuzzle,1];
				if !(_zeroCheck) then { 
					diag_log format ["FCS: Weapon zeroing failure for %1",_targetWeapon]
				} else { 
					// diag_log format ["Zeroing set for %1",_targetWeapon]
				};
			} forEach _targetWeaponMuzzles;
		} forEach (_target weaponsTurret [0]);
		
		// Show a visual warning to the gunner - remoteExec'd to be local and only displayed when they are in the optics
		[[],{
		
			_FCSWarningDisplay = findDisplay 46 ctrlCreate ["RscStructuredText", 4404];
			if (cameraView == "GUNNER") then {
				_FCSWarningDisplay ctrlSetPosition [0.5, 0.7,0.5,0.5];
				_FCSWarningDisplay ctrlSetStructuredText parseText "<t shadow='0' size='1.1'>FCS FAILURE</t>";
				_FCSWarningDisplay ctrlSetTextColor [1,0.1,0.1,1];
				_FCSWarningDisplay ctrlSetFont "PuristaBold";
				_FCSWarningDisplay ctrlCommit 0;
				sleep 0.5;
			};
			ctrlDelete _FCSWarningDisplay;
		}] remoteExec ["spawn",_currentGunner,false];
		
	};
	
	sleep 0.8;
	
};
