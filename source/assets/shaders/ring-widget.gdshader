shader_type spatial;
render_mode depth_draw_never, unshaded;

uniform vec4 color : hint_color = vec4(1.0);
uniform float brightness = 1.0;
uniform float alpha = 1.0;

void fragment() {
	ALBEDO = color.rgb * brightness;
	ALPHA = smoothstep(0.05, 0.2, 0.5 - abs(UV.x - 0.5)) * alpha;
}