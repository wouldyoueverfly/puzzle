
�
�#version 330

layout(std140) uniform vs_uniforms
{
    mat4 view_proj;
} _89;

out vec2 var_texcoord0;
layout(location = 1) in vec2 texcoord0;
out vec4 var_face_color;
layout(location = 3) in vec4 face_color;
out vec4 var_outline_color;
layout(location = 4) in vec4 outline_color;
out vec4 var_shadow_color;
layout(location = 5) in vec4 shadow_color;
out vec4 var_sdf_params;
layout(location = 2) in vec4 sdf_params;
out vec4 var_layer_mask;
layout(location = 6) in vec3 layer_mask;
layout(location = 0) in vec4 position;

void main()
{
    var_texcoord0 = texcoord0;
    var_face_color = vec4(face_color.xyz * face_color.w, face_color.w);
    var_outline_color = vec4(outline_color.xyz * outline_color.w, outline_color.w);
    var_shadow_color = vec4(shadow_color.xyz * shadow_color.w, shadow_color.w);
    var_sdf_params = sdf_params;
    var_layer_mask.x = layer_mask.x;
    var_layer_mask.y = layer_mask.y;
    var_layer_mask.z = layer_mask.z;
    var_layer_mask.w = (layer_mask.x * layer_mask.y) * layer_mask.z;
    gl_Position = _89.view_proj * vec4(position.x, position.y, position.z, 1.0);
}

 
�
�#version 330

uniform sampler2D texture_sampler;

in vec2 var_texcoord0;
in vec4 var_sdf_params;
in vec4 var_layer_mask;
layout(location = 0) out vec4 out_fragColor;
in vec4 var_face_color;
in vec4 var_outline_color;
in vec4 var_shadow_color;

void main()
{
    vec4 _19 = texture(texture_sampler, var_texcoord0);
    float _25 = _19.x;
    float _60 = var_sdf_params.x + var_sdf_params.z;
    float _62 = smoothstep(var_sdf_params.x - var_sdf_params.z, _60, _25);
    float _71 = smoothstep(var_sdf_params.y - var_sdf_params.z, var_sdf_params.y + var_sdf_params.z, _25);
    out_fragColor = (((var_face_color * _62) * var_layer_mask.x) + (((var_outline_color * _71) * var_layer_mask.y) * (1.0 - (_62 * var_layer_mask.w)))) + (((var_shadow_color * mix(smoothstep(var_sdf_params.w - var_sdf_params.z, _60, _19.z), _71, floor(var_sdf_params.w))) * var_layer_mask.z) * (1.0 - (min(1.0, _71 + _62) * var_layer_mask.w)));
}


�	
�	#version 300 es

layout(std140) uniform vs_uniforms
{
    mat4 view_proj;
} _89;

out mediump vec2 var_texcoord0;
layout(location = 1) in mediump vec2 texcoord0;
out mediump vec4 var_face_color;
layout(location = 3) in mediump vec4 face_color;
out mediump vec4 var_outline_color;
layout(location = 4) in mediump vec4 outline_color;
out mediump vec4 var_shadow_color;
layout(location = 5) in mediump vec4 shadow_color;
out mediump vec4 var_sdf_params;
layout(location = 2) in mediump vec4 sdf_params;
out mediump vec4 var_layer_mask;
layout(location = 6) in mediump vec3 layer_mask;
layout(location = 0) in mediump vec4 position;

void main()
{
    var_texcoord0 = texcoord0;
    var_face_color = vec4(face_color.xyz * face_color.w, face_color.w);
    var_outline_color = vec4(outline_color.xyz * outline_color.w, outline_color.w);
    var_shadow_color = vec4(shadow_color.xyz * shadow_color.w, shadow_color.w);
    var_sdf_params = sdf_params;
    var_layer_mask.x = layer_mask.x;
    var_layer_mask.y = layer_mask.y;
    var_layer_mask.z = layer_mask.z;
    var_layer_mask.w = (layer_mask.x * layer_mask.y) * layer_mask.z;
    gl_Position = _89.view_proj * vec4(position.x, position.y, position.z, 1.0);
}

 
�
�#version 300 es
precision mediump float;
precision highp int;

uniform mediump sampler2D texture_sampler;

