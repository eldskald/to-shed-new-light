shader_type spatial;
render_mode unshaded;

uniform vec4 color: hint_color = vec4(1.0);

void vertex() {
	vec4 view = vec4(0.0, 0.0, -1.0, 0.0);
	VERTEX += (inverse(WORLD_MATRIX) * CAMERA_MATRIX * view).xyz * 0.1;
}

void fragment() {
	ALBEDO = color.rgb;
}
