shader_type spatial;

uniform vec4 color : hint_color = vec4(1.0);
uniform float brightness = 1.0;

void fragment() {
	EMISSION = color.rgb * brightness;
}