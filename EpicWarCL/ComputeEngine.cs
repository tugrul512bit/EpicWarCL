using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Cekirdekler;
using Cekirdekler.ClArrays;
using System.Drawing;
using System.Runtime.InteropServices;
using System.Drawing.Imaging;
using Cekirdekler.Hardware;
using System.IO;
using Cekirdekler.Pipeline.Pool;
using System.Windows.Forms;
using System.Diagnostics;
using System.Threading;

namespace EpicWarCL
{
   class ComputeEngine
    {
        public bool details = false;
        public static int moduleTypePower = 1;
        public static int moduleTypeEnergy = 2;
        public static int moduleTypeShield = 4;
        public static int moduleTypeTurret = 8;
        public static int moduleTypeTurretTurbo = 3; // low damage high rate of fire


        int localSize = 64; // kernel workgroup size
        int renderWidth = 1280 + 512; // must be multiple of 64
        int renderHeight = 512 + 512;



        public ClArray<T> createCustomBufferOnGPU<T>(int size)
        {
            ClArray<T> newArray = new ClArray<T>(size);
            newArray.partialRead = false;
            newArray.read = false;
            newArray.write = false;
            newArray.writeAll = false;
            return newArray;
        }

        public ClArray<float> getFloatParametersGPU()
        {
            return parametersFloatGPU;
        }

        public ClArray<float> getShipXBufferGPU()
        {
            return shipXGPU;
        }

        public ClArray<float> getShipYBufferGPU()
        {
            return shipYGPU;
        }

        public ClArray<float> getShipXOldBufferGPU()
        {
            return shipXOldGPU;
        }

        public ClArray<float> getShipYOldBufferGPU()
        {
            return shipYOldGPU;
        }

        public ClArray<byte> getShipTeamBufferGPU()
        {
            return shipTeamGPU;
        }

        public ClArray<byte> getShipSizeTypeBufferGPU()
        {
            return shipSizeTypeGPU;
        }

        public ClArray<byte> getShipModuleTypeBufferGPU()
        {
            return shipModuleTypeGPU;
        }

        public ClArray<int> getShipModuleEnergyBufferGPU()
        {
            return shipModuleEnergyGPU;
        }

        public ClArray<byte> getShipModuleHPBufferGPU()
        {
            return shipModuleHPGPU;
        }

        public ClArray<byte> getShipModuleHPMaxBufferGPU()
        {
            return shipModuleHPMaxGPU;
        }

        public ClArray<byte> getShipModuleStateBufferGPU()
        {
            return shipModuleStateGPU;
        }


        public ClArray<int> getShipModuleWeightBufferGPU()
        {
            return shipModuleWeightGPU;
        }

        public ClArray<int> getShipShieldBufferGPU()
        {
            return shipShieldsGPU;
        }

        public ClArray<int> getShipShieldMaxBufferGPU()
        {
            return shipShieldsMaxGPU;
        }

        public ClArray<int> getRandBufferGPU()
        {
            return randSeedGPU;
        }

        public ClArray<int> getShipHpBufferGPU()
        {
            return shipHitPointsGPU;
        }

        public ClArray<int> getShipHpMaxBufferGPU()
        {
            return shipHitPointsMaxGPU;
        }

        public ClArray<float> getShipTargetXGPU()
        {
            return shipTargetXGPU;
        }

        public ClArray<float> getShipTargetYGPU()
        {
            return shipTargetYGPU;
        }

        public ClArray<int> getShipSelectedGPU()
        {
            return shipSelectedGPU;
        }

        public ClArray<int> getShipTargetShipGPU()
        {
            return shipTargetShipGPU;
        }


        public ClArray<byte> getShipStateBufferGPU()
        {
            return shipStateGPU;
        }


        public ClArray<float> getShipRotationBufferGPU()
        {
            return shipRotationGPU;
        }
        


        public ClArray<int> getShipModuleEnergyMaxBufferGPU()
        {
            return shipModuleEnergyMaxGPU;
        }


        public ClArray<int> getIntParametersGPU()
        {
            return parametersIntGPU;
        }

        public ClArray<float> getFrameTimeBufferGPU()
        {
            return engineFrameTimeGPU;
        }


       

        int customTaskUniqueId = 240000000;
        public ClTask createCustomTask(ClParameterGroup gpuArraysAsParameters, string kernelName, int workitems, int localWorkitems)
        {
            customTaskUniqueId++;
            return gpuArraysAsParameters.task(customTaskUniqueId, kernelName, workitems, localWorkitems);
        }

        public ClTask createCustomTask(IBufferOptimization gpuArraysAsParameters, string kernelName, int workitems, int localWorkitems)
        {
            customTaskUniqueId++;
            return (gpuArraysAsParameters as ICanCompute).task(customTaskUniqueId, kernelName, workitems, localWorkitems);
        }


        List<ClTask> customTaskList = new List<ClTask>();

        ClTask[] customTaskArray { get; set; }
        /// <summary>
        /// runs after float/int parameter kernels
        /// </summary>
        /// <param name="task"></param>
        public void insertCustomTaskIntoPipeline(ClTask task)
        {
            customTaskList.Add(task);
        }

        /// <summary>
        /// makes all custom tasks ready to compute, can't add new tasks after this
        /// </summary>
        public void initCustomTaskArray()
        {
            customTaskArray = customTaskList.ToArray();
        }

        public void setRenderWidth(int rw)
        {
            renderWidth = rw;
        }

        public void setRenderHeight(int rh)
        {
            renderHeight = rh;
        }

        public int getRenderWidth()
        {
            return renderWidth ;
        }

        public int getRenderHeight()
        {
            return renderHeight ;
        }

        int nShip = 1024 * (64);// must be power of 2
        const int nShipModules = 10;  // max modules at a time, per ship
        const int nShipProjectiles = 55; // 55 max projectiles at a time, per ship
        const int nShipCrew = 40; // 40
        const int projectileLife = 100; // simulation steps
        const int projectileExplosionLife = 10; // min exploding projectile simulation steps (+ random in kernel)
        const int shipExplosionLife = 67; // ship explosion simulation steps
        int renderPatchSizeShip = 256; // nvidia needs 8x8
        int renderPatchSizeProjectile =256;
        int renderPatchSizeShipSqrt = 16;
        int renderPatchSizeProjectileSqrt = 16;
        int mapWidth = (14336); // for 64k ships
        int mapHeight = (14336);
        const int shipSize = 10;
        const int shieldDistance = 8;
        const int projectileSize = 1;
        int searchBoxSize = /*16*/64; // must be power of 2, integer square
        int nBox = 0; // for 64k ships
        const int projectileSearchBoxSize = /*8*/32;// must be power of 2
        const int maxShipsPerBox = 22;
        const int maxProjectilesPerBox = 52; // 52
        bool texturePipelineState = false;

        public bool getTexturePipelineState()
        {
            return texturePipelineState;
        }



        ClNumberCruncher cr { get; set; }
        public BitmapData bmpData = null;
        public BitmapData bmpDataOld = null;
        public Bitmap texture { get; set; }
        public Bitmap textureOld { get; set; }
        int numBytes { get; set; }

        byte[] skyBitmapBytes { get; set; }
        byte[] shipCorvetteBitmapBytes { get; set; }
        byte[] projectileBitmapBytes { get; set; }
        byte[] captainRankBytes { get; set; }
        byte[] textureBuf { get; set; }
        byte[] textureBuf2 { get; set; } // for double buffering / pipelining(copy + rotate)
        byte[] textureBufC2 { get; set; }
        byte[] textureBuf2C2 { get; set; } // for double buffering / pipelining(copy + rotate)
        byte[] textureBufTmp { get; set; } // for post processing
        float[] textureLightBufR { get; set; }
        float[] textureLightBufG { get; set; }
        float[] textureLightBufB { get; set; }
        byte[] pixelUsed { get; set; }

        int[] shipHitPoints { get; set; }
        int[] shipHitPointsMax { get; set; }
        int[] findEnemyHintW { get; set; }
        int[] findEnemyHintH { get; set; }
        int[] shipShields { get; set; }
        int[] shipShieldsMax { get; set; }
        int[] shipShieldRecharge { get; set; }


        int[] shipCountReductionStep { get; set; }

        int[] shipCount0Ping { get; set; }
        int[] shipCount0Pong { get; set; }

        int[] shipCount1Ping { get; set; }
        int[] shipCount1Pong { get; set; }

        int[] shipCount2Ping { get; set; }
        int[] shipCount2Pong { get; set; }

        byte[] shipTeam { get; set; } // 0=red team, 1=blue team, 2=green team
        int[] shipShieldDamaged { get; set; } // e>0: damaged
        float[] shipX { get; set; }
        float[] shipTargetX { get; set; }
        float[] shipTargetY { get; set; }
        int[] shipCommand { get; set; }
        float[] shipXOld { get; set; }
        float[] shipXTmp { get; set; }
        float[] shipX2Tmp { get; set; }
        float[] shipY { get; set; }
        float[] shipYOld { get; set; }
        float[] shipYTmp { get; set; }
        float[] shipY2Tmp { get; set; }



        float[] shipFrontX { get; set; }
        float[] shipFrontY { get; set; }

        float[] shipRotation { get; set; }
        byte[] shipState { get; set; }// 1=forward on, 2=rotate left on, 4=rotate right on, 8=dead
        byte[] shipSizeType { get; set; } // 0=corvette, 1=frigate, 2=destroyer, 9=cruiser, 10=battleship

        byte[] shipWeaponCharge { get; set; }

        byte[] shipLaserProjectileState { get; set; }// 1=forward on, 2=explosion on, 4=dead
        byte[] shipLaserProjectileLife { get; set; } // 0 - 100: projectile flight, 101-190: explosion, 191: dead
        float[] shipLaserProjectileX { get; set; }
        byte[] projectileCritExplosion { get; set; }
        int[] projectileEvadedShipId { get; set; }
        float[] shipLaserProjectileY { get; set; }
        float[] shipLaserProjectileRotation { get; set; }
        byte[] projectileDamage { get; set; }



        int[] shipSelected { get; set; }
        int[] randSeed { get; set; }

        int[] shipSearchBox { get; set; }
        int[] shipSearchBoxRender { get; set; }
        int[] projectileSearchBox { get; set; }

        byte[] shipModuleType { get; set; }
        int[] shipModuleEnergy { get; set; }
        byte[] shipModuleHP { get; set; }
        byte[] shipModuleHPMax { get; set; }
        int[] shipModuleEnergyMax { get; set; }
        int[] shipModuleWeight { get; set; }
        byte[] shipModuleState { get; set; }
        int[] shipModuleShieldDamaged { get; set; }
        float[] shipModuleX { get; set; }
        float[] shipModuleY { get; set; }
        int[] shipTargetShip { get; set; }
        byte[] crewData { get; set; }
        int[] crewExperience { get; set; }
        byte[] crewLevel { get; set; }
        byte[] crewEvasionSkillLevel { get; set; }
        byte[] crewTacticalCriticalHitSkillLevel { get; set; }
        byte[] crewFastLearningSkillLevel { get; set; }
        int[] crewShipId { get; set; }
        byte[] crewHp { get; set; }
        byte[] crewTempHp { get; set; }

        ClArray<byte> skyBitmapBytesGPU { get; set; }
        ClArray<byte> captainRankBytesGPU { get; set; }
        ClArray<byte> shipCorvetteBitmapBytesGPU { get; set; }
        ClArray<byte> projectileBitmapBytesGPU { get; set; }

        ClArray<byte> shipModuleTypeGPU { get; set; }
        ClArray<int> shipModuleEnergyGPU { get; set; }
        ClArray<byte> shipModuleHPGPU { get; set; }
        ClArray<byte> shipModuleHPMaxGPU { get; set; }
        ClArray<int> shipModuleEnergyMaxGPU { get; set; }
        ClArray<int> shipModuleWeightGPU { get; set; }
        ClArray<byte> shipModuleStateGPU { get; set; }
        ClArray<int> shipModuleShieldDamagedGPU { get; set; }

        

        ClArray<byte> crewDataGPU { get; set; }
        ClArray<int> crewExperienceGPU { get; set; }
        ClArray<byte> crewLevelGPU { get; set; }
        ClArray<byte> crewEvasionSkillLevelGPU { get; set; }
        ClArray<byte> crewTacticalCriticalHitSkillLevelGPU { get; set; }
        ClArray<byte> crewFastLearningSkillLevelGPU { get; set; }
        ClArray<int> crewShipIdGPU { get; set; }
        ClArray<byte> crewHpGPU { get; set; }
        ClArray<byte> crewTempHpGPU { get; set; }
        public ClArray<int> crewLevelHistogramGPU { get; set; }
        public ClArray<int> crewLevelHistogramC2GPU { get; set; }

        ClArray<float> shipModuleXGPU { get; set; }
        ClArray<float> shipModuleYGPU { get; set; }




