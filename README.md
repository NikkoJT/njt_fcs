# njt_fcs
Extra FCS features and damage for Arma 3

This module adds some new scripted features for use with armoured vehicles.
1. Commander's Override
  The vehicle commander can use the action menu to automatically traverse the gun onto a target object, temporarily overriding the gunner's control.
2. FCS Damage
  When hit by high-calibre weapons, the vehicle has a chance to suffer an FCS failure. This disables the commander's override, the gunner's laser rangefinder, and all vehicle NV equipment.
  A player with the Engineer trait can repair the FCS from the gunner's seat.
3. Driver's Brake Release
  The driver can disable the automatic brakes, allowing the vehicle to roll freely at low speeds and under physics input.
  
  
Usage:
On every client (e.g. initPlayerLocal.sqf) use `[_vehicle] call njt_fnc_fcs_init;`

Example:
```sqf
_fcsvehicles = vehicles select {typeOf _x in ["I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F"]};
{[_x] call njt_fnc_fcs_init} forEach _fcsvehicles;
```
 
