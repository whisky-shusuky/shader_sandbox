Shader "Holistic/Waves" {
    //宣言
    Properties {
      //テクスチャ
      _MainTex("Diffuse", 2D) = "white" {}
      //波の数
      _Freq("Frequency", Range(0,5)) = 3
      //速度
      _Speed("Speed",Range(0,100)) = 10
      //振れ幅
      _Amp("Amplitude",Range(0,1)) = 0.5
    }
    SubShader {
      CGPROGRAM
      #pragma surface surf Lambert vertex:vert 
      
      struct Input {
          float2 uv_MainTex;
          float3 vertColor;
      };
      
      float _Freq;
      float _Speed;
      float _Amp;

      struct appdata {
          //頂点の位置
          float4 vertex: POSITION;
          //頂点の法線
          float3 normal: NORMAL;
          //UV座標1
          float4 texcoord: TEXCOORD0;
          //UV座標2
          float4 texcoord1: TEXCOORD1;
          //UV座標3
          float4 texcoord2: TEXCOORD2;
      };
      
      void vert (inout appdata v, out Input o) {
          UNITY_INITIALIZE_OUTPUT(Input,o);
          //時間 * _Speed
          float t = _Time * _Speed;
          //波の高さ = sin(頂点のx座標 * 頻度) * 振れ幅 
          float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp;
          v.vertex.y = v.vertex.y + waveHeight;
          //値が小さすぎると暗いので + 2 する
          o.vertColor = waveHeight + 2;

      }

      sampler2D _MainTex;
      void surf (Input IN, inout SurfaceOutput o) {
          //c = 読み込んだ画像情報
          float4 c = tex2D(_MainTex, IN.uv_MainTex);
          //Albedo(色情報) にvertColor を渡す。(r,g,b)の値を渡す。
          o.Albedo = c * IN.vertColor.rgb;
      }
      ENDCG

    } 
    Fallback "Diffuse"
  }