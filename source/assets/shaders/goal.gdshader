shader_type spatial;
render_mode unshaded;

uniform float brightness = 1.0;
uniform float ring_thickness : hint_range(0,1) = 0.2;
uniform sampler2D noise_tex : hint_white;

void fragment() {
	float noise = texture(
		noise_tex, vec2(UV.y + TIME * 0.2, UV.x + TIME * 0.2)).r;
	float factor = (smoothstep(0.4, 0.6, noise));
	ALBEDO = vec3(1.0 - step(ring_thickness * factor, NORMAL.z)) * brightness;
}