in vec2 var_texcoord0;
in vec4 var_sdf_params;
in vec4 var_layer_mask;
layout(location = 0) out highp vec4 out_fragColor;
in vec4 var_face_color;
in vec4 var_outline_color;
in vec4 var_shadow_color;

void main()
{
    vec4 _19 = texture(texture_sampler, var_texcoord0);
    float _25 = _19.x;
    float _60 = var_sdf_params.x + var_sdf_params.z;
    float _62 = smoothstep(var_sdf_params.x - var_sdf_params.z, _60, _25);
    float _71 = smoothstep(var_sdf_params.y - var_sdf_params.z, var_sdf_params.y + var_sdf_params.z, _25);
    out_fragColor = (((var_face_color * _62) * var_layer_mask.x) + (((var_outline_color * _71) * var_layer_mask.y) * (1.0 - (_62 * var_layer_mask.w)))) + (((var_shadow_color * mix(smoothstep(var_sdf_params.w - var_sdf_params.z, _60, _19.z), _71, floor(var_sdf_params.w))) * var_layer_mask.z) * (1.0 - (min(1.0, _71 + _62) * var_layer_mask.w)));
}


�
�#version 100

struct vs_uniforms
{
    mat4 view_proj;
};

uniform vs_uniforms _89;

varying mediump vec2 var_texcoord0;
attribute mediump vec2 texcoord0;
varying mediump vec4 var_face_color;
attribute mediump vec4 face_color;
varying mediump vec4 var_outline_color;
attribute mediump vec4 outline_color;
varying mediump vec4 var_shadow_color;
attribute mediump vec4 shadow_color;
varying mediump vec4 var_sdf_params;
attribute mediump vec4 sdf_params;
varying mediump vec4 var_layer_mask;
attribute mediump vec3 layer_mask;
attribute mediump vec4 position;

void main()
{
    var_texcoord0 = texcoord0;
    var_face_color = vec4(face_color.xyz * face_color.w, face_color.w);
    var_outline_color = vec4(outline_color.xyz * outline_color.w, outline_color.w);
    var_shadow_color = vec4(shadow_color.xyz * shadow_color.w, shadow_color.w);
    var_sdf_params = sdf_params;
    var_layer_mask.x = layer_mask.x;
    var_layer_mask.y = layer_mask.y;
    var_layer_mask.z = layer_mask.z;
    var_layer_mask.w = (layer_mask.x * layer_mask.y) * layer_mask.z;
    gl_Position = _89.view_proj * vec4(position.x, position.y, position.z, 1.0);
}

 
�
�#version 100
precision mediump float;
precision highp int;

uniform mediump sampler2D texture_sampler;

varying vec2 var_texcoord0;
varying vec4 var_sdf_params;
varying vec4 var_layer_mask;
varying vec4 var_face_color;
varying vec4 var_outline_color;
varying vec4 var_shadow_color;

void main()
{
    vec4 _19 = texture2D(texture_sampler, var_texcoord0);
    float _25 = _19.x;
    float _60 = var_sdf_params.x + var_sdf_params.z;
    float _62 = smoothstep(var_sdf_params.x - var_sdf_params.z, _60, _25);
    float _71 = smoothstep(var_sdf_params.y - var_sdf_params.z, var_sdf_params.y + var_sdf_params.z, _25);
    gl_FragData[0] = (((var_face_color * _62) * var_layer_mask.x) + (((var_outline_color * _71) * var_layer_mask.y) * (1.0 - (_62 * var_layer_mask.w)))) + (((var_shadow_color * mix(smoothstep(var_sdf_params.w - var_sdf_params.z, _60, _19.z), _71, floor(var_sdf_params.w))) * var_layer_mask.z) * (1.0 - (min(1.0, _71 + _62) * var_layer_mask.w)));
}


�	
�	#version 430

layout(binding = 0, std140) uniform vs_uniforms
{
    mat4 view_proj;
} _89;

layout(location = 0) out vec2 var_texcoord0;
layout(location = 1) in vec2 texcoord0;
layout(location = 1) out vec4 var_face_color;
layout(location = 3) in vec4 face_color;
layout(location = 2) out vec4 var_outline_color;
layout(location = 4) in vec4 outline_color;
layout(location = 3) out vec4 var_shadow_color;
layout(location = 5) in vec4 shadow_color;
layout(location = 4) out vec4 var_sdf_params;
layout(location = 2) in vec4 sdf_params;
layout(location = 5) out vec4 var_layer_mask;
layout(location = 6) in vec3 layer_mask;
layout(location = 0) in vec4 position;

