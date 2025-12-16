vec4 effect( vec4 colour, Image texture, vec2 texture_coords, vec2 screen_coords )
{
  vec4 pixel = Texel(texture, texture_coords);
  float red = pixel.r;
  float green = pixel.g;
  float blue = pixel.b;
  float resR = red * 0.55 + green * 0.32 + blue * 0.26;
  float resG = red * 0.32 + green * 0.26 + blue * 0.16;
  float resB = red * 0.18 + green * 0.15 + blue * 0.12;
  return vec4(resR, resG, resB, pixel.a);
}