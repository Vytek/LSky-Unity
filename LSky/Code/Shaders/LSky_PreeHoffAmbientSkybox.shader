﻿Shader "LSky/Skybox/Preetham And Hoffman Ambient Skybox"
{
    Properties{}

    CGINCLUDE
    #undef LSKY_ENABLEMIEPHASE

    #include "UnityCG.cginc"
    #include "LSky_Include.hlsl"
    #include "LSky_PreeHoffAtmosphericScatteringCommon.hlsl" 

    struct appdata
    {
        float4 vertex : POSITION;
        UNITY_VERTEX_INPUT_INSTANCE_ID
    };

    struct v2f
    {
        float3 nvertex : TEXCOORD0; 
        half3 scatter  : TEXCOORD1;
        float4 vertex  : SV_POSITION;
        UNITY_VERTEX_OUTPUT_STEREO
    };
    
    v2f vert(appdata v)
    {
        v2f o;
        UNITY_INITIALIZE_OUTPUT(v2f, o);

        UNITY_SETUP_INSTANCE_ID(v);
        UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

        o.vertex = UnityObjectToClipPos(v.vertex);
        o.nvertex = normalize(v.vertex.xyz);

        const fixed _one = 1.0; fixed3 _mp;
        o.scatter.rgb = RenderAtmosphere(o.nvertex.xyz, _mp, _mp, _one, _one);
        o.scatter.rgb = ApplyGroundColor(o.nvertex.y, o.scatter.rgb);
        return o;
    }

    half4 frag(v2f i) : SV_Target
    {
        return half4(i.scatter.rgb, 1.0);
    }
    ENDCG

    SubShader
    {
        Tags{ "Queue"="Background+10" "RenderType"="Background" "PreviewType"="Skybox" }
        Pass
        {
            
            ZWrite Off
            Fog{ Mode Off }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag 
            #pragma target 2.0

            #pragma multi_compile __ LSKY_APPLY_FAST_TONEMAP
            #pragma multi_compile __ LSKY_PER_PIXEL_ATMOSPHERE
            #pragma multi_compile __ LSKY_ENABLE_MOON_RAYLEIGH
            ENDCG
        }
    }

}