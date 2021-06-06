function GameObject(_sprite) constructor {
	sprite = _sprite;
}

function RoomInstance(_x, _y, _object) constructor {
	myx = _x;
	myy = _y;
	object = _object;
}

function Room(_instances) constructor {
	instances = _instances;
}

function file_json_read_all(path) {
	var buf = buffer_load(path);

	var str = buffer_read(buf, buffer_string);
	buffer_delete(buf);

	var jsoMap = json_decode(str);
	
	return jsoMap;
}

global.path = @"D:\gms2-project\I Wanna Game 0\";
global.mainName = @"I Wanna Game 0.json";

// Map<string, GameObject>
global.objectMap = ds_map_create();
// Map<string, Room>
global.roomMap = ds_map_create();
// Map<string, GMSprite>
global.spriteMap = ds_map_create();