shader_type spatial;

uniform vec4 color : hint_color = vec4(1.0);
uniform float brightness = 1.0;

void fragment() {
	ALBEDO = vec3(0.0);
	EMISSION = color.rgb * brightness;
	ALPHA = smoothstep(0.0, 0.2, NORMAL.z);
}