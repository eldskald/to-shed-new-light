shader_type spatial;
render_mode depth_draw_always;

uniform vec4 color : hint_color = vec4(1.0);
uniform float brightness = 1.0;
uniform float alpha = 1.0;

void fragment() {
	ALBEDO = vec3(0.0);
	EMISSION = color.rgb * brightness;
	ALPHA = alpha;
}