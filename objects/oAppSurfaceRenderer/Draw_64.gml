var _guiW = window_get_width();
var _guiH = window_get_height();

display_set_gui_size(_guiW, _guiH);

var _surfW = surface_get_width(application_surface);
var _surfH = surface_get_height(application_surface);

switch(filter)
{
    case 0:
        draw_surface_stretched(application_surface, 0, 0, _guiW, _guiH);
    break;
    
    case 1:
        gpu_set_tex_filter(true);
        draw_surface_stretched(application_surface, 0, 0, _guiW, _guiH);
        gpu_set_tex_filter(false);
    break;
    
    case 2:
        // https://www.shadertoy.com/view/MlB3D3
        // https://hero.handmade.network/episode/chat/chat018/
        // By Casey Muratori    2015-05-30
        
        var _texture = surface_get_texture(application_surface);
        var _texelW = texture_get_texel_width(_texture);
        var _texelH = texture_get_texel_height(_texture);
        
        shader_set(shdBoxFilter);
        gpu_set_tex_filter(true);
        shader_set_uniform_f(shader_get_uniform(shdBoxFilter, "u_vTexelSize"), _texelW, _texelH);
        shader_set_uniform_f(shader_get_uniform(shdBoxFilter, "u_vScale"), _guiW/_surfW, _guiH/_surfH);
        draw_surface_stretched(application_surface, 0, 0, _guiW, _guiH);
        shader_reset();
        gpu_set_tex_filter(false);
    break;
}

var _string = "Pixel Art Upscaling Shader by Casey Muratori\nPort to GM by @jujuadams\napp_surf resolution = 480x270\nGUI resolution = 1280x720\nScaling factor = x2.67\nArrow keys to move test pattern\nPress F to cycle through the filters\n";
switch(filter)
{
    case 0: _string += "Filter = off";           break;
    case 1: _string += "Filter = bilinear";      break;
    case 2: _string += "Filter = custom filter"; break;
}

draw_set_color(c_black);
draw_set_alpha(0.5);
draw_text(10, 12, _string);
draw_set_alpha(1);
draw_text( 9, 10, _string);
draw_text(10,  9, _string);
draw_text(11, 10, _string);
draw_text(10, 11, _string);
draw_set_color(c_white);
draw_text(10, 10, _string);