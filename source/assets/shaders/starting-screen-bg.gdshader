shader_type canvas_item;

void fragment() {
	vec2 uv = vec2(mod(UV.x + TIME * 0.1, 1.0), UV.y);
	COLOR = texture(TEXTURE, uv);
}