shader_type spatial;
render_mode depth_draw_always, unshaded;

uniform vec4 color: hint_color = vec4(1.0);
uniform float brightness = 1.0;
uniform float alpha = 1.0;
uniform float grow = 0.0;

void vertex() {
	VERTEX += NORMAL * grow;
}

void fragment() {
	ALBEDO = color.rgb * brightness;
	float border = max(abs(UV.x - 0.5), abs(UV.y - 0.5));
	float base_alpha = border > 0.4 ? (
		smoothstep(0.5, 0.4, border)) : smoothstep(0.1, 0.4, border);
	ALPHA = base_alpha * alpha;
}
