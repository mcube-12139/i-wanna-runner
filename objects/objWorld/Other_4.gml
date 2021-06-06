var jsoMap = file_json_read_all(global.path + global.mainName);

var objectList = jsoMap[? "objects"];
var roomList = jsoMap[? "rooms"];
var spriteList = jsoMap[? "sprites"];

// 读取物体
for (var i = 0, sz = ds_list_size(objectList); i != sz; ++i) {
	var name = objectList[| i];
	
	var jsoMapp = file_json_read_all(global.path + @"res\object\" + name + ".json");
	global.objectMap[? name] = new GameObject(jsoMapp[? "sprite"]);
	
	ds_map_destroy(jsoMapp);
}
ds_list_destroy(objectList);

// 读取房间
for (var i = 0, sz = ds_list_size(roomList); i != sz; ++i) {
	var name = roomList[| i];
	
	var jsoMapp = file_json_read_all(global.path + @"res\room\" + name + ".json");
	var instanceList = jsoMapp[? "instances"];
	
	// 读取房间实例
	var roomInstances = [];
	var k = 0;
	for (var j = 0, szz = ds_list_size(instanceList); j != szz; ++j) {
		var instMap = instanceList[| j];
		
		roomInstances[k++] = new RoomInstance(instMap[? "x"], instMap[? "y"], instMap[? "object"]);
		
		ds_map_destroy(instMap);
	}
	ds_list_destroy(instanceList);
	
	global.roomMap[? name] = new Room(roomInstances);
	
	ds_map_destroy(jsoMapp);
}
ds_list_destroy(roomList);

// 读取精灵
for (var i = 0, sz = ds_list_size(spriteList); i != sz; ++i) {
	var name = spriteList[| i];
	
	var jsoMapp = file_json_read_all(global.path + @"res\sprite\" + name + ".json");
	var file = jsoMapp[? "file"];
	
	// 载入精灵图
	var spr = sprite_add(global.path + @"res\sprite\image\" + file, 1, false, false, jsoMapp[? "origin-x"], jsoMapp[? "origin-y"]);
	sprite_collision_mask(spr, false, 0, 0, 0, 0, 0, jsoMapp[? "precise"] ? bboxkind_precise : bboxkind_rectangular, 0);
	
	global.spriteMap[? name] = spr;
	
	ds_map_destroy(jsoMapp);
}
ds_list_destroy(spriteList);

var firstRoomName = jsoMap[? "first-room"];
var firstRoom = global.roomMap[? firstRoomName];
var ins = firstRoom.instances;
for (var i = 0, sz = array_length(ins); i != sz; ++i) {
	var insss = ins[i];
	
	var inss = instance_create_layer(insss.myx, insss.myy, "Instances", objAny);
	inss.type = i;
	
	var obj = global.objectMap[? insss.object];
	inss.sprite_index = global.spriteMap[? obj.sprite];
}

ds_map_destroy(jsoMap);