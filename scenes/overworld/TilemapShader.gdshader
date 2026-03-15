shader_type canvas_item;
uniform float amount : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    vec3 inverted_rgb = vec3(1.0) - tex_color.rgb;
    vec3 final_rgb = mix(tex_color.rgb, inverted_rgb, amount);
    COLOR = vec4(final_rgb, tex_color.a);
}