        ClArray<int> shipHitPointsGPU { get; set; }
        ClArray<int> shipHitPointsMaxGPU { get; set; }
        ClArray<int> findEnemyHintWGPU { get; set; }
        ClArray<int> findEnemyHintHGPU { get; set; }


        ClArray<int> shipShieldsGPU { get; set; }
        ClArray<int> shipShieldRechargeGPU { get; set; }

        ClArray<int> shipShieldsMaxGPU { get; set; }

        public ClArray<int> numberOfShipsGPU = new ClArray<int>(4096);
        public ClArray<int> numberOfShipsC2GPU = new ClArray<int>(4096);
        ClArray<int> shipCountReductionStepGPU { get; set; }
        ClArray<int> shipCount0PingGPU { get; set; }
        ClArray<int> shipCount0PongGPU { get; set; }

        ClArray<int> shipCount1PingGPU { get; set; }
        ClArray<int> shipCount1PongGPU { get; set; }

        ClArray<int> shipCount2PingGPU { get; set; }
        ClArray<int> shipCount2PongGPU { get; set; }

        ClArray<byte> textureBufGPU { get; set; }
        ClArray<byte> textureBufC2GPU { get; set; }
        ClArray<byte> textureBuf2GPU { get; set; }
        ClArray<byte> textureBuf2C2GPU { get; set; }
        ClArray<byte> textureBufTmpGPU { get; set; }
        ClArray<byte> textureBufTmpC2GPU { get; set; }
        ClArray<float> textureLightBufRGPU { get; set; }
        ClArray<float> textureLightBufGGPU { get; set; }
        ClArray<float> textureLightBufBGPU { get; set; }
        ClArray<byte> pixelUsedGPU { get; set; }
        ClArray<int> shipSearchBoxGPU { get; set; }
        ClArray<int> shipSearchBoxRenderGPU { get; set; }

        ClArray<int> projectileSearchBoxGPU { get; set; }
        ClArray<byte> shipTeamGPU { get; set; }
        ClArray<int> shipShieldDamagedGPU { get; set; }
        ClArray<float> shipXGPU { get; set; }
        ClArray<float> shipTargetXGPU { get; set; }
        ClArray<float> shipTargetYGPU { get; set; } // c# arr <--- c++ arr 
        ClArray<int> shipCommandGPU { get; set; }


        ClArray<float> shipXOldGPU { get; set; }
        ClArray<float> shipXTmpGPU { get; set; }
        ClArray<float> shipXTmp2GPU { get; set; }
        ClArray<float> shipYGPU { get; set; }
        ClArray<float> shipYOldGPU { get; set; }
        ClArray<float> shipYTmpGPU { get; set; }
        ClArray<float> shipYTmp2GPU { get; set; }
        ClArray<float> shipFrontXGPU { get; set; }
        ClArray<float> shipFrontYGPU { get; set; }
        ClArray<float> shipRotationGPU { get; set; }
        ClArray<byte> shipStateGPU { get; set; }
        ClArray<byte> shipSizeTypeGPU { get; set; }

        ClArray<byte> shipWeaponChargeGPU { get; set; }

        ClArray<byte> shipLaserProjectileStateGPU { get; set; }
        ClArray<float> shipLaserProjectileXGPU { get; set; }
        ClArray<byte> projectileCritExplosionGPU { get; set; }
        ClArray<int> projectileEvadedShipIdGPU { get; set; }
        ClArray<float> shipLaserProjectileYGPU { get; set; }
        ClArray<float> shipLaserProjectileRotationGPU { get; set; }
        ClArray<byte> projectileDamageGPU { get; set; }

        ClArray<byte> shipLaserProjectileLifeGPU { get; set; }

        public ClArray<int> parametersIntGPU = new ClArray<int>(4096);
        public ClArray<float> parametersFloatGPU = new ClArray<float>(4096);
        public ClArray<float> engineFrameTimeGPU = new ClArray<float>(4096);
        public ClArray<float> userInterfaceGPU = new ClArray<float>(1024);
        public ClArray<float> userInterface2GPU = new ClArray<float>(1024);


        ClArray<float> rightClickXYGPU = new ClArray<float>(4096);
        ClArray<int> userCommandGPU = new ClArray<int>(4096);

        ClArray<int> randSeedGPU { get; set; }
        ClArray<int> shipSelectedGPU { get; set; }
        ClArray<int> shipTargetShipGPU { get; set; }
        
        int skyWidth = 4800;
        int skyHeight = 2700;
        ClParameterGroup[] arraysToCompute = new ClParameterGroup[3000];


