Shader "Custom/air_cm" {
	Properties{
	//テクスチャ格納用の変数（sampler2D型の_MainTex変数）
	//公開する変数名が_MainTex、インスペクタ上の表示がTexture、型名が2D、初期値が"white"
		_MainTex("Texture", 2D) = "white"{}
        _Transparent ("Transparent", Range(0,1) ) = 0.0
//		_MaskTex ("Mask Texture", 2D) = "white" {}
	}
	SubShader {
		Tags { "Queue"="Transparent" }
		LOD 200
		Cull off
		
		CGPROGRAM
		//alpha:fade で半透明にする
        #pragma surface surf Standard alpha:fade
		#pragma target 3.0

		sampler2D _MainTex;
        half _Transparent;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutputStandard o) {
		    fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c;
            o.Alpha = _Transparent;
		}
		ENDCG
	}
	FallBack "Diffuse"
}