void main()
{
    var_texcoord0 = texcoord0;
    var_face_color = vec4(face_color.xyz * face_color.w, face_color.w);
    var_outline_color = vec4(outline_color.xyz * outline_color.w, outline_color.w);
    var_shadow_color = vec4(shadow_color.xyz * shadow_color.w, shadow_color.w);
    var_sdf_params = sdf_params;
    var_layer_mask.x = layer_mask.x;
    var_layer_mask.y = layer_mask.y;
    var_layer_mask.z = layer_mask.z;
    var_layer_mask.w = (layer_mask.x * layer_mask.y) * layer_mask.z;
    gl_Position = _89.view_proj * vec4(position.x, position.y, position.z, 1.0);
}

 
�
�#version 430

layout(binding = 0) uniform sampler2D texture_sampler;

layout(location = 0) in vec2 var_texcoord0;
layout(location = 4) in vec4 var_sdf_params;
layout(location = 5) in vec4 var_layer_mask;
layout(location = 0) out vec4 out_fragColor;
layout(location = 1) in vec4 var_face_color;
layout(location = 2) in vec4 var_outline_color;
layout(location = 3) in vec4 var_shadow_color;

void main()
{
    vec4 _19 = texture(texture_sampler, var_texcoord0);
    float _25 = _19.x;
    float _60 = var_sdf_params.x + var_sdf_params.z;
    float _62 = smoothstep(var_sdf_params.x - var_sdf_params.z, _60, _25);
    float _71 = smoothstep(var_sdf_params.y - var_sdf_params.z, var_sdf_params.y + var_sdf_params.z, _25);
    out_fragColor = (((var_face_color * _62) * var_layer_mask.x) + (((var_outline_color * _71) * var_layer_mask.y) * (1.0 - (_62 * var_layer_mask.w)))) + (((var_shadow_color * mix(smoothstep(var_sdf_params.w - var_sdf_params.z, _60, _19.z), _71, floor(var_sdf_params.w))) * var_layer_mask.z) * (1.0 - (min(1.0, _71 + _62) * var_layer_mask.w)));
}


�
�#     i                 GLSL.std.450                      main    	            !   "   .   /   ;   <   >   @   U   _        �        main      	   var_texcoord0        texcoord0        var_face_color       face_color    !   var_outline_color     "   outline_color     .   var_shadow_color      /   shadow_color      ;   var_sdf_params    <   sdf_params    >   var_layer_mask    @   layer_mask    U   gl_Position   W   vs_uniforms   W       view_proj     Y         _   position    G  	       G  	          G         G           G         G         G           G         G           G         G         G         G         G         G         G         G          G  !       G  !         G  "       G  "         G  #       G  $       G  &       G  '       G  *       G  +       G  ,       G  -       G  .       G  .         G  /       G  /         G  0       G  1       G  3       G  4       G  7       G  8       G  9       G  :       G  ;       G  ;         G  <       G  <         G  =       G  >       G  >         G  @       G  @         G  A       G  M       G  O       G  P       G  R       G  S       G  U          G  W      H  W          H  W             H  W       #       G  Y   !       G  Y   "       G  _       G  _          G  a       G  c       G  e       G  g            !                                        ;     	         
         ;  
                                ;                       ;                                   +                       ;     !      ;     "      ;     .      ;     /      ;     ;      ;     <      ;     >         ?         ;  ?   @      +     B          C         +     F      +     I      ;     U        V           W   V      X      W   ;  X   Y        Z          +  Z   [          \      V   ;     _      +     f     �?6               �     =           >  	      =           O                        A              =           �              Q               Q              Q              P                     >         =     #   "   O     $   #   #             A     %   "      =     &   %   �     '   $   &   Q     *   '       Q     +   '      Q     ,   '      P     -   *   +   ,   &   >  !   -   =     0   /   O     1   0   0             A     2   /      =     3   2   �     4   1   3   Q     7   4       Q     8   4      Q     9   4      P     :   7   8   9   3   >  .   :   =     =   <   >  ;   =   =     A   @   A  C   D   >   B   Q     E   A       >  D   E   A  C   G   >   F   Q     H   A      >  G   H   A  C   J   >   I   Q     K   A      >  J   K   A     L   @   B   =     M   L   A     N   @   F   =     O   N   �     P   M   O   A     Q   @   I   =     R   Q   �     S   P   R   A  C   T   >      >  T   S   A  \   ]   Y   [   =  V   ^   ]   A     `   _   B   =     a   `   A     b   _   F   =     c   b   A     d   _   I   =     e   d   P     g   a   c   e   f   �     h   ^   g   >  U   h   �  8   
