Shader "Custom/air_cm_effect" {
	Properties{
	//テクスチャ格納用の変数（sampler2D型の_MainTex変数）
	//公開する変数名が_MainTex、インスペクタ上の表示がTexture、型名が2D、初期値が"white"
		_MainTex("Texture", 2D) = "white"{}
        _Transparent ("Transparent", Range(0,1) ) = 0.0
        _Xspeed ("Xspeed", Range(0,10) ) = 0.0
        _Yspeed ("Xspeed", Range(0,10) ) = 0.0
	}
	SubShader {
		Tags { "Queue"="Transparent" }
		LOD 200
		Cull off
		
		CGPROGRAM
		//alpha:fade で半透明にする
        #pragma surface surf Standard alpha:fade fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;
        half _Transparent;
        half _Xspeed;
        half _Yspeed;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
            o.Alpha = _Transparent;

		    fixed2 uv = IN.uv_MainTex;
		    uv.x += _Xspeed * _Time;
		    uv.y += _Yspeed * _Time;
		    o.Albedo = tex2D (_MainTex, uv);

		}
		ENDCG
	}
	FallBack "Diffuse"
}