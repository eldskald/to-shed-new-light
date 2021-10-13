shader_type spatial;

uniform sampler2D gradient : hint_white;
uniform float cycle_length = 5.0;

void fragment() {
	ALBEDO = vec3(0.0);
	float time = mod(TIME / cycle_length, 1.0);
	EMISSION = texture(gradient, vec2(time, 0.0)).rgb;
}