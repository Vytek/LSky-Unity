﻿Shader "LSky/Deep Space/LDR/Stars Field"
{

    //Properties{}
    CGINCLUDE
    #include "UnityCG.cginc"
    #include "LSky_Include.hlsl"
    #include "LSky_DeepSpaceCommon.hlsl"
    ENDCG

    SubShader
    {
        Tags{ "Queue"="Background+10" "RenderType"="Background" "IgnoreProjector"= "true" }

        Pass
        {
            Cull Front
            ZWrite Off
            ZTest Lequal
            Blend One One
            Fog{ Mode Off }

            CGPROGRAM
            
            #pragma vertex vert_sf
            #pragma fragment frag_sf
            #pragma target 2.0

            ENDCG
        }
    }

}