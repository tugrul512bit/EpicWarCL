using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EpicWarCL
{
    enum HardpointType
    {
        PowerSource = 1,
        ShieldGenerator = 2,
        EnergyStorage = 3,
        Weapon = 4,
        EscapePod = 5,
        BoardingPod = 6,
        EngineBooster = 7,
        LifeSupport = 8
    }

    public class Hardpoint
    {
        /// <summary>
        /// charge value that is needed by hardpoint to work(firing projectile, generating shield, supporting crew life)
        /// </summary>
        public int chargeMax { get; set; }

        /// <summary>
        /// current hardpoint charge
        /// </summary>
        public int chargeCurrent { get; set; }

        /// <summary>
        /// energy -> charge conversion rate. consumes equal amount of energy
        /// </summary>
        public int chargeRate { get; set; }

        /// <summary>
        /// energy capacity
        /// </summary>
        public int energyMax { get; set; }

        /// <summary>
        /// current energy
        /// </summary>
        public int energyCurrent { get; set; }

        /// <summary>
        /// energy generation rate
        /// </summary>
        public int energyRate { get; set; }

        /// <summary>
        /// what hardpoint does
        /// </summary>
        public string info { get; set; }

        /// <summary>
        /// x coordinate percentage on ship bitmap
        /// </summary>
        public float x { get; set; }

        /// <summary>
        /// y coordinate percentage on ship bitmap
        /// </summary>
        public float y { get; set; }

        /// <summary>
        /// angle of center of hardpoint in polar coordinate system
        /// </summary>
        public float angle { get; set; }

        /// <summary>
        /// distance of center of hardpoint in polar coordinate system
        /// </summary>
        public float distance { get; set; }

        // from cartesian x y to polar coordinates angle
        float calculateAngle()
        {
            float result = 0;
            return result;
        }

        // from cartesian x y to polar coordinates distance
        float calculateDistance()
        {
            float result = 0;
            return result;
        }
    }
}
