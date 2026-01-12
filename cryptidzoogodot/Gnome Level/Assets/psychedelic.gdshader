shader_type spatial;
render_mode unshaded, cull_disabled;

uniform float strength : hint_range(0.0, 1.0) = 0.4;
uniform float speed : hint_range(0.0, 2.0) = 0.333;
uniform vec2 screen_resolution = vec2(1280.0, 720.0); // Must be set from GDScript

void fragment() {
    float t = TIME * speed;

    vec3 col = vec3(0.0);
    
    // Convert SCREEN_UV to range [-1, 1], centering it
    vec2 pos = SCREEN_UV * 2.0 - 1.0;
    
    // Preserve aspect ratio manually using the screen resolution uniform
    pos.y *= (screen_resolution.y / screen_resolution.x);
    
    pos *= 4.0; // Scale up for a larger effect

    for (float k = 1.0; k < 7.0; k += 1.0) { 
        pos.x += strength * sin(2.0 * t + k * 1.5 * pos.y) + t * 0.5;
        pos.y += strength * cos(2.0 * t + k * 1.5 * pos.x);
    }

    // Color calculation using time and position
    col += 0.5 + 0.5 * cos(TIME + pos.xyx + vec3(0.0, 2.0, 4.0));

    // Gamma correction
    col = pow(col, vec3(0.4545));

    // Set final output
    ALBEDO = col;
    ALPHA = 1.0;
}
