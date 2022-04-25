if (isDedicated) exitWith {};

params ["_vehicle"];

if !(_vehicle isKindOf "LandVehicle") exitWith { diag_log "FCS: tried to run on something that isn't a vehicle" };
	
if (_vehicle getVariable ["fcs_hasEH",false]) exitWith { diag_log "FCS: tried to run on something that already has FCS set up"};

// Commander's override action
_vehicle addAction
[
	"Commander's override",	
	{
		params ["_target", "_caller", "_actionId", "_arguments"];
		[_target,_caller] call njt_fnc_fcs_commanderOverride;
	},
	nil,	
	1.5,	
	false,	
	true,	
	"",	
	"(_this == commander _target) && {!(isNull gunner _target) && !(_target getVariable [""njt_commanderOverride_cooldown"",false]) && !(_target getVariable [""FCS_failure"",false])}", 
	0,		
	false,	
	"",	
	""	
];


// Hit EH for FCS failure
_vehicle addEventHandler ["HitPart",{
		(_this select 0) params ["_target", "_shooter", "_projectile", "_position", "_velocity", "_selection", "_ammo", "_vector", "_radius", "_surfaceType", "_isDirect"];
		// Call the actual failure evaluator
		[_target,_projectile,_isDirect] call njt_fnc_fcs_failure;
	}];
	
_vehicle setVariable ["fcs_hasEH",true];

// Hold action to repair FCS failure
// Players with repair trait in the gunner's seat of a vehicle with failed stabiliser can repair it
[
	_vehicle, // Target
	"Reset Fire Control System", // Title
	"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", // Idle icon
	"\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa", // Progress icon
	"(_target getVariable [""fcs_failure"",false]) && (gunner _target == _this) && (_this getUnitTrait ""engineer"")", // Condition to show
	"(_target getVariable [""fcs_failure"",false]) && (gunner _target == _this) && (_this getUnitTrait ""engineer"")", // Condition to progress
	{}, // Code on start
	{}, // Code on tick
	{ 
		params ["_target", "_caller", "_actionId", "_arguments"];
		_target setVariable ["fcs_failure",false,true];
		[_target,[false,[0]]] remoteExec ["enableDirectionStabilization",0,_target];
		_target disableNVGEquipment false;
	}, // Code on completed
	{}, // Code on interrupt
	[], // Arguments to pass
	10, // Duration
	1, // Priority
	false, // Remove on completion
	false, // Show when unconscious
	true // Show on screen
] call BIS_fnc_holdActionAdd;

// Action to prevent rangefinder use during FCS failure
_vehicle addAction ["FCS failure - repair required", // Title
	{
		hint "Someone familiar with maintenance can reset the FCS.";
	}, // Code
	"", // Arguments
	10, // Priority
	false, // Show window
	true, // Hide on use
	"gunElevAuto", // Shortcut
	"(_this == gunner _target) && {_target getVariable [""FCS_failure"",false]}" // Condition
];

// Not FCS but I'm putting it in here
_vehicle addAction [
    "Disable automatic brakes (brake to re-engage)",
    {
        params ["_target", "_caller", "_actionId", "_arguments"];
        [_target,true] remoteExec ["disableBrakes",_target];
    },
    "",
    10,
    false,
    true,
    "",
    "(driver _target == _this) && {!brakesDisabled _target}"
];