shader_type canvas_item;

uniform float tl : hint_range(0.0, 500.0) = 0.0;
uniform float tr : hint_range(0.0, 500.0) = 0.0;
uniform float bl : hint_range(0.0, 500.0) = 0.0;
uniform float br : hint_range(0.0, 500.0) = 0.0;

void fragment() {
	// Convert UV to pixel coordinates
	vec2 size = 1.0 / TEXTURE_PIXEL_SIZE; // texture size in pixels
	vec2 pos = UV * size;
	
	// Top-left
	if (pos.x < tl && pos.y < tl) {
		if (distance(pos, vec2(tl, tl)) > tl) {
			discard;
		}
	}
	
	// Top-right
	else if (pos.x > size.x - tr && pos.y < tr) {
		if (distance(pos, vec2(size.x - tr, tr)) > tr) {
			discard;
		}
	}
	
	// Bottom-left
	else if (pos.x < bl && pos.y > size.y - bl) {
		if (distance(pos, vec2(bl, size.y - bl)) > bl) {
			discard;
		}
	}
	
	// Bottom-right
	else if (pos.x > size.x - br && pos.y > size.y - br) {
		if (distance(pos, vec2(size.x - br, size.y - br)) > br) {
			COLOR.a = 0.0;
		}
	}
	
	else{
		COLOR=texture(TEXTURE,UV);
	}
}
