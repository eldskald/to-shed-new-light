shader_type spatial;

uniform float ring_brightness = 1.0;
uniform float ring_thickness : hint_range(0,1) = 0.2;
uniform vec3 origin = vec3(0.0);
uniform float fade_in_dist;
uniform float fade_out_dist;

void fragment() {
	ALBEDO = vec3(0.0);
	EMISSION = vec3(1.0 - step(ring_thickness, dot(VIEW, NORMAL))) * ring_brightness;
	
	// We calculate the fade with the distance from the plane that has the origin point
	// and normal vector equal to (0,0,1) in view space, that's parallel to where the
	// camera is looking. On the editor, set fade in and out at high numbers to see everything,
	// and set fade in to 0.5 and fade out to somewhere around 1.0 to hide stuff.
	// Also, don't forget to set the camera to orthogonal mode.
	vec3 view_space_origin = (INV_CAMERA_MATRIX * vec4(origin, 1.0)).xyz;
	float t = abs((VERTEX - view_space_origin).z);
	
	ALPHA = 1.0 - smoothstep(fade_in_dist, fade_out_dist, t);
}