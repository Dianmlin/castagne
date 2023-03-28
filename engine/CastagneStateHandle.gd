extends Node

var _memory
var _pid
var _engineData
var _phase
var _eid
var _targetEID
var _engine


func InitHandle(memory, engine):
	_memory = memory
	_eid = -1
	_targetEID = -1
	_pid = -1
	_phase = "None"
	_engine = engine

func CloneStateHandle():
	var sh = _engine.CreateStateHandle(_memory)
	sh._memory = _memory
	sh._pid = _pid
	sh._engineData = _engineData
	sh._phase = _phase
	sh._eid = _eid
	sh._targetEID = _targetEID
	sh._engine = _engine
	return sh


# Global entity / player management
func PointToEntity(eid):
	_eid = eid
	if(eid >= 0):
		PointToPlayer(EntityGet("_Player"))
	else:
		_pid = -1
	
	return eid < _memory._memoryEntities.size()
func PointToPlayer(pid):
	_pid = pid
func GetPlayer():
	return _pid
#func PointToPlayerMainEntity():
#	

# Execution
func GetEntityID():
	return _eid
func GetTargetEntity():
	return _targetEID
func SetTargetEntity(targetEID):
	_targetEID = targetEID

func GetPhase():
	return _phase
func SetPhase(phase):
	_phase = phase

# Memory Access
func GlobalGet(key):
	return _memory.GlobalGet(key)
func GlobalSet(key, value):
	return _memory.GlobalSet(key, value)
func GlobalHas(key):
	return _memory.GlobalHas(key)
func GlobalAdd(key, value):
	return GlobalSet(key, GlobalGet(key)+value)
	
func PlayerGet(key):
	return _memory.PlayerGet(_pid, key)
func PlayerSet(key, value):
	return _memory.PlayerSet(_pid, key, value)
func PlayerHas(key):
	return _memory.PlayerHas(_pid, key)
func PlayerAdd(key, value):
	return PlayerSet(key, PlayerGet(key)+value)
	
func EntityGet(key):
	return _memory.EntityGet(_eid, key)
func EntitySet(key, value):
	return _memory.EntitySet(_eid, key, value)
func EntityHas(key):
	return _memory.EntityHas(_eid, key)
func EntityAdd(key, value):
	return EntitySet(key, EntityGet(key)+value)
	
func TargetEntityGet(key):
	print("NOT YET")
	return _memory.EntityGet(_targetEID, key)
func TargetEntitySet(key, value):
	print("NOT YET")
	return _memory.EntitySet(_targetEID, key, value)
func TargetEntityHas(key):
	return _memory.EntityHas(_targetEID, key)
func TargetEntityAdd(key, value):
	return TargetEntitySet(key, TargetEntityGet(key)+value)

func EntityHasFlag(flag):
	return EntityGet("_Flags").has(flag)
func EntitySetFlag(flag, active=true):
	if(active):
		if(!EntityGet("_Flags").has(flag)):
			EntityGet("_Flags").append(flag)
	else:
		EntityGet("_Flags").erase(flag)
	

# InstancedDataAccess
func IDGlobalGet(key):
	return _engine.instancedData[key]
func IDGlobalSet(key, value):
	_engine.instancedData[key] = value
func IDGlobalHas(key):
	return _engine.instancedData.has(key)
func IDPlayerGet(key):
	return _engine.instancedData["Players"][PlayerGet("PID")][key]
func IDPlayerSet(key, value):
	_engine.instancedData["Players"][PlayerGet("PID")][key] = value
func IDPlayerHas(key):
	return _engine.instancedData["Players"][PlayerGet("PID")].has(key)
func IDEntityGet(key):
	return _engine.instancedData["Entities"][EntityGet("_EID")][key]
func IDEntitySet(key, value):
	_engine.instancedData["Entities"][EntityGet("_EID")][key] = value
func IDEntityHas(key):
	return _engine.instancedData["Entities"][EntityGet("_EID")].has(key)

func ConfigData():
	return _engine.configData
func Engine():
	return _engine
func FighterScripts():
	return _engine.fighterScripts
func Memory(): # Temporary ?
	return _memory
func Input():
	return _engine.configData.Input()

# TODO Flags

