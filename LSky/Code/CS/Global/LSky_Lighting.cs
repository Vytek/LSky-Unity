﻿/////////////////////////////////////////////////
/// LSky
///----------------------------------------------
/// Lighting
///----------------------------------------------
/// Description: Lighting
/////////////////////////////////////////////////

using System;
using UnityEngine;
using Rallec.LSky.Utility;
using UnityEngine.Rendering;

namespace Rallec.LSky
{

    /// <summary></summary>
    [Serializable] public struct LSky_DirLightParams
    {

        public float intensity;
        public Color color;

        public LSky_DirLightParams(float _intensity, Color _color)
        {
            this.intensity = _intensity;
            this.color = _color;
        }
    }

    /// <summary></summary>
    [Serializable] public struct LSky_AmbientParams
    {

        public UnityEngine.Rendering.AmbientMode ambientMode;

        public float updateTime;
        public Color skyColor, equatorColor, groundColor;

        public LSky_AmbientParams(UnityEngine.Rendering.AmbientMode _ambientMode, float _updateTime, Color _skyColor, Color _equatorColor, Color _groundColor)
        {
            this.ambientMode  = _ambientMode;
            this.updateTime   = _updateTime;
            this.skyColor     = _skyColor;
            this.equatorColor = _equatorColor;
            this.groundColor  = _groundColor;
        }

    }

    /// <summary></summary>
    [Serializable] public class LSky_Ambient
    {

        [SerializeField] private LSky_AmbientParams m_AmbientParams = new LSky_AmbientParams
        {
            ambientMode  = UnityEngine.Rendering.AmbientMode.Flat,
            updateTime   = 0.5f,
            skyColor     = Color.white,
            equatorColor = Color.white,
            groundColor  = Color.black

        };

        private float m_AmbientRefreshTimer;

        /// <summary></summary>
        public void UpdateAmbient()
        {
            RenderSettings.ambientMode = m_AmbientParams.ambientMode;

            m_AmbientRefreshTimer += Time.deltaTime;
            if(m_AmbientParams.updateTime >= m_AmbientRefreshTimer)
            {

                switch(m_AmbientParams.ambientMode)
                {
                    case UnityEngine.Rendering.AmbientMode.Flat:

                    RenderSettings.ambientSkyColor = m_AmbientParams.skyColor;

                    break;

                    case UnityEngine.Rendering.AmbientMode.Trilight:

                    RenderSettings.ambientSkyColor     = m_AmbientParams.skyColor;
                    RenderSettings.ambientEquatorColor = m_AmbientParams.equatorColor;
                    RenderSettings.ambientGroundColor  = m_AmbientParams.groundColor;

                    break;

                    case UnityEngine.Rendering.AmbientMode.Skybox:

                    DynamicGI.UpdateEnvironment(); // Is low.

                    break;

                }
                m_AmbientRefreshTimer = 0.0f;
            }
          

        }


    }

}