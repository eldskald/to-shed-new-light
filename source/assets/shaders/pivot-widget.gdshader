shader_type spatial;
render_mode depth_draw_always, unshaded;

uniform vec4 color : hint_color = vec4(1.0);
uniform float brightness = 1.0;
uniform float alpha = 1.0;

void fragment() {
	ALBEDO = color.rgb * brightness;
	ALPHA = alpha;
}