�
�#     |                 GLSL.std.450                     main           3   V   X   _   m                �        main         texture_sampler      var_texcoord0         var_sdf_params    3   var_layer_mask    V   out_fragColor     X   var_face_color    _   var_outline_color     m   var_shadow_color    G         G     !       G     "      G         G         G            G         G         G         G         G          G            G  #       G  '       G  *       G  .       G  1       G  3       G  3         G  5       G  9       G  <       G  >       G  B       G  E       G  G       G  K       G  P       G  T       G  V          G  X       G  X         G  Y       G  Z       G  \       G  ]       G  _       G  _         G  `       G  a       G  c       G  d       G  h       G  i       G  j       G  k       G  m       G  m         G  n       G  o       G  q       G  r       G  u       G  v       G  x       G  y       G  z       G  {            !                             	 
                                 
                ;                                   ;                        +            +                       ;               !         +     %      +     ,      ;     3         U         ;  U   V      ;     X      ;     _      +     e     �?;     m      6               �     =           =           W              Q               Q              A  !   "          =     #   "   A  !   &       %   =     '   &   A  !   )          =     *   )   A  !   -       ,   =     .   -        1         .   A  !   4   3   ,   =     5   4   �     9   #   *   �     <   #   *        >      1   9   <      �     B   '   *   �     E   '   *        G      1   B   E      �     K   .   *        P      1   K   <           T      .   P   G   1   =     Y   X   �     Z   Y   >   A  !   [   3      =     \   [   �     ]   Z   \   =     `   _   �     a   `   G   A  !   b   3   %   =     c   b   �     d   a   c   �     h   >   5   �     i   e   h   �     j   d   i   �     k   ]   j   =     n   m   �     o   n   T   A  !   p   3      =     q   p   �     r   o   q   �     u   G   >        v      %   e   u   �     x   v   5   �     y   e   x   �     z   r   y   �     {   k   z   >  V   {   �  8  �
+
vs_uniforms��������#  Y* 0 8 @ PX@D
texture_sampler�랦���
  *texture_sampler0�랦���8@ P"8
positionƫ����ĭ�  _*position0ƫ����ĭ�8 @ P":
	texcoord0����ۜ���  *	texcoord00����ۜ���8 @P":

sdf_params�����Ĳb  <*
sdf_params0�����Ĳb8 @P":

face_colorϛ����  *
face_color0ϛ����8 @P"@
outline_color����͛��E  "*outline_color0����͛��E8 @P"@
shadow_color��񊥨ϸ�  /*shadow_color0��񊥨ϸ�8 @P"<

layer_mask��Çت��  @*
layer_mask0��Çت��8 @P"@
var_texcoord0�������  *var_texcoord00�������8 @ P"D
var_face_color໫𺙫��  X*var_face_color0໫𺙫��8 @P"H
var_outline_color���ϲ��X  _*var_outline_color0���ϲ��X8 @P"F
var_shadow_color��������F  m*var_shadow_color0��������F8 @P"D
var_sdf_params���񞯢��   *var_sdf_params0���񞯢��8 @P"D
var_layer_mask�ڤ�ʼ���  3*var_layer_mask0�ڤ�ʼ���8 @P*@
var_texcoord0�������  	*var_texcoord00�������8 @ P*D
var_face_color໫𺙫��  *var_face_color0໫𺙫��8 @P*H
var_outline_color���ϲ��X  !*var_outline_color0���ϲ��X8 @P*F
var_shadow_color��������F  .*var_shadow_color0��������F8 @P*D
var_sdf_params���񞯢��  ;*var_sdf_params0���񞯢��8 @P*D
var_layer_mask�ڤ�ʼ���  >*var_layer_mask0�ڤ�ʼ���8 @P*B
out_fragColor�������  V*out_fragColor0�������8 @ P28
vs_uniforms��������#
	view_proj���̤�	  ( 