        // all ascii chars 12x16 representations
        byte[] getCharListBitmapBytes()
        {
            // char width: 12, height: 16, colors: rgba, chars: 256
            byte[] result = new byte[256 * 12 * 16 * 4];
            Bitmap bmpChar = new Bitmap(12, 16, PixelFormat.Format32bppPArgb);

            FontFamily fontFamily = FontFamily.GenericMonospace;
            Font font = new Font(
               fontFamily,
               12,
               FontStyle.Bold,
               GraphicsUnit.Pixel);
            Graphics g = Graphics.FromImage(bmpChar);

            for (int i = 0; i < 256; i++)
            {
                char c =(char) (('A'-65)+i);
                g.Clear(Color.Black);
                g.DrawString(c.ToString(), font, Brushes.Red, 0, 0);
                g.Flush();
                BitmapData bmpData0 = bmpChar.LockBits(new Rectangle(0, 0, 12, 16), ImageLockMode.ReadWrite, PixelFormat.Format32bppPArgb);
                IntPtr ptr0 = bmpData0.Scan0;
                byte[] tmp0 = new byte[12 * 16 * 4];
                Marshal.Copy(ptr0, tmp0, 0, 12 * 16 * 4);
                for(int j=0;j< 12 * 16 * 4;j++)
                {
                    result[i * 12 * 16 * 4 + j] = tmp0[j];
                }
                bmpChar.UnlockBits(bmpData0);
            }
            return result;
        }
        byte[] charBytes = null;
        ClArray<byte> charBytesGPU { get; set; }
        public ComputeEngine()
        {

            nBox = ((14336 / searchBoxSize) * (14336 / searchBoxSize));

            // 3 teams, 3 types = 16800 elements -> 50400 bytes
            shipCorvetteBitmapBytes = new byte[1000000];
            projectileBitmapBytes = new byte[1000];
            skyBitmapBytes = new byte[4800 * 2700 * 4];
            captainRankBytes = new byte[40 * 10 * 10 * 4]; // 40 rank
            for (int i = 0; i < 1000; i++)
            {
                projectileBitmapBytes[i] = 0;
            }
            for (int i = 0; i < 100000; i++)
                shipCorvetteBitmapBytes[i] = 0;

            int pixelCtr = 0;
            Image shipPic = Image.FromFile("img/ship_corvette_r.png");
            Bitmap bmpShip = (Bitmap)shipPic;
            var lockedBits = bmpShip.LockBits(new Rectangle(0, 0, 20, 20), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            IntPtr ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, shipCorvetteBitmapBytes, pixelCtr, (20 * 20) * 4);
            bmpShip.UnlockBits(lockedBits);
            pixelCtr += (20 * 20) * 4;

            shipPic = Image.FromFile("img/ship_frigate_r.png");
            bmpShip = (Bitmap)shipPic;
            lockedBits = bmpShip.LockBits(new Rectangle(0, 0, 40, 40), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, shipCorvetteBitmapBytes, pixelCtr, (40 * 40) * 4);
            bmpShip.UnlockBits(lockedBits);
            pixelCtr += (40 * 40) * 4;

            shipPic = Image.FromFile("img/ship_destroyer_r.png");
            bmpShip = (Bitmap)shipPic;
            lockedBits = bmpShip.LockBits(new Rectangle(0, 0, 60, 60), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, shipCorvetteBitmapBytes, pixelCtr, (60 * 60) * 4);
            bmpShip.UnlockBits(lockedBits);
            pixelCtr += (60 * 60) * 4;

            shipPic = Image.FromFile("img/ship_cruiser_r.png");
            bmpShip = (Bitmap)shipPic;
            lockedBits = bmpShip.LockBits(new Rectangle(0, 0, 80, 80), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, shipCorvetteBitmapBytes, pixelCtr, (80 * 80) * 4);
            bmpShip.UnlockBits(lockedBits);
            pixelCtr += (80 * 80) * 4;

            shipPic = Image.FromFile("img/ship_corvette_g.png");
            bmpShip = (Bitmap)shipPic;
            lockedBits = bmpShip.LockBits(new Rectangle(0, 0, 20, 20), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, shipCorvetteBitmapBytes, pixelCtr, (20 * 20) * 4);
            bmpShip.UnlockBits(lockedBits);
            pixelCtr += (20 * 20) * 4;

            shipPic = Image.FromFile("img/ship_frigate_g.png");
            bmpShip = (Bitmap)shipPic;
            lockedBits = bmpShip.LockBits(new Rectangle(0, 0, 40, 40), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, shipCorvetteBitmapBytes, pixelCtr, (40 * 40) * 4);
            bmpShip.UnlockBits(lockedBits);
            pixelCtr += (40 * 40) * 4;

            shipPic = Image.FromFile("img/ship_destroyer_g.png");
            bmpShip = (Bitmap)shipPic;
            lockedBits = bmpShip.LockBits(new Rectangle(0, 0, 60, 60), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, shipCorvetteBitmapBytes, pixelCtr, (60 * 60) * 4);
            bmpShip.UnlockBits(lockedBits);
            pixelCtr += (60 * 60) * 4;

            shipPic = Image.FromFile("img/ship_cruiser_g.png");
            bmpShip = (Bitmap)shipPic;
            lockedBits = bmpShip.LockBits(new Rectangle(0, 0, 80, 80), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, shipCorvetteBitmapBytes, pixelCtr, (80 * 80) * 4);
            bmpShip.UnlockBits(lockedBits);
            pixelCtr += (80 * 80) * 4;

            shipPic = Image.FromFile("img/ship_corvette_b.png");
            bmpShip = (Bitmap)shipPic;
            lockedBits = bmpShip.LockBits(new Rectangle(0, 0, 20, 20), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, shipCorvetteBitmapBytes, pixelCtr, (20 * 20) * 4);
            bmpShip.UnlockBits(lockedBits);
            pixelCtr += (20 * 20) * 4;

            shipPic = Image.FromFile("img/ship_frigate_b.png");
            bmpShip = (Bitmap)shipPic;
            lockedBits = bmpShip.LockBits(new Rectangle(0, 0, 40, 40), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, shipCorvetteBitmapBytes, pixelCtr, (40 * 40) * 4);
            bmpShip.UnlockBits(lockedBits);
            pixelCtr += (40 * 40) * 4;

            shipPic = Image.FromFile("img/ship_destroyer_b.png");
            bmpShip = (Bitmap)shipPic;
            lockedBits = bmpShip.LockBits(new Rectangle(0, 0, 60, 60), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, shipCorvetteBitmapBytes, pixelCtr, (60 * 60) * 4);
            bmpShip.UnlockBits(lockedBits);
            pixelCtr += (60 * 60) * 4;

            shipPic = Image.FromFile("img/ship_cruiser_b.png");
            bmpShip = (Bitmap)shipPic;
            lockedBits = bmpShip.LockBits(new Rectangle(0, 0, 80, 80), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, shipCorvetteBitmapBytes, pixelCtr, (80 * 80) * 4);
            bmpShip.UnlockBits(lockedBits);
            pixelCtr += (80 * 80) * 4;

            Console.WriteLine("pixelCtr=" + pixelCtr);

            Image projectilePic = Image.FromFile("img/projectile_r.png");
            Bitmap bmpProjectile = (Bitmap)projectilePic;
            lockedBits = bmpProjectile.LockBits(new Rectangle(0, 0, 3, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, projectileBitmapBytes, 0, (3 * 10) * 4);
            bmpProjectile.UnlockBits(lockedBits);

            projectilePic = Image.FromFile("img/projectile_g.png");
            bmpProjectile = (Bitmap)projectilePic;
            lockedBits = bmpProjectile.LockBits(new Rectangle(0, 0, 3, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, projectileBitmapBytes, 120, (3 * 10) * 4);
            bmpProjectile.UnlockBits(lockedBits);

            projectilePic = Image.FromFile("img/projectile_b.png");
            bmpProjectile = (Bitmap)projectilePic;
            lockedBits = bmpProjectile.LockBits(new Rectangle(0, 0, 3, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, projectileBitmapBytes, 240, (3 * 10) * 4);
            bmpProjectile.UnlockBits(lockedBits);

            Image skyPic = Image.FromFile("img/sky.png");
            Bitmap bmpSky = (Bitmap)skyPic;
            lockedBits = bmpSky.LockBits(new Rectangle(0, 0, 4800, 2700), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, skyBitmapBytes, 0, (4800 * 2700) * 4);
            bmpSky.UnlockBits(lockedBits);

            Image captainRankPic = Image.FromFile("img/captain_rank_1.png");
            Bitmap bmpCaptainRank = (Bitmap)captainRankPic;
            lockedBits = bmpCaptainRank.LockBits(new Rectangle(0, 0, 10, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, captainRankBytes, 0, (10 * 10) * 4);
            bmpCaptainRank.UnlockBits(lockedBits);

            captainRankPic = Image.FromFile("img/captain_rank_2.png");
            bmpCaptainRank = (Bitmap)captainRankPic;
            lockedBits = bmpCaptainRank.LockBits(new Rectangle(0, 0, 10, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, captainRankBytes, (10 * 10) * 4, (10 * 10) * 4);
            bmpCaptainRank.UnlockBits(lockedBits);

            captainRankPic = Image.FromFile("img/captain_rank_3.png");
            bmpCaptainRank = (Bitmap)captainRankPic;
            lockedBits = bmpCaptainRank.LockBits(new Rectangle(0, 0, 10, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, captainRankBytes, (10 * 10) * 4 * 2, (10 * 10) * 4);
            bmpCaptainRank.UnlockBits(lockedBits);

            captainRankPic = Image.FromFile("img/captain_rank_4.png");
            bmpCaptainRank = (Bitmap)captainRankPic;
            lockedBits = bmpCaptainRank.LockBits(new Rectangle(0, 0, 10, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, captainRankBytes, (10 * 10) * 4 * 3, (10 * 10) * 4);
            bmpCaptainRank.UnlockBits(lockedBits);


            captainRankPic = Image.FromFile("img/captain_rank_5.png");
            bmpCaptainRank = (Bitmap)captainRankPic;
            lockedBits = bmpCaptainRank.LockBits(new Rectangle(0, 0, 10, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, captainRankBytes, (10 * 10) * 4 * 4, (10 * 10) * 4);
            bmpCaptainRank.UnlockBits(lockedBits);

            captainRankPic = Image.FromFile("img/captain_rank_6.png");
            bmpCaptainRank = (Bitmap)captainRankPic;
            lockedBits = bmpCaptainRank.LockBits(new Rectangle(0, 0, 10, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, captainRankBytes, (10 * 10) * 4 * 5, (10 * 10) * 4);
            bmpCaptainRank.UnlockBits(lockedBits);

            captainRankPic = Image.FromFile("img/captain_rank_7.png");
            bmpCaptainRank = (Bitmap)captainRankPic;
            lockedBits = bmpCaptainRank.LockBits(new Rectangle(0, 0, 10, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, captainRankBytes, (10 * 10) * 4 * 6, (10 * 10) * 4);
            bmpCaptainRank.UnlockBits(lockedBits);

            captainRankPic = Image.FromFile("img/captain_rank_8.png");
            bmpCaptainRank = (Bitmap)captainRankPic;
            lockedBits = bmpCaptainRank.LockBits(new Rectangle(0, 0, 10, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, captainRankBytes, (10 * 10) * 4 * 7, (10 * 10) * 4);
            bmpCaptainRank.UnlockBits(lockedBits);

            captainRankPic = Image.FromFile("img/captain_rank_9.png");
            bmpCaptainRank = (Bitmap)captainRankPic;
            lockedBits = bmpCaptainRank.LockBits(new Rectangle(0, 0, 10, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, captainRankBytes, (10 * 10) * 4 * 8, (10 * 10) * 4);
            bmpCaptainRank.UnlockBits(lockedBits);


            captainRankPic = Image.FromFile("img/captain_rank_10.png");
            bmpCaptainRank = (Bitmap)captainRankPic;
            lockedBits = bmpCaptainRank.LockBits(new Rectangle(0, 0, 10, 10), ImageLockMode.ReadOnly, PixelFormat.Format32bppArgb);
            ptr0 = lockedBits.Scan0;
            Marshal.Copy(ptr0, captainRankBytes, (10 * 10) * 4 * 9, (10 * 10) * 4);
            bmpCaptainRank.UnlockBits(lockedBits);

            charBytes = getCharListBitmapBytes();
            charBytesGPU = charBytes;

            charBytesGPU.write = false;

            shipCorvetteBitmapBytesGPU = shipCorvetteBitmapBytes;
            shipCorvetteBitmapBytesGPU.write = false;

            projectileBitmapBytesGPU = projectileBitmapBytes;
            projectileBitmapBytesGPU.write = false;

            skyBitmapBytesGPU = skyBitmapBytes;
            skyBitmapBytesGPU.write = false;

            captainRankBytesGPU = captainRankBytes;
            captainRankBytesGPU.write = false;

        }

        public void allocateArrays()
        {

            shipModuleType = new byte[nShip * nShipModules];
            shipModuleEnergy = new int[nShip * nShipModules];
            shipModuleHP = new byte[nShip * nShipModules];
            shipModuleHPMax = new byte[nShip * nShipModules];
            shipModuleEnergyMax = new int[nShip * nShipModules];
            shipModuleWeight = new int[nShip * nShipModules];
            shipModuleState = new byte[nShip * nShipModules];
            shipModuleShieldDamaged = new int[nShip * nShipModules];
            shipModuleX = new float[nShip * nShipModules];
            shipModuleY = new float[nShip * nShipModules];
            shipSelected = new int[nShip];
            shipTargetShip = new int[nShip];
            crewData = new byte[nShip * nShipCrew];
            crewExperience = new int[nShip * nShipCrew];
            crewLevel = new byte[nShip * nShipCrew];
            crewEvasionSkillLevel = new byte[nShip * nShipCrew];
            crewTacticalCriticalHitSkillLevel = new byte[nShip * nShipCrew];
            crewFastLearningSkillLevel = new byte[nShip * nShipCrew];
            crewShipId = new int[nShip * nShipCrew];
            crewHp = new byte[nShip * nShipCrew];
            crewTempHp = new byte[nShip * nShipCrew];

            shipHitPoints = new int[nShip];
            shipHitPointsMax = new int[nShip];
            findEnemyHintW = new int[nShip];
            findEnemyHintH = new int[nShip];
            shipShields = new int[nShip];
            shipShieldsMax = new int[nShip];
            shipShieldRecharge = new int[nShip];


            shipCountReductionStep = new int[4096];

            shipCount0Ping = new int[nShip];
            shipCount0Pong = new int[nShip];

            shipCount1Ping = new int[nShip];
            shipCount1Pong = new int[nShip];

            shipCount2Ping = new int[nShip];
            shipCount2Pong = new int[nShip];

            shipTeam = new byte[nShip]; // 0=red team, 1=blue team, 2=green team
            shipShieldDamaged = new int[nShip]; // e>0: damaged
            shipX = new float[nShip];
            shipTargetX = new float[nShip];
            shipTargetY = new float[nShip];
            shipCommand = new int[nShip];
            shipXOld = new float[nShip];
            shipXTmp = new float[nShip];
            shipX2Tmp = new float[nShip];
            shipY = new float[nShip];
            shipYOld = new float[nShip];
            shipYTmp = new float[nShip];
            shipY2Tmp = new float[nShip];



            shipFrontX = new float[nShip];
            shipFrontY = new float[nShip];

            shipRotation = new float[nShip];
            shipState = new byte[nShip]; // 1=forward on, 2=rotate left on, 4=rotate right on, 8=dead
            shipSizeType = new byte[nShip];
            shipWeaponCharge = new byte[nShip];

            shipLaserProjectileState = new byte[nShip * nShipProjectiles]; // 1=forward on, 2=explosion on, 4=dead
            shipLaserProjectileLife = new byte[nShip * nShipProjectiles]; // 0 - 100: projectile flight, 101-190: explosion, 191: dead
            shipLaserProjectileX = new float[nShip * nShipProjectiles];
            projectileCritExplosion = new byte[nShip * nShipProjectiles];
            projectileEvadedShipId = new int[nShip * nShipProjectiles];
            shipLaserProjectileY = new float[nShip * nShipProjectiles];
            shipLaserProjectileRotation = new float[nShip * nShipProjectiles];
            projectileDamage = new byte[nShip * nShipProjectiles];


            int maxSubCat = ((nShipProjectiles > nShipCrew) ? nShipProjectiles : (nShipCrew > nShipModules ? nShipCrew : nShipModules));
            randSeed = new int[nShip * maxSubCat * 4];

            shipSearchBox = new int[(mapWidth / searchBoxSize) * (mapHeight / searchBoxSize) * (maxShipsPerBox + 1)];
            shipSearchBoxRender = new int[(mapWidth / searchBoxSize) * (mapHeight / searchBoxSize) * (maxShipsPerBox + 1)];
            projectileSearchBox = new int[(mapWidth / projectileSearchBoxSize) * (mapHeight / projectileSearchBoxSize) * (maxProjectilesPerBox + 1)];


            shipXGPU = shipX;
            shipYGPU = shipY;
            shipXOldGPU = shipXOld;
            shipYOldGPU = shipYOld;
            shipTeamGPU = shipTeam;
            shipSizeTypeGPU = shipSizeType;
            shipModuleTypeGPU = shipModuleType;

            shipModuleEnergyGPU = shipModuleEnergy;
            shipModuleEnergyMaxGPU = shipModuleEnergyMax;

            shipModuleHPGPU = shipModuleHP;
            shipModuleHPMaxGPU = shipModuleHPMax;

            shipModuleStateGPU = shipModuleState;
            shipModuleWeightGPU = shipModuleWeight;

            shipShieldsGPU = shipShields;
            shipShieldsMaxGPU = shipShieldsMax;

            randSeedGPU = randSeed;

            shipStateGPU = shipState;

            shipRotationGPU = shipRotation;

            shipHitPointsGPU = shipHitPoints;
            shipHitPointsMaxGPU = shipHitPointsMax;

            shipTargetXGPU = shipTargetX;
            shipTargetYGPU = shipTargetY;
            shipSelectedGPU = shipSelected;
            shipTargetShipGPU = shipTargetShip;
        }

        StringBuilder customKernels = new StringBuilder(" ");
        public void addCustomKernel(string ck)
        {
            customKernels.AppendLine(new StringBuilder(ck).ToString());
        }

        int playerTeam = 0;
        public void setTeam(int team)
        {
            playerTeam = team;
        }

        public void init(int selectedDeviceId, int [] moduleId)
        {
            
            texture = new Bitmap(renderWidth, renderHeight, System.Drawing.Imaging.PixelFormat.Format32bppPArgb);
            textureOld = new Bitmap(renderWidth, renderHeight, System.Drawing.Imaging.PixelFormat.Format32bppPArgb);
            numBytes = renderWidth * renderHeight * 4;
            Console.WriteLine("render width=" + renderWidth);
            Console.WriteLine("render height=" + renderHeight);
            Console.WriteLine("map width=" + mapWidth);
            Console.WriteLine("map height=" + mapHeight);
            Console.WriteLine("search box size=" + searchBoxSize);
            Console.WriteLine("projectile search box size=" + projectileSearchBoxSize);
            Console.WriteLine("nBox=" + nBox);
            Console.WriteLine("nShip=" + nShip);
            Console.WriteLine("nShipCrew=" + nShipCrew);
            Console.WriteLine("nShipModules=" + nShipModules);
            Console.WriteLine("nShipProjectiles=" + nShipProjectiles);
            

            parametersFloatGPU[0] = 1.0f;
            parametersFloatGPU[1] = mapWidth / 2;
            parametersFloatGPU[2] = mapHeight / 2;
            ClPlatforms pltTmp = ClPlatforms.all();
            GC.Collect();
            ClDevices dvcTmp = pltTmp.gpus(false);
            GC.Collect();
            ClDevices slcTmp = dvcTmp[selectedDeviceId];
            GC.Collect();
            Console.WriteLine("Compile...");
            string strKernel = /*File.ReadAllText("opencl_kernels.cl")*/ KernelSource.gameKernels.
                Replace("@@customKernels@@", customKernels.ToString()).
                Replace("@@mapWidth@@", mapWidth.ToString()).
                Replace("@@mapHeight@@", mapHeight.ToString()).
                Replace("@@searchBoxSize@@", searchBoxSize.ToString()).
                Replace("@@nShipProjectiles@@", nShipProjectiles.ToString()).
                Replace("@@(maxShipsPerBox+1)@@", (maxShipsPerBox + 1).ToString()).
                Replace("@@(maxProjectilesPerBox+1)@@", (maxProjectilesPerBox + 1).ToString()).
                Replace("@@maxShipsPerBox@@", maxShipsPerBox.ToString()).
                Replace("@@shipSize@@", shipSize.ToString()).
                Replace("@@((mapHeight/searchBoxSize)*(mapWidth/searchBoxSize))@@", ((mapHeight / searchBoxSize) * (mapWidth / searchBoxSize)).ToString()).
                Replace("@@nShip@@", nShip.ToString()).
                Replace("@@nProjectile@@", (nShip * nShipProjectiles).ToString()).
                Replace("@@nShipBox@@", shipSearchBox.Length.ToString()).
                Replace("@@nProjectileBox@@", projectileSearchBox.Length.ToString()).
                Replace("@@projectileSearchBoxSize@@", projectileSearchBoxSize.ToString()).
                Replace("@@maxProjectilesPerBox@@", maxProjectilesPerBox.ToString()).
                Replace("@@((mapHeight/projectileSearchBoxSize)*(mapWidth/projectileSearchBoxSize))@@", ((mapHeight / projectileSearchBoxSize) * (mapWidth / projectileSearchBoxSize)).ToString()).
                Replace("@@projectileLife@@", projectileLife.ToString()).
                Replace("@@projectileExplosionLife@@", projectileExplosionLife.ToString()).
                Replace("@@shipExplosionLife@@", shipExplosionLife.ToString()).
                Replace("@@projectileSize@@", projectileSize.ToString()).
                Replace("@@renderWidth@@", renderWidth.ToString()).
                Replace("@@nLocalSize@@", localSize.ToString()).
                Replace("@@nShipModules@@", nShipModules.ToString()).
                Replace("@@renderHeight@@", renderHeight.ToString()).
                Replace("@@nShipCrew@@", nShipCrew.ToString()).

                Replace("@@skyWidth@@", skyWidth.ToString()).
                Replace("@@skyHeight@@", skyHeight.ToString()).
                Replace("@@renderPatchSizeShip@@", renderPatchSizeShip.ToString()).
                Replace("@@renderPatchSizeSqrtShip@@", renderPatchSizeShipSqrt.ToString()).
                Replace("@@renderPatchSizeProjectile@@", renderPatchSizeProjectile.ToString()).
                Replace("@@renderPatchSizeSqrtProjectile@@", renderPatchSizeProjectileSqrt.ToString()).




                Replace("@@moduleTypePower@@", moduleTypePower.ToString()).
                Replace("@@moduleTypeEnergy@@", moduleTypeEnergy.ToString()).
                Replace("@@moduleTypeShield@@", moduleTypeShield.ToString()).
                Replace("@@moduleTypeTurret@@", moduleTypeTurret.ToString()).
                Replace("@@moduleTypeTurretTurbo@@", moduleTypeTurretTurbo.ToString()).


                Replace("@@shieldDistance@@", shieldDistance.ToString());

            cr = new ClNumberCruncher(slcTmp,strKernel,false,2);
            GC.Collect();
            Console.WriteLine("Buffer...");


            shipModuleShieldDamagedGPU = shipModuleShieldDamaged;
            shipModuleXGPU = shipModuleX;
            shipModuleYGPU = shipModuleY;

            crewDataGPU = crewData;
            crewExperienceGPU = crewExperience;
            crewLevelGPU = crewLevel;
            crewLevelHistogramGPU = new ClArray<int>(4096);
            crewLevelHistogramC2GPU = new ClArray<int>(4096);
            crewEvasionSkillLevelGPU = crewEvasionSkillLevel;
            crewTacticalCriticalHitSkillLevelGPU = crewTacticalCriticalHitSkillLevel;
            crewFastLearningSkillLevelGPU = crewFastLearningSkillLevel;
            crewShipIdGPU = crewShipId;
            crewHpGPU = crewHp;
            crewTempHpGPU = crewTempHp;

            textureBuf = new byte[numBytes];
            textureBuf2 = new byte[numBytes];
            textureBufC2 = new byte[numBytes];
            textureBuf2C2 = new byte[numBytes];
            textureBufTmp = new byte[numBytes];
            textureBufGPU = new ClArray<byte>(numBytes);
            textureBufC2GPU = new ClArray<byte>(numBytes);
            textureBufGPU.zeroCopy = true;
            textureBufC2GPU.zeroCopy = true;
            textureBuf2GPU = new ClArray<byte>(numBytes);
            textureBuf2C2GPU = new ClArray<byte>(numBytes);
            textureBuf2GPU.zeroCopy = true;
            textureBuf2C2GPU.zeroCopy = true;
            textureBufTmpGPU = new ClArray<byte>(numBytes);
            textureBufTmpC2GPU = new ClArray<byte>(numBytes);
            textureLightBufR = new float[numBytes / 4];
            textureLightBufRGPU = textureLightBufR;
            textureLightBufG = new float[numBytes / 4];
            textureLightBufGGPU = textureLightBufG;
            textureLightBufB = new float[numBytes / 4];
            textureLightBufBGPU = textureLightBufB;
            pixelUsed = new byte[numBytes / 4];
            pixelUsedGPU = pixelUsed;

            shipShieldDamagedGPU = shipShieldDamaged;
            shipSearchBoxGPU = shipSearchBox;
            shipSearchBoxRenderGPU = shipSearchBoxRender;
            projectileSearchBoxGPU = projectileSearchBox;
            



          

            shipCommandGPU = shipCommand;
            shipXTmpGPU = shipXTmp;
            shipXTmp2GPU = shipX2Tmp;
            shipFrontXGPU = shipFrontX;

            shipYTmpGPU = shipYTmp;
            shipYTmp2GPU = shipY2Tmp;
            shipFrontYGPU = shipFrontY;

            
    
            shipWeaponChargeGPU = shipWeaponCharge;
            shipLaserProjectileStateGPU = shipLaserProjectileState;
            shipLaserProjectileXGPU = shipLaserProjectileX;
            projectileCritExplosionGPU = projectileCritExplosion;
            projectileEvadedShipIdGPU = projectileEvadedShipId;
            shipLaserProjectileYGPU = shipLaserProjectileY;
            shipLaserProjectileRotationGPU = shipLaserProjectileRotation;
            projectileDamageGPU = projectileDamage;
            shipLaserProjectileLifeGPU = shipLaserProjectileLife;

           


            findEnemyHintWGPU = findEnemyHintW;
            findEnemyHintHGPU = findEnemyHintH;



            shipShieldRechargeGPU = shipShieldRecharge;

            shipCountReductionStepGPU = shipCountReductionStep;

            shipCount0PingGPU = shipCount0Ping;
            shipCount0PongGPU = shipCount0Pong;

            shipCount1PingGPU = shipCount1Ping;
            shipCount1PongGPU = shipCount1Pong;

            shipCount2PingGPU = shipCount2Ping;
            shipCount2PongGPU = shipCount2Pong;


            //parametersFloatGPU.readOnly = true;
            parametersFloatGPU.zeroCopy = true;
            //parametersIntGPU.readOnly = true;
            parametersIntGPU.zeroCopy = true;
            engineFrameTimeGPU.zeroCopy = true;
            engineFrameTimeGPU.write = false;
            userInterfaceGPU.write = false;
            userInterface2GPU.read = false;
            userInterface2GPU.write = false;

            textureLightBufRGPU.write = false;
            textureLightBufRGPU.read = false;
            textureLightBufGGPU.write = false;
            textureLightBufGGPU.read = false;
            textureLightBufBGPU.write = false;
            textureLightBufBGPU.read = false;
            pixelUsedGPU.write = false;
            pixelUsedGPU.read = false;


            shipModuleTypeGPU.read = false;
            shipModuleTypeGPU.write = false;
            shipModuleEnergyGPU.read = false;
            shipModuleEnergyGPU.write = false;
            shipModuleHPGPU.read = false;
            shipModuleHPGPU.write = false;
            shipModuleHPMaxGPU.read = false;
            shipModuleHPMaxGPU.write = false;
            shipModuleEnergyMaxGPU.read = false;
            shipModuleEnergyMaxGPU.write = false;
            shipModuleWeightGPU.read = false;
            shipModuleWeightGPU.write = false;
            shipModuleStateGPU.read = false;
            shipModuleStateGPU.write = false;
            shipModuleShieldDamagedGPU.read = false;
            shipModuleShieldDamagedGPU.write = false;
            shipModuleXGPU.read = false;
            shipModuleXGPU.write = false;
            shipModuleYGPU.read = false;
            shipModuleYGPU.write = false;

            crewDataGPU.read = false;
            crewDataGPU.write = false;
            crewExperienceGPU.read = false;
            crewExperienceGPU.write = false;
            crewLevelGPU.read = false;
            crewLevelGPU.write = false;
            crewLevelHistogramGPU.read = false;
            crewLevelHistogramC2GPU.read = false;
            crewLevelHistogramGPU.writeAll = true;
            crewLevelHistogramC2GPU.writeAll = true;
            crewEvasionSkillLevelGPU.read = false;
            crewEvasionSkillLevelGPU.write = false;
            crewTacticalCriticalHitSkillLevelGPU.read = false;
            crewTacticalCriticalHitSkillLevelGPU.write = false;
            crewFastLearningSkillLevelGPU.read = false;
            crewFastLearningSkillLevelGPU.write = false;
            crewShipIdGPU.read = false;
            crewShipIdGPU.write = false;
            crewHpGPU.read = false;
            crewHpGPU.write = false;
            crewTempHpGPU.read = false;
            crewTempHpGPU.write = false;

            textureBufGPU.write = false;
            textureBufC2GPU.write = false;
            textureBuf2GPU.write = false;
            textureBuf2C2GPU.write = false;
            textureBufTmpGPU.write = false;
            textureBufTmpC2GPU.write = false;

            shipSearchBoxGPU.read = false;
            shipSearchBoxGPU.write = false;
            shipSearchBoxRenderGPU.read = false;
            shipSearchBoxRenderGPU.write = false;


            shipShieldDamagedGPU.write = false;
            shipShieldDamagedGPU.read = false;
            projectileSearchBoxGPU.read = false;
            projectileSearchBoxGPU.write = false;

            parametersFloatGPU.write = false;
            parametersIntGPU.write = false;
            rightClickXYGPU.write = false;
            rightClickXYGPU.read = false;
            userCommandGPU.write = false;
            userCommandGPU.read = false;



            randSeedGPU.write = false;
            randSeedGPU.read = false;


            shipTargetShipGPU.read = false;
            shipTargetShipGPU.write = false;
            shipSelectedGPU.read = false;
            shipSelectedGPU.write = false;
            shipTeamGPU.read = false;
            shipXGPU.read = false;
            shipTargetXGPU.read = false;
            shipTargetYGPU.read = false;
            shipCommandGPU.read = false;
            shipXOldGPU.read = false;
            shipXTmpGPU.read = false;
            shipXTmp2GPU.read = false;
            shipFrontXGPU.read = false;
            shipYGPU.read = false;
            shipYOldGPU.read = false;
            shipYTmpGPU.read = false;
            shipYTmp2GPU.read = false;
            shipFrontYGPU.read = false;
            shipRotationGPU.read = false;
            shipStateGPU.read = false;
            shipSizeTypeGPU.read = false;
            shipWeaponChargeGPU.read = false;
            shipLaserProjectileStateGPU.read = false;
            shipLaserProjectileXGPU.read = false;
            shipLaserProjectileYGPU.read = false;
            projectileCritExplosionGPU.read = false;
            projectileEvadedShipIdGPU.read = false;
            shipLaserProjectileRotationGPU.read = false;
            projectileDamageGPU.read = false;
            shipLaserProjectileLifeGPU.read = false;

            shipHitPointsGPU.read = false;
            shipHitPointsMaxGPU.read = false;
            findEnemyHintWGPU.read = false;
            findEnemyHintHGPU.read = false;
            shipShieldsGPU.read = false;
            shipShieldRechargeGPU.read = false;
            shipShieldsMaxGPU.read = false;
            numberOfShipsGPU.read = false;
            numberOfShipsC2GPU.read = false;
            shipCountReductionStepGPU.read = false;
            shipCount0PingGPU.read = false;
            shipCount0PongGPU.read = false;
            shipCount1PingGPU.read = false;
            shipCount1PongGPU.read = false;
            shipCount2PingGPU.read = false;
            shipCount2PongGPU.read = false;

            shipTeamGPU.write = false;
            shipXGPU.write = false;
            shipTargetXGPU.write = false;
            shipTargetYGPU.write = false;
            shipCommandGPU.write = false;
            shipXOldGPU.write = false;
            shipXTmpGPU.write = false;
            shipXTmp2GPU.write = false;
            shipFrontXGPU.write = false;
            shipYGPU.write = false;
            shipYOldGPU.write = false;
            shipYTmpGPU.write = false;
            shipYTmp2GPU.write = false;
            shipFrontYGPU.write = false;
            shipRotationGPU.write = false;
            shipStateGPU.write = false;
            shipSizeTypeGPU.write = false;
            shipWeaponChargeGPU.write = false;
            shipLaserProjectileStateGPU.write = false;
            shipLaserProjectileXGPU.write = false;
            shipLaserProjectileYGPU.write = false;
            projectileCritExplosionGPU.write = false;
            projectileEvadedShipIdGPU.write = false;
            shipLaserProjectileRotationGPU.write = false;
            projectileDamageGPU.write = false;
            shipLaserProjectileLifeGPU.write = false;


            shipHitPointsGPU.write = false;
            shipHitPointsMaxGPU.write = false;
            findEnemyHintWGPU.write = false;
            findEnemyHintHGPU.write = false;
            shipShieldsGPU.write = false;
            shipShieldRechargeGPU.write = false;
            shipShieldsMaxGPU.write = false;
            numberOfShipsGPU.write = true;
            numberOfShipsC2GPU.write = true;
            shipCountReductionStepGPU.write = false;
            shipCount0PingGPU.write = false;
            shipCount0PongGPU.write = false;
            shipCount1PingGPU.write = false;
            shipCount1PongGPU.write = false;
            shipCount2PingGPU.write = false;
            shipCount2PongGPU.write = false;

            numberOfShipsGPU.writeAll = true;
            numberOfShipsC2GPU.writeAll = true;
            numberOfShipsGPU.zeroCopy = true;
            numberOfShipsC2GPU.zeroCopy = true;
            textureBufGPU.writeAll = false;
            textureBufC2GPU.writeAll = false;
            projectileSearchBoxGPU.writeAll = false;
            shipShieldDamagedGPU.writeAll = false;
            shipSearchBoxGPU.writeAll = false;
            shipSearchBoxRenderGPU.writeAll = false;
            textureBufTmpGPU.writeAll = false;
            textureBufTmpC2GPU.writeAll = false;
            textureBuf2GPU.writeAll = false;
            textureBuf2C2GPU.writeAll = false;
            shipSearchBoxGPU.partialRead = false;
            shipSearchBoxRenderGPU.partialRead = false;
            shipShieldDamagedGPU.partialRead = false;
            projectileSearchBoxGPU.partialRead = false;

            textureBufGPU.zeroCopy = true;
            textureBuf2GPU.zeroCopy = true;
            textureBuf2C2GPU.zeroCopy = true;
            textureBufC2GPU.zeroCopy = true;

            parametersIntGPU[1] = moduleId[0];
            parametersIntGPU[2] = moduleId[1];
            parametersIntGPU[3] = moduleId[2];
            parametersIntGPU[4] = moduleId[3];
            parametersIntGPU[5] = moduleId[4];
            parametersIntGPU[6] = moduleId[5];
            parametersIntGPU[7] = moduleId[6];
            parametersIntGPU[8] = moduleId[7];
            parametersIntGPU[9] = moduleId[8];
            parametersIntGPU[10] = moduleId[9];

            parametersIntGPU[11] = playerTeam;
            Console.WriteLine("playerTeam="+ playerTeam);
            if (details)
            {
                Console.WriteLine("loadBitmaps");
                Console.WriteLine(shipCorvetteBitmapBytesGPU.Length);
                Console.WriteLine(projectileBitmapBytesGPU.Length);
                Console.WriteLine(skyBitmapBytesGPU.Length);
                Console.WriteLine(captainRankBytesGPU.Length);
                Console.WriteLine(charBytesGPU.Length);
            }
            shipCorvetteBitmapBytesGPU.nextParam(projectileBitmapBytesGPU, skyBitmapBytesGPU, 
                captainRankBytesGPU, charBytesGPU).compute(cr, 9999993, "loadBitmaps", 1, 1);
            charBytesGPU.read = false;
            charBytesGPU.write = false;
            charBytesGPU.writeAll = false;
            charBytesGPU.partialRead = false;
            shipCorvetteBitmapBytesGPU.write = false;
            shipCorvetteBitmapBytesGPU.read = false;
            projectileBitmapBytesGPU.write = false;
            projectileBitmapBytesGPU.read = false;
            skyBitmapBytesGPU.write = false;
            skyBitmapBytesGPU.read = false;
            captainRankBytesGPU.read = false;
            captainRankBytesGPU.write = false;
            if (details)
                Console.WriteLine("rnd_0");
            randSeedGPU.compute(cr, 0, "rnd_0", randSeed.Length, localSize);
          
            bool tmpB = parametersIntGPU.read;
            parametersIntGPU.read = true;
            if (details)
                Console.WriteLine("initShips");
            shipXGPU.nextParam(shipYGPU, shipStateGPU, shipRotationGPU,
                shipTeamGPU, randSeedGPU, shipHitPointsGPU,
                shipXOldGPU, shipYOldGPU, parametersIntGPU, shipSizeTypeGPU, shipHitPointsMaxGPU).compute(cr, 1, "initShips", nShip, localSize);


            if (details)
                Console.WriteLine("initShipModule");
            shipModuleTypeGPU.nextParam(shipModuleEnergyGPU, shipModuleHPGPU, shipModuleHPMaxGPU,
                randSeedGPU, shipModuleEnergyMaxGPU, shipModuleWeightGPU,
                shipModuleStateGPU, shipShieldsMaxGPU, shipShieldsGPU, shipTeamGPU,
                parametersIntGPU, shipSizeTypeGPU).compute(cr, 999000, "initShipModule", nShip, localSize);


            if (details)
                Console.WriteLine("initShipProjectiles");
            shipLaserProjectileXGPU.nextParam(shipLaserProjectileYGPU, shipLaserProjectileStateGPU,
                shipLaserProjectileRotationGPU, projectileEvadedShipIdGPU).compute(cr, 2, "initShipProjectiles", nShip, localSize);



            if (details)
                Console.WriteLine("initShipCrew");
            crewDataGPU.nextParam(crewExperienceGPU, crewLevelGPU, crewShipIdGPU,
                crewHpGPU, crewTempHpGPU, randSeedGPU, crewEvasionSkillLevelGPU,
                crewTacticalCriticalHitSkillLevelGPU, crewFastLearningSkillLevelGPU,
                parametersIntGPU, shipTeamGPU).compute(cr, 987987, "initShipCrew", nShip, localSize);

            if (details)
                Console.WriteLine("shipTargetClear");
            shipTargetShipGPU.compute(cr, 988985, "shipTargetClear", nShip, localSize);


            textureBufGPU.numberOfElementsPerWorkItem = 4; // 4 char argb
            textureBufC2GPU.numberOfElementsPerWorkItem = 4; // 4 char argb
            textureBuf2GPU.numberOfElementsPerWorkItem = 4; // 4 char argb
            textureBuf2C2GPU.numberOfElementsPerWorkItem = 4; // 4 char argb
            textureBufTmpGPU.numberOfElementsPerWorkItem = 4;
            textureBufTmpC2GPU.numberOfElementsPerWorkItem = 4;

            parametersIntGPU.read = tmpB;
            for(int i=0;i<10;i++)
                engineFrameTimeGPU[i] = 0;
            for (int i = 0; i < 1024; i++)
                userInterfaceGPU[i] = 0;
            for (int i = 0; i < 1024; i++)
                userInterface2GPU[i] = 0;

            Console.WriteLine("init_end");

        }


        bool userControlLocked = false;
        public void lockUserControl()
        {
            userControlLocked = true;
        }

        object runLock = new object();
        int flushCtrPr = 0;
        int flushCtr { get { return flushCtrPr; } set { flushCtrPr = value; } }
        Stopwatch swEngine = new Stopwatch();
        double lastTime = 0;
        bool swStarted = false;
        Stopwatch swComputeTiming = new Stopwatch();
        public void run()
        {
         
            if (!swStarted)
            { swEngine.Start(); swStarted = true; }
            double curTime=swEngine.Elapsed.TotalMilliseconds;
            double deltaT = curTime - lastTime; // time since last run() call --> for game event triggers and projectile-ship movements
            lastTime = curTime; 
            bool tmpTexturePipelineState = false;
            lock (texturePipelineStateLock)
            {
                tmpTexturePipelineState = texturePipelineState;
            }

            lock (runLock)
            {
                if (((((mapWidth / searchBoxSize) * (mapHeight / searchBoxSize))) % localSize) != 0)
                {
                    Console.WriteLine("resetBoxes local size not multiple of " + localSize);
                    Environment.Exit(0);
                }

                if (((((mapWidth / projectileSearchBoxSize) * (mapHeight / projectileSearchBoxSize))) % localSize) != 0)
                {
                    Console.WriteLine("resetProjectileBoxes local size not multiple of " + localSize);
                    Environment.Exit(0);
                }

                int flushStep = 4;

                swComputeTiming.Start();

                if (!details)
                {
                    cr.enqueueMode = true;
                }

                if (!userControlLocked)
                {
                    parametersFloatGPU.read = true;
                    parametersIntGPU.read = true;
                }
                if (details)
                    Console.WriteLine("loadFloatIntParameters");



                engineFrameTimeGPU.read = true;
                engineFrameTimeGPU.write = false;
                if (engineFrameTimeGPU[2] > 1.0f)
                    engineFrameTimeGPU[2] = 0.0f;
                engineFrameTimeGPU[4] = engineFrameTimeGPU[0];
                engineFrameTimeGPU[0] = (float)deltaT;
                engineFrameTimeGPU[1]+= (float)deltaT;
                if (engineFrameTimeGPU[1] > 33.0f)
                {
                    engineFrameTimeGPU[2] = engineFrameTimeGPU[1] / 32.9f;
                    engineFrameTimeGPU[1] -= engineFrameTimeGPU[1]*33.0f;
                }

                if (engineFrameTimeGPU[1] < 0.0f)
                    engineFrameTimeGPU[1] = 0.0f;
                engineFrameTimeGPU[3] += (float)deltaT;
                userInterfaceGPU[0] = (float)deltaT;   // frame time
                userInterfaceGPU[1] = (float)calcPoint;// benchmark score
                parametersFloatGPU.nextParam(parametersIntGPU, engineFrameTimeGPU).compute(cr, 100000, "loadFloatIntParameters", 1, 1);
                parametersFloatGPU.read = false;
                parametersIntGPU.read = false;



                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (details)
                    Console.WriteLine("custom kernel...");

                if (customTaskArray != null)
                {
                    for (int ct = 0; ct < customTaskArray.Length; ct++)
                        customTaskArray[ct].compute(cr);
                }

                if (details)
                    Console.WriteLine("rightClickCompute");
                if (arraysToCompute[1] == null)
                    arraysToCompute[1] = shipTargetXGPU.nextParam(shipTargetYGPU, shipCommandGPU, rightClickXYGPU,
                    userCommandGPU, shipSelectedGPU, parametersFloatGPU, shipTargetShipGPU,shipXGPU,shipYGPU);

                arraysToCompute[1].compute(cr, 200000, "rightClickCompute", nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (details)
                    Console.WriteLine("rotateShipByCommand");
                if (arraysToCompute[2] == null)
                    arraysToCompute[2] = shipTargetXGPU.nextParam(shipTargetYGPU, shipXGPU, shipYGPU,
                shipCommandGPU, shipStateGPU, shipRotationGPU,engineFrameTimeGPU);
                arraysToCompute[2].compute(cr, 300000, "rotateShipByCommand", nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();




                if (!computePipelineState)
                {
                    if (tmpTexturePipelineState)
                    {
                        if (details)
                            Console.WriteLine("clearTexture");
                        textureBufGPU.writeAll = false;
                        textureBufGPU.write = false;
                        textureBufGPU.read = false;
                        textureBufGPU.compute(cr, 3, "clearTexture", renderWidth * renderHeight, localSize);
                    }
                    else
                    {
                        if (details)
                            Console.WriteLine("clearTexture");
                        textureBuf2GPU.writeAll = false;
                        textureBuf2GPU.write = false;
                        textureBuf2GPU.read = false;
                        textureBuf2GPU.compute(cr, 4, "clearTexture", renderWidth * renderHeight, localSize);
                    }
                }
                else
                {
                    if (tmpTexturePipelineState)
                    {
                        if (details)
                            Console.WriteLine("clearTexture");
                        textureBufC2GPU.writeAll = false;
                        textureBufC2GPU.write = false;
                        textureBufC2GPU.read = false;
                        textureBufC2GPU.compute(cr, 3, "clearTexture", renderWidth * renderHeight, localSize);
                    }
                    else
                    {
                        if (details)
                            Console.WriteLine("clearTexture");
                        textureBuf2C2GPU.writeAll = false;
                        textureBuf2C2GPU.write = false;
                        textureBuf2C2GPU.read = false;
                        textureBuf2C2GPU.compute(cr, 4, "clearTexture", renderWidth * renderHeight, localSize);
                    }
                }


                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (details)
                    Console.WriteLine("resetShieldAnimation");
                if (arraysToCompute[3] == null)
                    arraysToCompute[3] = shipShieldDamagedGPU.nextParam(shipModuleShieldDamagedGPU);
                arraysToCompute[3].compute(cr, 5, "resetShieldAnimation", nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (details)
                    Console.WriteLine("resetBoxes");


                shipSearchBoxGPU.nextParam(shipSearchBoxRenderGPU).compute(cr, 6, "resetBoxes", (mapWidth / searchBoxSize) * (mapHeight / searchBoxSize), localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (details)
                    Console.WriteLine("resetProjectileBoxes");
                projectileSearchBoxGPU.compute(cr, 7, "resetProjectileBoxes", (mapWidth / projectileSearchBoxSize) * (mapHeight / projectileSearchBoxSize), localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();


                if (details)
                    Console.WriteLine("moveShips");
                engineFrameTimeGPU.read = false;
                engineFrameTimeGPU.write = false;
                if (arraysToCompute[4] == null)
                    arraysToCompute[4] = shipXTmpGPU.nextParam(shipYTmpGPU,
                        shipRotationGPU, shipStateGPU, shipXOldGPU,
                        shipYOldGPU, engineFrameTimeGPU);
                arraysToCompute[4].compute(cr, 8, "moveShips", nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (details)
                    Console.WriteLine("moveShipsVerlet");

                if (arraysToCompute[5] == null)
                    arraysToCompute[5] = shipXGPU.nextParam(shipYGPU, shipXOldGPU,
                        shipYOldGPU, shipXTmpGPU, shipYTmpGPU,shipStateGPU,engineFrameTimeGPU,
                        shipXTmp2GPU,shipYTmp2GPU);
                arraysToCompute[5].compute(cr, 9, "moveShipsVerlet", nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (details)
                    Console.WriteLine("moveProjectiles");

                engineFrameTimeGPU.read = false;
                engineFrameTimeGPU.write = false;
                if (arraysToCompute[6] == null)
                    arraysToCompute[6] = shipLaserProjectileXGPU.nextParam(shipLaserProjectileYGPU, shipLaserProjectileRotationGPU,
                    shipLaserProjectileStateGPU, shipXGPU, shipYGPU, engineFrameTimeGPU);
                arraysToCompute[6].compute(cr, 10, "moveProjectiles", nShipProjectiles * nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (details)
                    Console.WriteLine("calculateShipFronts");

                if (arraysToCompute[7] == null)
                    arraysToCompute[7] = shipXGPU.nextParam(shipYGPU, shipRotationGPU, shipFrontXGPU,
                    shipFrontYGPU, shipSizeTypeGPU);
                arraysToCompute[7].compute(cr, 11, "calculateShipFronts", nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (details)
                    Console.WriteLine("calculateModuleCoordinates");
                if (arraysToCompute[8] == null)
                    arraysToCompute[8] = shipXGPU.nextParam(shipYGPU, shipRotationGPU, shipSizeTypeGPU,
                shipModuleXGPU, shipModuleYGPU, shipTeamGPU);
                arraysToCompute[8].compute(cr, 999035, "calculateModuleCoordinates", nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();


                if (details)
                    Console.WriteLine("incrementProjectileStates");
                engineFrameTimeGPU.read = false;
                engineFrameTimeGPU.write = false;
                if (arraysToCompute[9] == null)
                    arraysToCompute[9] = shipLaserProjectileLifeGPU.nextParam(
                        shipLaserProjectileStateGPU, randSeedGPU, engineFrameTimeGPU);
                arraysToCompute[9].compute(cr, 12, "incrementProjectileStates", nShipProjectiles * nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();


                if (details)
                    Console.WriteLine("incrementShipStates");
                if (arraysToCompute[10] == null)
                    arraysToCompute[10] = shipShieldsMaxGPU.nextParam(shipShieldsGPU, 
                        shipShieldRechargeGPU, engineFrameTimeGPU);
                arraysToCompute[10].compute(cr, 13, "incrementShipStates", nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();



                if (details)
                    Console.WriteLine("incrementShipModuleStates");
                engineFrameTimeGPU.read = false;
                engineFrameTimeGPU.write = false;
                if (arraysToCompute[11] == null)
                    arraysToCompute[11] = shipModuleTypeGPU.nextParam(shipModuleEnergyGPU,
                    shipModuleHPGPU, shipModuleHPMaxGPU, randSeedGPU, shipModuleEnergyMaxGPU, shipModuleWeightGPU,
                    shipModuleStateGPU, shipShieldsMaxGPU, shipShieldsGPU,engineFrameTimeGPU);
                arraysToCompute[11].compute(cr, 999001, "incrementShipModuleStates", nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (details)
                    Console.WriteLine("processShipStates");
                engineFrameTimeGPU.read = false;
                engineFrameTimeGPU.write = false;
                if (arraysToCompute[12] == null)
                    arraysToCompute[12] = shipHitPointsGPU.nextParam(shipStateGPU, 
                        shipShieldsGPU,engineFrameTimeGPU);
                arraysToCompute[12].compute(cr, 14, "processShipStates", nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (details)
                    Console.WriteLine("putShipsToBoxes");
                if (arraysToCompute[13] == null)
                    arraysToCompute[13] = shipXGPU.nextParam(shipYGPU, shipSearchBoxGPU,
                        shipStateGPU, shipSizeTypeGPU, shipSearchBoxRenderGPU);
                arraysToCompute[13].compute(cr, 15, "putShipsToBoxes", nShip, localSize);

                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if(details)
                    Console.WriteLine("resetForce");
                shipXTmpGPU.nextParam(shipYTmpGPU).compute(cr, 16017, "resetForce", nShip, localSize);

                if (details)
                    Console.WriteLine("checkShipShipCollision");
                if (arraysToCompute[14] == null)
                    arraysToCompute[14] = shipXGPU.nextParam(shipYGPU, shipXTmp2GPU, shipYTmp2GPU,
                        shipSearchBoxGPU, shipSizeTypeGPU, shipStateGPU);
                arraysToCompute[14].compute(cr, 16, "checkShipShipCollision", nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();





                // async post processing + pci-e transfer
                if (!details)
                    cr.enqueueModeAsyncEnable = true;
                if (computePipelineState)
                {
                    if (!tmpTexturePipelineState)
                    {
                        if (details)
                            Console.WriteLine("postProcessSmooth");
                        textureBufGPU.read = false;
                        textureBufTmpGPU.read = false;
                        textureBufTmpGPU.write = false;
                        userInterfaceGPU.read = true;
                        textureBufGPU.nextParam(textureBufTmpGPU, userInterfaceGPU, userInterface2GPU).compute(cr, 10034, "postProcessSmooth", renderWidth * renderHeight, localSize);
                        userInterfaceGPU.read = false;


                        if (details)
                            Console.WriteLine("postProcessOutput");

                        textureBufGPU.read = false;
                        numberOfShipsGPU.read = false;
                        crewLevelHistogramGPU.read = false;

                        textureBufGPU.writeAll = true;
                        textureBufGPU.write = true;
                        numberOfShipsGPU.write = true;
                        numberOfShipsGPU.writeAll = true;
                        crewLevelHistogramGPU.write = true;
                        crewLevelHistogramGPU.writeAll = true;

                        textureBufGPU.nextParam(textureBufTmpGPU, numberOfShipsGPU, 
                            crewLevelHistogramGPU,charBytesGPU, userInterface2GPU).compute(cr, 10035, "postProcessOutput", renderWidth * renderHeight, localSize);

                        texture1Used = false;
                    }
                    else
                    {
                        if (details)
                            Console.WriteLine("postProcessSmooth");
                        textureBuf2GPU.read = false;
                        textureBufTmpGPU.read = false;
                        textureBufTmpGPU.write = false;
                        userInterfaceGPU.read = true;
                        textureBuf2GPU.nextParam(textureBufTmpGPU, userInterfaceGPU,userInterface2GPU).compute(cr, 10036, "postProcessSmooth", renderWidth * renderHeight, 256);
                        userInterfaceGPU.read = false;

                        if (details)
                            Console.WriteLine("postProcessOutput");

                        textureBuf2GPU.read = false;
                        numberOfShipsGPU.read = false;
                        crewLevelHistogramGPU.read = false;
                        textureBuf2GPU.writeAll = true;
                        textureBuf2GPU.write = true;
                        numberOfShipsGPU.write = true;
                        numberOfShipsGPU.writeAll = true;
                        crewLevelHistogramGPU.write = true;
                        crewLevelHistogramGPU.writeAll = true;

                        textureBuf2GPU.nextParam(textureBufTmpGPU, numberOfShipsGPU, 
                            crewLevelHistogramGPU, charBytesGPU, userInterface2GPU).compute(cr, 10037, "postProcessOutput", renderWidth * renderHeight, localSize);
                        texture2Used = false;
                    }
                }
                else
                {
                    if (!tmpTexturePipelineState)
                    {
                        if (details)
                            Console.WriteLine("postProcessSmooth");
                        textureBufC2GPU.read = false;
                        textureBufTmpC2GPU.read = false;
                        textureBufTmpC2GPU.write = false;
                        userInterfaceGPU.read = true;
                        textureBufC2GPU.nextParam(textureBufTmpC2GPU, userInterfaceGPU, userInterface2GPU).compute(cr, 34, "postProcessSmooth", renderWidth * renderHeight, localSize);
                        userInterfaceGPU.read = false;

                        if (details)
                            Console.WriteLine("postProcessOutput");

                        textureBufC2GPU.read = false;
                        numberOfShipsC2GPU.read = false;
                        crewLevelHistogramC2GPU.read = false;
                        textureBufC2GPU.writeAll = true;
                        textureBufC2GPU.write = true;
                        numberOfShipsC2GPU.write = true;
                        numberOfShipsC2GPU.writeAll = true;
                        crewLevelHistogramC2GPU.write = true;
                        crewLevelHistogramC2GPU.writeAll = true;

                        textureBufC2GPU.nextParam(textureBufTmpC2GPU, numberOfShipsC2GPU, 
                            crewLevelHistogramC2GPU, charBytesGPU, userInterface2GPU).compute(cr, 35, "postProcessOutput", renderWidth * renderHeight, localSize);

                        texture1Used = false;
                    }
                    else
                    {
                        if (details)
                            Console.WriteLine("postProcessSmooth");
                        textureBuf2C2GPU.read = false;
                        textureBufTmpC2GPU.read = false;
                        textureBufTmpC2GPU.write = false;
                        userInterfaceGPU.read = true;
                        textureBuf2C2GPU.nextParam(textureBufTmpC2GPU, userInterfaceGPU, userInterface2GPU).compute(cr, 36, "postProcessSmooth", renderWidth * renderHeight, 256);
                        userInterfaceGPU.read = false;

                        if (details)
                            Console.WriteLine("postProcessOutput");

                        textureBufC2GPU.read = false;
                        numberOfShipsC2GPU.read = false;
                        crewLevelHistogramC2GPU.read = false;
                        textureBuf2C2GPU.writeAll = true;
                        textureBuf2C2GPU.write = true;
                        numberOfShipsC2GPU.write = true;
                        numberOfShipsC2GPU.writeAll = true;
                        crewLevelHistogramC2GPU.write = true;
                        crewLevelHistogramC2GPU.writeAll = true;

                        textureBuf2C2GPU.nextParam(textureBufTmpC2GPU, numberOfShipsC2GPU, 
                            crewLevelHistogramC2GPU, charBytesGPU, userInterface2GPU).compute(cr, 37, "postProcessOutput", renderWidth * renderHeight, localSize);
                        texture2Used = false;
                    }
                }

                cr.flushLastUsedCommandQueue();

                if (!details)
                    cr.enqueueModeAsyncEnable = true;

                // async postprocessing end





                if (details)
                    Console.WriteLine("findEnemyShipsBlocked");
                if (arraysToCompute[15] == null)
                    arraysToCompute[15] = shipXGPU.nextParam(shipYGPU, shipSearchBoxGPU, shipFrontXGPU, shipFrontYGPU, shipLaserProjectileXGPU, shipLaserProjectileYGPU,
                    shipStateGPU, shipLaserProjectileStateGPU, shipLaserProjectileRotationGPU, shipWeaponChargeGPU,
                    randSeedGPU, shipTeamGPU, shipLaserProjectileLifeGPU).nextParam(shipModuleTypeGPU, shipModuleEnergyGPU,
                    shipModuleHPGPU, shipModuleHPMaxGPU, randSeedGPU, shipModuleEnergyMaxGPU, shipModuleWeightGPU,
                    shipModuleStateGPU, shipSizeTypeGPU, shipModuleXGPU, shipModuleYGPU,
                    findEnemyHintWGPU, findEnemyHintHGPU, projectileDamageGPU, projectileEvadedShipIdGPU);
                arraysToCompute[15].compute(cr, 17, "findEnemyShipsBlocked", nBox /* nShip*/, localSize);

                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();


                

                if (details)
                    Console.WriteLine("checkProjectileShipCollisions");
                if (arraysToCompute[16] == null)
                    arraysToCompute[16] = shipLaserProjectileXGPU.nextParam(shipLaserProjectileYGPU, shipXGPU, shipYGPU,
                    shipLaserProjectileStateGPU, shipSearchBoxGPU, shipFrontXGPU, shipFrontYGPU,
                    shipTeamGPU, shipHitPointsGPU, randSeedGPU, shipShieldsGPU,
                    shipLaserProjectileLifeGPU, shipShieldDamagedGPU, shipSizeTypeGPU,
                    shipModuleTypeGPU, shipModuleXGPU, shipModuleYGPU,
                    shipModuleStateGPU, shipModuleShieldDamagedGPU, shipCorvetteBitmapBytesGPU,
                    shipRotationGPU, projectileDamageGPU, shipStateGPU,
                    crewExperienceGPU, crewDataGPU, crewLevelGPU, crewEvasionSkillLevelGPU,
                    projectileEvadedShipIdGPU, crewTacticalCriticalHitSkillLevelGPU,
                    projectileCritExplosionGPU, crewFastLearningSkillLevelGPU);
                arraysToCompute[16].compute(cr, 18, "checkProjectileShipCollisions", nShipProjectiles * nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();


                if (details)
                    Console.WriteLine("putProjectilesToBoxes");
                if (arraysToCompute[17] == null)
                    arraysToCompute[17] = shipLaserProjectileXGPU.nextParam(shipLaserProjectileYGPU,
                    projectileSearchBoxGPU, shipLaserProjectileStateGPU);
                arraysToCompute[17].compute(cr, 19, "putProjectilesToBoxes", nShipProjectiles * nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();




                if (!computePipelineState)
                {
                    if (tmpTexturePipelineState)
                    {
                        if (details)
                            Console.WriteLine("renderProjectilesToTexture");
                        if (arraysToCompute[18] == null)
                            arraysToCompute[18] = textureBufGPU.nextParam(projectileSearchBoxGPU, shipLaserProjectileXGPU, shipLaserProjectileYGPU,
                        parametersFloatGPU, parametersIntGPU, shipTeamGPU, shipLaserProjectileRotationGPU,
                        shipLaserProjectileStateGPU, shipLaserProjectileLifeGPU, shipSizeTypeGPU,
                        projectileBitmapBytesGPU, skyBitmapBytesGPU, textureLightBufRGPU,
                        pixelUsedGPU, textureLightBufGGPU, textureLightBufBGPU, projectileCritExplosionGPU);
                        arraysToCompute[18].compute(cr, 20, "renderProjectilesToTexture", renderWidth * renderHeight, renderPatchSizeProjectile);
                        flushCtr++;
                        if ((flushCtr % flushStep) == 0)
                            cr.flushLastUsedCommandQueue();

                        if (details)
                            Console.WriteLine("renderShipsToTexture");
                        if (arraysToCompute[19] == null)
                            arraysToCompute[19] = textureBufGPU.nextParam(shipSearchBoxRenderGPU, shipXGPU, shipYGPU, parametersFloatGPU,
                            parametersIntGPU, shipTeamGPU, shipRotationGPU,
                            shipFrontXGPU, shipFrontYGPU, shipStateGPU, shipHitPointsGPU,
                            shipShieldDamagedGPU, shipSelectedGPU, rightClickXYGPU,
                            userCommandGPU, shipSizeTypeGPU, shipModuleXGPU,
                            shipModuleYGPU, shipModuleShieldDamagedGPU,
                            shipModuleStateGPU, shipModuleTypeGPU, shipCorvetteBitmapBytesGPU,
                            textureLightBufRGPU, pixelUsedGPU, textureLightBufGGPU, textureLightBufBGPU,
                            captainRankBytesGPU, crewDataGPU, crewLevelGPU);

                        arraysToCompute[19].compute(cr, 21, "renderShipsToTexture", renderWidth * renderHeight, renderPatchSizeShip /* 16x16 patches */ );


                    }
                    else
                    {
                        if (details)
                            Console.WriteLine("renderProjectilesToTexture");

                        if (arraysToCompute[20] == null)
                            arraysToCompute[20] = textureBuf2GPU.nextParam(projectileSearchBoxGPU, shipLaserProjectileXGPU, shipLaserProjectileYGPU,
                        parametersFloatGPU, parametersIntGPU, shipTeamGPU, shipLaserProjectileRotationGPU,
                        shipLaserProjectileStateGPU, shipLaserProjectileLifeGPU, shipSizeTypeGPU,
                        projectileBitmapBytesGPU, skyBitmapBytesGPU, textureLightBufRGPU, pixelUsedGPU,
                        textureLightBufGGPU, textureLightBufBGPU, projectileCritExplosionGPU);
                        arraysToCompute[20].compute(cr, 22, "renderProjectilesToTexture", renderWidth * renderHeight, renderPatchSizeProjectile /* 8x8 tiles */);
                        flushCtr++;
                        if ((flushCtr % flushStep) == 0)
                            cr.flushLastUsedCommandQueue();

                        if (details)
                            Console.WriteLine("renderShipsToTexture");
                        if (arraysToCompute[21] == null)
                            arraysToCompute[21] = textureBuf2GPU.nextParam(shipSearchBoxRenderGPU, shipXGPU, shipYGPU, parametersFloatGPU,
                            parametersIntGPU, shipTeamGPU, shipRotationGPU,
                            shipFrontXGPU, shipFrontYGPU, shipStateGPU, shipHitPointsGPU,
                            shipShieldDamagedGPU, shipSelectedGPU, rightClickXYGPU,
                            userCommandGPU, shipSizeTypeGPU, shipModuleXGPU,
                            shipModuleYGPU, shipModuleShieldDamagedGPU,
                            shipModuleStateGPU, shipModuleTypeGPU, shipCorvetteBitmapBytesGPU,
                            textureLightBufRGPU, pixelUsedGPU, textureLightBufGGPU, textureLightBufBGPU,
                            captainRankBytesGPU, crewDataGPU, crewLevelGPU);

                        arraysToCompute[21].compute(cr, 23, "renderShipsToTexture", renderWidth * renderHeight, renderPatchSizeShip);

                        
                    }
                    flushCtr++;
                    if ((flushCtr % flushStep) == 0)
                        cr.flushLastUsedCommandQueue();
                }
                else
                {
                    if (tmpTexturePipelineState)
                    {
                        if (details)
                            Console.WriteLine("renderProjectilesToTexture");
                        if (arraysToCompute[1018] == null)
                            arraysToCompute[1018] = textureBufC2GPU.nextParam(projectileSearchBoxGPU, shipLaserProjectileXGPU, shipLaserProjectileYGPU,
                        parametersFloatGPU, parametersIntGPU, shipTeamGPU, shipLaserProjectileRotationGPU,
                        shipLaserProjectileStateGPU, shipLaserProjectileLifeGPU, shipSizeTypeGPU,
                        projectileBitmapBytesGPU, skyBitmapBytesGPU, textureLightBufRGPU,pixelUsedGPU, 
                        textureLightBufGGPU, textureLightBufBGPU, projectileCritExplosionGPU);
                        arraysToCompute[1018].compute(cr, 1020, "renderProjectilesToTexture", renderWidth * renderHeight, renderPatchSizeProjectile);
                        flushCtr++;
                        if ((flushCtr % flushStep) == 0)
                            cr.flushLastUsedCommandQueue();

                        if (details)
                            Console.WriteLine("renderShipsToTexture");
                        if (arraysToCompute[1019] == null)
                            arraysToCompute[1019] = textureBufC2GPU.nextParam(shipSearchBoxRenderGPU, shipXGPU, shipYGPU, parametersFloatGPU,
                            parametersIntGPU, shipTeamGPU, shipRotationGPU,
                            shipFrontXGPU, shipFrontYGPU, shipStateGPU, shipHitPointsGPU,
                            shipShieldDamagedGPU, shipSelectedGPU, rightClickXYGPU,
                            userCommandGPU, shipSizeTypeGPU, shipModuleXGPU,
                            shipModuleYGPU, shipModuleShieldDamagedGPU,
                            shipModuleStateGPU, shipModuleTypeGPU, shipCorvetteBitmapBytesGPU,
                            textureLightBufRGPU, pixelUsedGPU, textureLightBufGGPU, textureLightBufBGPU,
                            captainRankBytesGPU, crewDataGPU, crewLevelGPU);

                        arraysToCompute[1019].compute(cr, 1021, "renderShipsToTexture", renderWidth * renderHeight, renderPatchSizeShip /* 16x16 patches */ );
                    }
                    else
                    {
                        if (details)
                            Console.WriteLine("renderProjectilesToTexture");

                        if (arraysToCompute[1020] == null)
                            arraysToCompute[1020] = textureBuf2C2GPU.nextParam(projectileSearchBoxGPU, shipLaserProjectileXGPU, shipLaserProjectileYGPU,
                        parametersFloatGPU, parametersIntGPU, shipTeamGPU, shipLaserProjectileRotationGPU,
                        shipLaserProjectileStateGPU, shipLaserProjectileLifeGPU, shipSizeTypeGPU,
                        projectileBitmapBytesGPU, skyBitmapBytesGPU, textureLightBufRGPU, pixelUsedGPU,
                        textureLightBufGGPU, textureLightBufBGPU, projectileCritExplosionGPU);
                        arraysToCompute[1020].compute(cr, 1022, "renderProjectilesToTexture", renderWidth * renderHeight, renderPatchSizeProjectile /* 8x8 tiles */);
                        flushCtr++;
                        if ((flushCtr % flushStep) == 0)
                            cr.flushLastUsedCommandQueue();

                        if (details)
                            Console.WriteLine("renderShipsToTexture");
                        if (arraysToCompute[1021] == null)
                            arraysToCompute[1021] = textureBuf2C2GPU.nextParam(shipSearchBoxRenderGPU, shipXGPU, shipYGPU, parametersFloatGPU,
                            parametersIntGPU, shipTeamGPU, shipRotationGPU,
                            shipFrontXGPU, shipFrontYGPU, shipStateGPU, shipHitPointsGPU,
                            shipShieldDamagedGPU, shipSelectedGPU, rightClickXYGPU,
                            userCommandGPU, shipSizeTypeGPU, shipModuleXGPU,
                            shipModuleYGPU, shipModuleShieldDamagedGPU,
                            shipModuleStateGPU, shipModuleTypeGPU, shipCorvetteBitmapBytesGPU,
                            textureLightBufRGPU, pixelUsedGPU, textureLightBufGGPU, textureLightBufBGPU,
                            captainRankBytesGPU, crewDataGPU, crewLevelGPU);

                        arraysToCompute[1021].compute(cr, 1023, "renderShipsToTexture", renderWidth * renderHeight, renderPatchSizeShip);
                    }
                    flushCtr++;
                    if ((flushCtr % flushStep) == 0)
                        cr.flushLastUsedCommandQueue();
                }





                if (details)
                    Console.WriteLine("countStepReset");
                shipCountReductionStepGPU.compute(cr, 24, "countStepReset", 1, 1);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();


                if (details)
                    Console.WriteLine("resetShipCounter");
                if (arraysToCompute[22] == null)
                    arraysToCompute[22] = shipCount0PingGPU.nextParam(shipCount1PingGPU, shipCount2PingGPU,
                    shipCount0PongGPU, shipCount1PongGPU, shipCount2PongGPU);

                arraysToCompute[22].compute(cr, 25, "resetShipCounter", nShip, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();


                if (details)
                    Console.WriteLine("countShips");
                if (arraysToCompute[23] == null)
                    arraysToCompute[23] = shipTeamGPU.nextParam(shipStateGPU,
                    shipCount0PingGPU, shipCount1PingGPU, shipCount2PingGPU,
                    shipCount0PongGPU, shipCount1PongGPU, shipCount2PongGPU,shipXGPU,shipYGPU);

                arraysToCompute[23].compute(cr, 26, "countShips", nShip / 2, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (!computePipelineState)
                {
                    crewLevelHistogramGPU.write = false;
                    crewLevelHistogramGPU.writeAll = false;
                    if (details)
                        Console.WriteLine("clearCrewLevelHistogram");
                    crewLevelHistogramGPU.compute(cr, 29869852, "clearCrewLevelHistogram", 16, 16);
                    flushCtr++;
                    if ((flushCtr % flushStep) == 0)
                        cr.flushLastUsedCommandQueue();
                }
                else
                {
                    crewLevelHistogramC2GPU.write = false;
                    crewLevelHistogramC2GPU.writeAll = false;
                    if (details)
                        Console.WriteLine("clearCrewLevelHistogram");
                    crewLevelHistogramC2GPU.compute(cr, 9869852, "clearCrewLevelHistogram", 16, 16);
                    flushCtr++;
                    if ((flushCtr % flushStep) == 0)
                        cr.flushLastUsedCommandQueue();
                }


                if (details)
                {
                    Console.WriteLine("computeCrewLogic");
                    Console.WriteLine(crewLevelGPU.Length);
                    Console.WriteLine(crewExperienceGPU.Length);
                    Console.WriteLine(randSeedGPU.Length);
                    Console.WriteLine(crewEvasionSkillLevelGPU.Length);
                    Console.WriteLine(crewTacticalCriticalHitSkillLevelGPU.Length);
                    Console.WriteLine(crewFastLearningSkillLevelGPU.Length);
                }
                if (arraysToCompute[24] == null)
                    arraysToCompute[24] = crewLevelGPU.nextParam(crewExperienceGPU, randSeedGPU,
                        crewEvasionSkillLevelGPU, crewTacticalCriticalHitSkillLevelGPU,
                        crewFastLearningSkillLevelGPU);
                arraysToCompute[24].compute(cr, 9869851, "computeCrewLogic", nShip * nShipCrew, localSize);
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();





                if (!computePipelineState)
                {
                    if (details)
                        Console.WriteLine("crewLevelHistogram");

                    if (arraysToCompute[25] == null)
                        arraysToCompute[25] = crewDataGPU.nextParam(crewLevelGPU, crewLevelHistogramGPU, 
                            shipStateGPU, shipTeamGPU,shipXGPU,shipYGPU);
                    arraysToCompute[25].compute(cr, 39869853, "crewLevelHistogram", nShip * nShipCrew, localSize /* >= 16 */);
                    flushCtr++;
                    if ((flushCtr % flushStep) == 0)
                        cr.flushLastUsedCommandQueue();
                }
                else
                {
                    if (details)
                        Console.WriteLine("crewLevelHistogram");

                    if (arraysToCompute[26] == null)
                        arraysToCompute[26] = crewDataGPU.nextParam(crewLevelGPU, crewLevelHistogramC2GPU, 
                            shipStateGPU, shipTeamGPU, shipXGPU, shipYGPU);
                    arraysToCompute[26].compute(cr, 9869853, "crewLevelHistogram", nShip * nShipCrew, localSize /* >= 16 */);
                    flushCtr++;
                    if ((flushCtr % flushStep) == 0)
                        cr.flushLastUsedCommandQueue();
                }

                int nShipDividedValue = nShip / 4;
                for (int m = 0; nShipDividedValue >= 1; nShipDividedValue /= 2, m++)
                {
                    if ((m % 2) == 0)
                    {
                        if (nShipDividedValue > localSize)
                        {
                            if (details)
                                Console.WriteLine("countShipsPing");

                            shipCount0PingGPU.nextParam(shipCount1PingGPU, shipCount2PingGPU,
                                shipCount0PongGPU, shipCount1PongGPU, shipCount2PongGPU, shipCountReductionStepGPU).compute(cr, 27, "countShipsPing", nShipDividedValue, localSize);
                        }
                        else
                        {
                            if (details)
                                Console.WriteLine("countShipsPing");
                            shipCount0PingGPU.nextParam(shipCount1PingGPU, shipCount2PingGPU,
                                shipCount0PongGPU, shipCount1PongGPU, shipCount2PongGPU, shipCountReductionStepGPU).compute(cr, 28, "countShipsPing", nShipDividedValue, nShipDividedValue);
                        }
                        flushCtr++;
                        if ((flushCtr % flushStep) == 0)
                            cr.flushLastUsedCommandQueue();

                        if (details)
                            Console.WriteLine("countStepIncrement");
                        shipCountReductionStepGPU.compute(cr, 29, "countStepIncrement", 1, 1);

                    }
                    else
                    {
                        if (nShipDividedValue > localSize)
                        {
                            if (details)
                                Console.WriteLine("countShipsPong");
                            shipCount0PingGPU.nextParam(shipCount1PingGPU, shipCount2PingGPU,
                                shipCount0PongGPU, shipCount1PongGPU, shipCount2PongGPU, shipCountReductionStepGPU).compute(cr, 30, "countShipsPong", nShipDividedValue, localSize);
                        }
                        else
                        {
                            if (details)
                                Console.WriteLine("countShipsPong");
                            shipCount0PingGPU.nextParam(shipCount1PingGPU, shipCount2PingGPU,
                                shipCount0PongGPU, shipCount1PongGPU, shipCount2PongGPU, shipCountReductionStepGPU).compute(cr, 31, "countShipsPong", nShipDividedValue, nShipDividedValue);
                        }
                        flushCtr++;
                        if ((flushCtr % flushStep) == 0)
                            cr.flushLastUsedCommandQueue();

                        if (details)
                            Console.WriteLine("countStepIncrement");
                        shipCountReductionStepGPU.compute(cr, 32, "countStepIncrement", 1, 1);
                    }
                }
                flushCtr++;
                if ((flushCtr % flushStep) == 0)
                    cr.flushLastUsedCommandQueue();

                if (details)
                    Console.WriteLine("copyNumberOfShips");
                if (!computePipelineState)
                {
                    numberOfShipsGPU.write = false;
                    numberOfShipsGPU.writeAll = false;
                }
                else
                {
                    numberOfShipsC2GPU.write = false;
                    numberOfShipsC2GPU.writeAll = false;
                }

                shipCount0PingGPU.nextParam(shipCount1PingGPU, shipCount2PingGPU,
                   shipCount0PongGPU, shipCount1PongGPU, shipCount2PongGPU, ((!computePipelineState)?numberOfShipsGPU:numberOfShipsC2GPU)).compute(cr, (((!computePipelineState))?10033:33), "copyNumberOfShips", 1, 1);




                if (!details)
                    cr.enqueueMode = false;

                swComputeTiming.Stop();
                float mult = 0.0f;
                if (renderWidth < 1920)
                    mult = 14.0f;
                else if (renderWidth == 1920)
                    mult = 14.0f * 7.0f;
                else if (renderWidth == 2560)
                    mult = 14.0f * 7.0f * 3.5f;

                calcPoint+= mult * ((numberOfShipsGPU[0]+ numberOfShipsGPU[1]+ numberOfShipsGPU[2])/ (double) nShip)/ (/*swComputeTiming.Elapsed.TotalMilliseconds*/ deltaT+0.01);
                swComputeTiming.Reset();
            }
        }
        double calcPoint = 0;
        public double getCalcPoint()
        {
            return calcPoint;
        }
        public void setCurrentScale(float scale)
        {
            lock (runLock)
            {
                parametersFloatGPU[0] = scale;
                parametersFloatGPU[8] = scale;
            }
        }

        public void setMouseLeftClick(bool clc)
        {
            parametersIntGPU[0] = (clc?1:0);
        }

        public void setShowHardpointsView(bool sh)
        {
            parametersIntGPU[12] = (sh?1:0);
        }

        public void setShowCaptainLevelView(bool sh)
        {
            parametersIntGPU[13] = (sh ? 1 : 0);
        }

        public void addTranslationXWithCurrentScale(float sc)
        {
            lock (runLock)
            {
                parametersFloatGPU[1] += sc * parametersFloatGPU[0];
            }
        }

        public void addTranslationYWithCurrentScale(float sc)
        {
            lock (runLock)
            {
                parametersFloatGPU[2] += sc * parametersFloatGPU[0];
            }
        }

        public void setNumCaptains(int num)
        {
            lock (runLock)
            {
                parametersIntGPU[14] = num;
            }
        }

        public void setCurrentMouseXByClick(float mouseX)
        {
            lock (runLock)
            { parametersFloatGPU[3] = mouseX; }
        }

        public void setCurrentMouseYByClick(float mouseY)
        {
            lock (runLock)
            { parametersFloatGPU[4] = mouseY; }
        }

        public void setMouseMovementX(float mouseX)
        {
            lock (runLock)
            { parametersFloatGPU[5] = mouseX; }
        }

        public void setMouseMovementY(float mouseY)
        {
            lock (runLock)
            { parametersFloatGPU[6] = mouseY; }
        }

        public void setMouseRightClick(bool rc)
        {
            lock (runLock)
            { parametersFloatGPU[7] = (rc ? 1.0f : 0.0f); }
        }

        /// <summary>
        /// must be power of 2
        /// </summary>
        /// <param name="n0"></param>
        public void setNumShipsThenAutoMapSize(int n0)
        {
            nShip = n0;
            int sqrt = (int)Math.Sqrt(n0);
            int dim = sqrt * 55;
            dim += (512 - dim % 512);
            mapWidth = (dim);
            mapHeight = (dim);
            nBox = ((mapHeight / searchBoxSize) * (mapWidth / searchBoxSize));
        }

        object texturePipelineStateLock = new object();

        bool computePipelineState = true;
        public void nextTexturePipelineStep()
        {
            lock (texturePipelineStateLock)
            {
                texturePipelineState = !texturePipelineState;
                computePipelineState = texturePipelineState;
            }
        }

        bool texture1Ready = false;
        bool texture2Ready = false;

        bool texture1Used = false;
        bool texture2Used = false;
        public bool texturesReady()
        {
            lock (texturePipelineStateLock)
            {
                bool result= (texture1Ready && texture2Ready) && (!(texturePipelineState?texture1Used:texture2Used));

                return result;
            }
        }


        public Bitmap getCurrentTextureOfPipelineOutput()
        {
            bool curState = false;
            lock (texturePipelineStateLock)
            {
                curState = texturePipelineState;
                if (texturePipelineState)
                    texture1Used = true;
                else
                    texture2Used = true;
            }

            if (curState)
            {
                lock (textureLock2)
                {
                    return textureOld;
                }
            }
            else
            {
                lock (textureLock1)
                {
                    return texture;
                }
            }
        }

        object textureLock1 = new object();
        object textureLock2 = new object();
        public void copyTexturesDoubleBuffered()
        {
  
            if (computePipelineState)
            {
                if (texturePipelineState)
                {
                    lock(texture)
                    lock (textureLock1)
                    {
                        bmpData = texture.LockBits(new Rectangle(0, 0, texture.Width, texture.Height), ImageLockMode.WriteOnly, texture.PixelFormat);
                        IntPtr ptr = bmpData.Scan0;
                        if (texturePipelineState)
                        {
                            textureBuf2GPU.CopyTo(textureBuf2, 0);
                            Marshal.Copy(textureBuf2, 0, ptr, numBytes);
                        }
                        else
                        {
                            textureBufGPU.CopyTo(textureBuf, 0);
                            Marshal.Copy(textureBuf, 0, ptr, numBytes);
                        }
                        if (bmpData != null)
                            texture.UnlockBits(bmpData);
                        bmpData = null;
                    }

                    lock (texturePipelineStateLock)
                    {
                        texture2Ready = true;
                    }
                }
                else
                {
                    lock(textureOld)
                    lock (textureLock2)
                    {
                        bmpDataOld = textureOld.LockBits(new Rectangle(0, 0, textureOld.Width, textureOld.Height), ImageLockMode.WriteOnly, textureOld.PixelFormat);
                        IntPtr ptr = bmpDataOld.Scan0;
                        if (texturePipelineState)
                        {
                            textureBuf2GPU.CopyTo(textureBuf2, 0);
                            Marshal.Copy(textureBuf2, 0, ptr, numBytes);
                        }
                        else
                        {
                            textureBufGPU.CopyTo(textureBuf, 0);
                            Marshal.Copy(textureBuf, 0, ptr, numBytes);
                        }
                        if (bmpDataOld != null)
                            textureOld.UnlockBits(bmpDataOld);
                        bmpDataOld = null;
                    }
                    lock (texturePipelineStateLock)
                    {
                        texture1Ready = true;
                    }
                }
            }
            else
            {
                if (texturePipelineState)
                {
                    lock(texture)
                    lock (textureLock1)
                    {
                        bmpData = texture.LockBits(new Rectangle(0, 0, texture.Width, texture.Height), ImageLockMode.WriteOnly, texture.PixelFormat);
                        IntPtr ptr = bmpData.Scan0;
                        if (texturePipelineState)
                        {
                            textureBuf2C2GPU.CopyTo(textureBuf2C2, 0);
                            Marshal.Copy(textureBuf2C2, 0, ptr, numBytes);
                        }
                        else
                        {
                            textureBufC2GPU.CopyTo(textureBufC2, 0);
                            Marshal.Copy(textureBufC2, 0, ptr, numBytes);
                        }
                        if (bmpData != null)
                            texture.UnlockBits(bmpData);
                        bmpData = null;
                    }

                    lock (texturePipelineStateLock)
                    {
                        texture2Ready = true;
                    }
                }
                else
                {
                    lock(textureOld)
                    lock (textureLock2)
                    {
                        bmpDataOld = textureOld.LockBits(new Rectangle(0, 0, textureOld.Width, textureOld.Height), ImageLockMode.WriteOnly, textureOld.PixelFormat);
                        IntPtr ptr = bmpDataOld.Scan0;
                        if (texturePipelineState)
                        {
                            textureBuf2C2GPU.CopyTo(textureBuf2C2, 0);
                            Marshal.Copy(textureBuf2C2, 0, ptr, numBytes);
                        }
                        else
                        {
                            textureBufC2GPU.CopyTo(textureBufC2, 0);
                            Marshal.Copy(textureBufC2, 0, ptr, numBytes);
                        }
                        if (bmpDataOld != null)
                            textureOld.UnlockBits(bmpDataOld);
                        bmpDataOld = null;
                    }
                    lock (texturePipelineStateLock)
                    {
                        texture1Ready = true;
                    }
                }
            }
        }

        public void detailEnable(bool det)
        {
            details = det;
        }

        bool disposed { get; set; }
        public void dispose()
        {
            if (!disposed)
            {
                lock (texturePipelineStateLock)
                {
                    lock (textureLock1)
                    {
                        lock (textureLock2)
                        {
                            lock (runLock)
                            {
                                if (cr != null)
                                    cr.dispose();
                                swEngine.Stop();
                                GC.Collect();
                                Console.WriteLine("Compute resources disposed.");
                                disposed = true;
                            }
                        }
                    }
                }
            }

        }

        ~ComputeEngine()
        {
           
           
            dispose();
        }
    }
}
