shader_type spatial;

uniform sampler2D gradient : hint_white;
uniform float ring_thickness : hint_range(0.0, 1.0) = 0.5;
uniform float brightness = 1.0;
uniform float cycle_length = 5.0;

void fragment() {
	ALBEDO = vec3(0.0);
	float time = mod(TIME / cycle_length, 1.0);
	float ring = 1.0 - step(ring_thickness, NORMAL.z);
	EMISSION = texture(gradient, vec2(time)).rgb * ring * brightness;
}