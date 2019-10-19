using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EpicWarCL
{
    class Functions
    {
        public static void initShips(float [] x, float [] y, byte [] states, float xMax, float yMax,float [] rotations,byte [] teams)
        {
            Random r = new Random();
            for(int i=0;i<x.Length;i++)
            {
                x[i] =((float) r.NextDouble())*xMax;
                y[i] =((float) r.NextDouble())*yMax;
                states[i] = 0;
                rotations[i] = (float)(r.NextDouble()*360.0);
                teams[i] = (byte) r.Next(0, 3);

            }
        }

        public static void initLaserProjectiles(byte[] shipLaserProjectileState, float[] shipLaserProjectileX,
           float[] shipLaserProjectileY, float[] shipLaserProjectileRotation)
        {
             // 1=forward on, 2=explosion on, 4=dead
             for(int i=0;i< shipLaserProjectileState.Length;i++)
            {
                shipLaserProjectileState[i] = 4;
                shipLaserProjectileX[i] = 0;
                shipLaserProjectileY[i] = 0;
                shipLaserProjectileRotation[i] = 0;
            }
        }
    }
}
