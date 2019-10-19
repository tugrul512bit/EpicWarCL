
// ship rotations in degrees
// projectile rotations in radians

#define PROJECTILE_FORWARD 1
#define PROJECTILE_EXPLOSION 2
#define PROJECTILE_DEAD 4

#define PROJECTILE_RENDER_PATCH_SIZE @@renderPatchSizeProjectile@@
#define PROJECTILE_RENDER_PATCH_SIZE_SQRT @@renderPatchSizeSqrtProjectile@@

#define SHIP_RENDER_PATCH_SIZE @@renderPatchSizeShip@@
#define SHIP_RENDER_PATCH_SIZE_SQRT @@renderPatchSizeSqrtShip@@

#define RENDER_WIDTH @@renderWidth@@
#define RENDER_HEIGHT @@renderHeight@@

#define N_SHIP_BOX_LAYER @@((mapHeight/searchBoxSize)*(mapWidth/searchBoxSize))@@
#define N_PROJECTILE_BOX_LAYER @@((mapHeight/projectileSearchBoxSize)*(mapWidth/projectileSearchBoxSize))@@

#define N_LOCAL_SIZE @@nLocalSize@@

#define MAX_PROJECTILES_PER_SHIP @@nShipProjectiles@@
#define MAX_MODULES_PER_SHIP @@nShipModules@@
#define MAX_CREW_PER_SHIP @@nShipCrew@@

#define SHIP_SEARCH_BOX_SIZE @@searchBoxSize@@
#define SHIP_SIZE @@shipSize@@
#define PROJECTILE_SIZE @@projectileSize@@

#define SHIP_SIZE_TYPE_CORVETTE 0
#define SHIP_SIZE_TYPE_FRIGATE 1
#define SHIP_SIZE_TYPE_DESTROYER 2
#define SHIP_SIZE_TYPE_CRUISER 3
#define SHIP_SIZE_TYPE_BATTLESHIP 4

#define N_SHIP_MAX @@nShip@@

// map height = map width
#define MAP_WIDTH @@mapWidth@@
#define MAP_HEIGHT @@mapWidth@@

#define CENTER_OF_MAP_X (MAP_WIDTH/2)
#define CENTER_OF_MAP_Y (MAP_WIDTH/2)

#define SKY_BITMAP_WIDTH  @@skyWidth@@
#define SKY_BITMAP_HEIGHT @@skyHeight@@
 
#define WEAPON_RANGE 140
#define TARGET_DISTANCE	(WEAPON_RANGE+SHIP_SIZE*2)

#define SHIP_COMMAND_MOVE 1

// degrees
#define SHIP_ROTATION_ANGLE_TOLERANCE (3.0f)


#define SHIP_MODULE_TYPE_POWER_SOURCE @@moduleTypePower@@
#define SHIP_MODULE_TYPE_ENERGY_CAPACITOR @@moduleTypeEnergy@@
#define SHIP_MODULE_TYPE_SHIELD_GENERATOR @@moduleTypeShield@@
#define SHIP_MODULE_TYPE_CANNON_TURRET @@moduleTypeTurret@@
#define SHIP_MODULE_TYPE_CANNON_TURRET_TURBO @@moduleTypeTurretTurbo@@

#define SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE (16 + @@moduleTypePower@@)
#define SHIP_MODULE_TYPE_ENERGY_CAPACITOR_FRIGATE (16 + @@moduleTypeEnergy@@)
#define SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE (16 + @@moduleTypeShield@@)
#define SHIP_MODULE_TYPE_CANNON_TURRET_FRIGATE (16 + @@moduleTypeTurret@@)
#define SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE (16 + @@moduleTypeTurretTurbo@@)

#define SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER (32 + @@moduleTypePower@@)
#define SHIP_MODULE_TYPE_ENERGY_CAPACITOR_DESTROYER (32 + @@moduleTypeEnergy@@)
#define SHIP_MODULE_TYPE_SHIELD_GENERATOR_DESTROYER (32 + @@moduleTypeShield@@)
#define SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER (32 + @@moduleTypeTurret@@)
#define SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER (32 + @@moduleTypeTurretTurbo@@)

#define SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER (48 + @@moduleTypePower@@)
#define SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER (48 + @@moduleTypeEnergy@@)
#define SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER (48 + @@moduleTypeShield@@)
#define SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER (48 + @@moduleTypeTurret@@)
#define SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_CRUISER (48 + @@moduleTypeTurretTurbo@@)

#define SHIP_MODULE_STATE_WORKING 1
#define SHIP_MODULE_STATE_DEAD 2

// 2 energy per turn for 15 turns = 1 projectile fire
#define SHIP_MODULE_CANNON_TURRET_ENERGY 30
#define SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE 2 

// 4 energy per turn for 20 turns = 1 projectile fire
#define SHIP_MODULE_CANNON_TURRET_ENERGY_FRIGATE 80
#define SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE_FRIGATE 4 

// 8 energy per turn for 25 turns = 1 projectile fire
#define SHIP_MODULE_CANNON_TURRET_ENERGY_DESTROYER 200
#define SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE_DESTROYER 8 

// 16 energy per turn for 30 turns = 1 projectile fire
#define SHIP_MODULE_CANNON_TURRET_ENERGY_CRUISER 480
#define SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE_CRUISER 16 

// 1 energy per turn for 6 turns = 1 projectile fire
#define SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY 6
#define SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE 1 

// 2 energy per turn for 7 turns = 1 projectile fire
#define SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_FRIGATE 14
#define SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE_FRIGATE 2 

// 4 energy per turn for 8 turns = 1 projectile fire
#define SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_DESTROYER 32
#define SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE_DESTROYER 4 

// 8 energy per turn for 9 turns = 1 projectile fire
#define SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_CRUISER 72
#define SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE_CRUISER 8 

// 1 energy per turn for 100 turns = 1 shield regeneration
#define SHIP_MODULE_SHIELD_GENERATOR_ENERGY 100

// 2 energy per turn for 50 turns = 1 shield regeneration
#define SHIP_MODULE_SHIELD_GENERATOR_ENERGY_FRIGATE 100

// 4 energy per turn for 25 turns = 1 shield regeneration
#define SHIP_MODULE_SHIELD_GENERATOR_ENERGY_DESTROYER 100

// 10 energy per turn for 10 turns = 1 shield regeneration
#define SHIP_MODULE_SHIELD_GENERATOR_ENERGY_CRUISER 100

// extra shield protection radius with type
#define SHIP_SHIELD_DISTANCE @@shieldDistance@@
#define SHIP_MODULE_SHIELD_GENERATOR_SHIELD_RADIUS 0
#define SHIP_MODULE_SHIELD_GENERATOR_FRIGATE_SHIELD_RADIUS 7
#define SHIP_MODULE_SHIELD_GENERATOR_DESTROYER_SHIELD_RADIUS 11
#define SHIP_MODULE_SHIELD_GENERATOR_CRUISER_SHIELD_RADIUS 14


// captain
#define CREW_STATE_EVASIVE_MANEUVER 1

// 2nd captain, gunnery officer
#define CREW_STATE_TARGET_PREDICTION 2

// technician, engineer
#define CREW_STATE_REPAIR 4

// marine. increases attacking event initatives, attack bonuses, defense bonuses ....
#define CREW_STATE_BOARD_ATTACK 8

// gunnery officer, marine. increases defending event initiatives, attack bonuses, defense bonuses, ...
#define CREW_STATE_BOARD_DEFEND 16

// all crews constant starting hp before the 1d10 class hp of first level
#define CREW_HP_BONUS_START 5


#define CREW_TYPE_FIRST_CAPTAIN 0
#define CREW_TYPE_SECOND_CAPTAIN 1
#define CREW_TYPE_ENGINEER 2
#define CREW_TYPE_TECHNICIAN 3
#define CREW_TYPE_MARINE 4
#define CREW_TYPE_GUNNERY_OFFICER 5

// d4
#define CREW_CAPTAIN_HP_PER_LEVEL 4


// d6
#define CREW_ENGINEER_HP_PER_LEVEL 6


// 1d10 + 1
#define CREW_MARINE_HP_PER_LEVEL 10


// 1d8
#define CREW_TECHNICIAN_HP_PER_LEVEL 8


// 1d8
#define CREW_GUNNERY_OFFICER_HP_PER_LEVEL 8

#define CREW_CAPTAIN_ATTACK_BONUS_PER_4_LEVELS 2
#define CREW_ENGINEER_ATTACK_BONUS_PER_4_LEVELS 1
#define CREW_TECHNICIAN_ATTACK_BONUS_PER_4_LEVELS 2
#define CREW_MARINE_ATTACK_BONUS_PER_4_LEVELS 4
#define CREW_GUNNERY_OFFICER_ATTACK_BONUS_PER_4_LEVELS 3

#define CREW_CAPTAIN_DEFENSE_BONUS_PER_4_LEVELS 2
#define CREW_ENGINEER_DEFENSE_BONUS_PER_4_LEVELS 1
#define CREW_TECHNICIAN_DEFENSE_BONUS_PER_4_LEVELS 2
#define CREW_MARINE_DEFENSE_BONUS_PER_4_LEVELS 4
#define CREW_GUNNERY_OFFICER_DEFENSE_BONUS_PER_4_LEVELS 3

// to use as randum number generation function
// marine laser rifle:   5-17 in d20
// marine laser pistol:  1-4 in d20
// marine plasma rocket: 18-20 in d20
// gunnery officer pistol: 1-10 in d20
// gunnery officer rifle: 11-20 in d20
// technician pistol: 1-15 in d20
// technician rifle: 16-20 in d20
// others pistol only
#define CREW_WEAPON_LASER_RIFLE_DAMAGE d6
#define CREW_WEAPON_LASER_PISTOL_DAMAGE d4
#define CREW_WEAPON_PLASMA_ROCKET_LAUNCHER_DAMAGE d12

__constant int offsets0[4]={0,400,2000,5600 };  // corvette:20x20(0 to 400), frigate:40x40 (400 to 2000), destroyer:60x60 (2000 to 5600), cruiser: 80x80 (5600 to 12000) 
__constant int offsets1[3]={0,12000,24000 };// red:0 to 5600, green: 5600 to 11200, blue: 11200 to 16800
__constant int shipSizes[4]={20,40,60,80};

float radianToDegree(float radi)
{ 
	return radi * ( (360.0f) / ( 3.14f * 2.0f )  );
}

float degreeToRadian(float radi)
{ 
	return radi * (( 3.14f * 2.0f ) / (360.0f)  );
}

// core of random number generation
uint tw_hash(uint seed)
{
                seed = (seed ^ 61) ^ (seed >> 16);
                seed *= 9;
                seed = seed ^ (seed >> 4);
                seed *= 0x27d4eb2d;
                seed = seed ^ (seed >> 15);
                return seed;
}
            
void tw_rnd_0(__global unsigned int  * restrict intSeeds,int id)                
{
                uint maxint=0;
                maxint--;
                uint rndint=tw_hash(id);
                intSeeds[id]=rndint;
}

float tw_rnd(__global unsigned int * restrict  intSeeds,int id)                
{
                uint maxint=0;
                maxint--;
				mem_fence(CLK_GLOBAL_MEM_FENCE);
                uint rndint=tw_hash(intSeeds[id]);
                intSeeds[id]=rndint;
				mem_fence(CLK_GLOBAL_MEM_FENCE);
                return ((float)rndint)/(float)maxint;
}



// initialize each thread's own random number seed
__kernel void rnd_0(__global unsigned int * restrict  intSeeds)
{
                int id=get_global_id(0);
                tw_rnd_0(intSeeds,id);     
}

// get a new random value by each thread
__kernel void rnd_1(__global unsigned int * restrict  intSeeds)
{
                int id=get_global_id(0);
                float randomFloat=tw_rnd(intSeeds,id);
}


int d4(__global unsigned int * restrict  intSeeds, int id)
{ 
	return 1+floor(tw_rnd(intSeeds,id)*4.0f);
}

int d6(__global unsigned int * restrict  intSeeds, int id)
{ 
	return 1+floor(tw_rnd(intSeeds,id)*6.0f);
}

int d8(__global unsigned int *  restrict intSeeds, int id)
{ 
	return 1+floor(tw_rnd(intSeeds,id)*8.0f);
}

int d10(__global unsigned int * restrict  intSeeds, int id)
{ 
	return 1+floor(tw_rnd(intSeeds,id)*10.0f);
}

int d12(__global unsigned int * restrict  intSeeds, int id)
{ 
	return 1+floor(tw_rnd(intSeeds,id)*12.0f);
}

int d20(__global unsigned int * restrict  intSeeds, int id)
{ 
	return 1+floor(tw_rnd(intSeeds,id)*20.0f);
}

int dice(int maxD, __global unsigned int *  restrict intSeeds, int id)
{ 
	return 1+floor(tw_rnd(intSeeds,id)*((float)maxD));
}

// initialize map (ships)
__kernel void initShips(__global float *  restrict shipX, __global float *  restrict shipY, 
                        __global uchar *  restrict shipState, __global float *  restrict shipRotation, 
                        __global uchar *  restrict shipTeam, __global unsigned int *  restrict randSeeds,
						__global int *  restrict shipHp,__global float * restrict  shipXOld, 
						__global float *  restrict shipYOld, __global int * restrict  parametersInt,
						__global uchar * restrict shipSizeType,__global int *  restrict shipHpMax)
{
    float mapWidth=@@mapWidth@@;
    float mapHeight=@@mapHeight@@;

    int i=get_global_id(0); // ship id

	uchar team = (int)((tw_rnd(randSeeds,i)*2.9999f));

	shipTeam[i]=team;
	if(team==0)
	{
		shipX[i]=0.001f+tw_rnd(randSeeds,i)*mapWidth*0.498f;
		shipY[i]=tw_rnd(randSeeds,i)*mapHeight;
		shipRotation[i]=tw_rnd(randSeeds,i)*30.0f-15.0f;
	}
	else if(team==1)
	{
		shipX[i]=mapWidth*0.501f+ tw_rnd(randSeeds,i)*mapWidth*0.498f;
		shipY[i]=mapHeight*0.5f + tw_rnd(randSeeds,i)*mapHeight*0.5f;
		shipRotation[i]=tw_rnd(randSeeds,i)*30.0f+165.0f;
	}
	else if(team==2)
	{
		shipX[i]=mapWidth*0.501f+tw_rnd(randSeeds,i)*mapWidth*0.498f;
		shipY[i]=tw_rnd(randSeeds,i)*mapHeight*0.5f;
		shipRotation[i]=tw_rnd(randSeeds,i)*30.0f+165.0f;
	}

	int shipTypeTmp=dice(100,randSeeds,i) ;
	if((shipTypeTmp>97))
	{ 
		shipSizeType[i]=SHIP_SIZE_TYPE_CRUISER; 
	}
    else if(shipTypeTmp>92)
	{ 
		shipSizeType[i]=SHIP_SIZE_TYPE_DESTROYER; 
	}
	else if(shipTypeTmp>75)
	{ 
		shipSizeType[i]=SHIP_SIZE_TYPE_FRIGATE; 
	}
	else 
	{ 
		shipSizeType[i]=SHIP_SIZE_TYPE_CORVETTE; 
	}
	mem_fence(CLK_GLOBAL_MEM_FENCE);
    shipState[i]=PROJECTILE_FORWARD;
	//int diceRoll=0;
	int nDice=0;
	int total=0;
	if(shipSizeType[i]==SHIP_SIZE_TYPE_CORVETTE)
	{ 
		nDice=7;
		for(int id=0; id<nDice;id++ )
			total+=d4(randSeeds,i);
	}
	else if(shipSizeType[i]==SHIP_SIZE_TYPE_FRIGATE)
	{ 
		nDice=10;
		for(int id=0; id<nDice;id++ )
			total+=d6(randSeeds,i);
	}
	else if(shipSizeType[i]==SHIP_SIZE_TYPE_DESTROYER)
	{ 
		nDice=15;
		for(int id=0; id<nDice;id++ )
			total+=d8(randSeeds,i);
	}
	else if(shipSizeType[i]==SHIP_SIZE_TYPE_CRUISER)
	{ 
		nDice=20;
		for(int id=0; id<nDice;id++ )
			total+=d10(randSeeds,i);
	}
	shipHp[i]=total;
	shipHpMax[i]=total;
	shipXOld[i]=shipX[i];
	shipYOld[i]=shipY[i];


}


// ship state compute
// todo: make frametime dependent
__kernel void incrementShipStates(__global int * restrict  shipShieldMax, 
__global int * restrict  shipShield, __global int * restrict shipShieldRecharge,
__global float * restrict  frameTime)
{ 
	int i=get_global_id(0);
	/*
	int currentShield=shipShield[i];
	int shieldCharge=shipShieldRecharge[i];

	if(currentShield<0)
		currentShield=0;

	if(currentShield<shipShieldMax[i])
	{
		if(shieldCharge==100)
		{ 
			
			shipShield[i]=currentShield+1;
			shipShieldRecharge[i]=0;
		}
		else
		{ 
			
		    shipShieldRecharge[i]=shieldCharge+1;
		}
	}
	*/
}


// initialize map (projectiles)
__kernel void initShipProjectiles(__global float * restrict  pX, __global float * restrict  pY, 
                        __global uchar * restrict  pState, __global float * restrict  pRotation,
						__global int * restrict projectileEvadedShipId)
{
    int maxProjectilesPerShip=@@nShipProjectiles@@;
    int i=get_global_id(0); // ship id
    for(int j=0;j<maxProjectilesPerShip;j++)
    {
        pX[j*N_SHIP_MAX+i]=0;
        pY[j*N_SHIP_MAX+i]=0;
        pState[j*N_SHIP_MAX+i]=PROJECTILE_DEAD; // dead
        pRotation[j*N_SHIP_MAX+i]=i*19;
		projectileEvadedShipId[j*N_SHIP_MAX+i]=-1; // reset evasion
    }
}



bool isCrewAlive(uchar crewData)
{ 
	return (crewData&1);
}

bool isCrewFirstCaptain(uchar crewData)
{ 
	return (((crewData>>1)&7)==CREW_TYPE_FIRST_CAPTAIN);
}

bool isCrewSecondCaptain(uchar crewData)
{ 
	return (((crewData>>1)&7)==CREW_TYPE_SECOND_CAPTAIN);
}

bool isCrewEngineer(uchar crewData)
{ 
	return (((crewData>>1)&7)==CREW_TYPE_ENGINEER);
}

bool isCrewTechnician(uchar crewData)
{ 
	return (((crewData>>1)&7)==CREW_TYPE_TECHNICIAN);
}

bool isCrewMarine(uchar crewData)
{ 
	return (((crewData>>1)&7)==CREW_TYPE_MARINE);
}

bool isCrewGunneryOfficer(uchar crewData)
{ 
	return (((crewData>>1)&7)==CREW_TYPE_GUNNERY_OFFICER);
}

uchar generateFirstCaptain()
{ 
	uchar result=(1 | (CREW_TYPE_FIRST_CAPTAIN<<1));
	return result;
}

uchar generateSecondCaptain()
{ 
	uchar result=(1 | (CREW_TYPE_SECOND_CAPTAIN<<1));
	return result;
}


uchar generateMarine()
{ 
	uchar result=(1 | (CREW_TYPE_MARINE<<1));
	return result;
}

uchar firstCaptainStartHp(__global unsigned int * randBuf, int id)
{ 
	return dice(CREW_CAPTAIN_HP_PER_LEVEL,randBuf,id);
}

uchar secondCaptainStartHp(__global unsigned int * randBuf, int id)
{ 
	return dice(CREW_CAPTAIN_HP_PER_LEVEL,randBuf,id);
}

uchar marineStartHp(__global unsigned int * randBuf, int id)
{ 
	return dice(CREW_MARINE_HP_PER_LEVEL,randBuf,id);
}



// all active ships get a captain as default
// crew data
// crew bits(lsb=0): 0=alive(1)/dead(0), 1=active(1)/disabled(0), 2-3-4=type(000=1st captain,001=2nd captain, 010=engineer, 011=technician, 100=marine, 101=gunnery officer)
// crew bits: 5,6=state(on duty 00, resisting a boarding 01, boarding 10)
// crew bit: 7=reserved
// ship0crew0, ship1crew0, ... shipN-1crew0, ship0crew1, .., shipN-1crewM-1 // contiguous access when processing crew(similar to projectiles and modules)
// crew hp data
// bits 0-7: max hitpoints (maximum 256)
// crew temporary hp data
// bits 0-7: current hitpoints (max 256)
__kernel void initShipCrew(	__global uchar * crewData,__global int * crewExperience,
							__global uchar * crewLevel, 
							__global int * crewShipId /* id of ship where crew stays */,
							__global uchar * crewHp, __global uchar * crewTempHp, 
							__global unsigned int * randBuf, 
							__global uchar * crewEvasionSkillLevel,
							__global uchar * crewTacticalCriticalHitSkillLevel,
							__global uchar * crewFastLearningSkillLevel,
							__global int * parametersInt, __global uchar * shipTeam)
{ 
	int i=get_global_id(0); // ship id
	for(int j=0;j<MAX_CREW_PER_SHIP;j++)
	{ 
		uchar character=0;
		uchar hp=0;
		uchar hpTmp=0;
		if(j==0)
		{ 
			// player team
			if(parametersInt[11]==shipTeam[i])
			{ 

				if(j<parametersInt[14])
				{ 
					character=generateFirstCaptain();
					hp=firstCaptainStartHp(randBuf,i);
				}
			}
			else
			{ 
				// other team
				character=generateFirstCaptain();
				hp=firstCaptainStartHp(randBuf,i);
			}
		}
		else
		{ 
			character=generateMarine();
			hp=marineStartHp(randBuf,i);
		}
		hpTmp=hp;
		crewData[i + j * N_SHIP_MAX]=character;


		int experience=d4(randBuf,i);

		crewExperience[i + j * N_SHIP_MAX]=experience; 
		crewLevel[i + j * N_SHIP_MAX]=1; 
		crewShipId[i + j * N_SHIP_MAX]=i;
		crewHp[i + j * N_SHIP_MAX]=hp;
		crewTempHp[i + j * N_SHIP_MAX]=hpTmp;
		crewEvasionSkillLevel[i + j * N_SHIP_MAX]=0;
		crewTacticalCriticalHitSkillLevel[i + j * N_SHIP_MAX]=0;
		crewFastLearningSkillLevel[i + j * N_SHIP_MAX]=0;
	}
}


// clear crew level histogram
__kernel void clearCrewLevelHistogram(__global int * histogram)
{ 
	int i=get_global_id(0);
	histogram[i]=0;
}

// crew level histogram
__kernel void crewLevelHistogram(	__global uchar * crewData, __global uchar * crewLevel, 
									__global int * histogram, __global uchar * shipState,
									__global uchar * shipTeam,__global float * shipX,
									__global float * shipY)
{ 
	int i=get_global_id(0); // crew id
	int iL=get_local_id(0);
	__local int localHistogram[16]; // level 1-16
	int level = crewLevel[i];
	if(iL<16)
		localHistogram[iL]=0;
	barrier(CLK_LOCAL_MEM_FENCE);
	// if ship is alive and is team-0
	if(((shipState[(i%N_SHIP_MAX)]&PROJECTILE_DEAD)==0) && (shipTeam[i%N_SHIP_MAX]==0))
	{ 
		if(isCrewAlive(crewData[i]) && (level<17) &&(level>0) && (isCrewFirstCaptain(crewData[i])))
		{ 
			atomic_add(&localHistogram[level-1],1*((shipX[i%N_SHIP_MAX]>20.0f) && (shipY[i%N_SHIP_MAX]>20.0f) && (shipX[i%N_SHIP_MAX]<((float)MAP_WIDTH-20.0f)) && (shipX[i%N_SHIP_MAX]<((float)MAP_HEIGHT-20.0f))));
		}
	}
	barrier(CLK_LOCAL_MEM_FENCE);
	if(iL<16)
	{ 
		atomic_add(&histogram[iL],localHistogram[iL]);
	}
}

// reset shield animation counter
// todo: make frametime dependent
__kernel void resetShieldAnimation(__global int * restrict  shieldDamaged, __global int * restrict shipModuleShieldDamaged)
{ 
	int i=get_global_id(0); // ship id
	for(int im=0;im<MAX_MODULES_PER_SHIP; im++)
	{ 
		if(shipModuleShieldDamaged[i+N_SHIP_MAX*im]>0)
			shipModuleShieldDamaged[i+N_SHIP_MAX*im]--;

		if(shipModuleShieldDamaged[i+N_SHIP_MAX*im]>32)
			shipModuleShieldDamaged[i+N_SHIP_MAX*im]=32;
	}
}


// reset boxes
__kernel void resetBoxes(__global int * restrict  box,__global int * restrict  renderBox)
{
    int i=get_global_id(0); // box id
    //int maxShips=@@(maxShipsPerBox+1)@@;
    box[i]=0; // ctr=0, no ship in this box
    renderBox[i]=0; // ctr=0, no ship in this box
}

// reset projectile boxes
__kernel void resetProjectileBoxes(__global int * restrict  box)
{
    int i=get_global_id(0); // box id
    //int maxProjectiles=@@(maxProjectilesPerBox+1)@@;
    box[i]=0; // ctr=0, no ship in this box
}

// put ships id to containing boxes
__kernel void putShipsToBoxes(	__global float * restrict x,__global float * restrict y,
								__global int *  restrict box, 
								__global unsigned char * restrict  states,
								__global uchar * restrict shipSizeType,__global int *  restrict renderBox)
{
    int i=get_global_id(0); // ship id
	if(((states[i]&PROJECTILE_DEAD)!=0) && ((states[i]&PROJECTILE_EXPLOSION)==0))
		return;
    int mapMaxX=@@mapWidth@@;
    int mapMaxY=@@mapHeight@@;
    int boxSize=@@searchBoxSize@@;
    int maxShipsPerBox=@@maxShipsPerBox@@;
	//int boxesPerScanLine = (mapMaxX / boxSize);
    int x0=x[i];
    int y0=y[i];

	// for enemy search + collision
    if((x0>25) && (x0<(mapMaxX-25)) && (y0>25) && (y0<(mapMaxY-25)))
    {
        int boxX= x0/boxSize;
        int boxY= y0/boxSize;
        int boxId=boxX + boxY*(mapMaxX/boxSize);
        int shipIdPos=atomic_add(&box[boxId],1);
        if(shipIdPos<maxShipsPerBox)
            box[boxId+(shipIdPos+1)*N_SHIP_BOX_LAYER]=i; // save ship id to empty box slot
    }

	// for render
    if((x0>25) && (x0<(mapMaxX-25)) && (y0>25) && (y0<(mapMaxY-25)))
    {
        int boxX= x0/boxSize;
        int boxY= y0/boxSize;
        int boxId=boxX + boxY*(mapMaxX/boxSize);
        int shipIdPos=atomic_add(&renderBox[boxId],1);
        if(shipIdPos<maxShipsPerBox)
            renderBox[boxId+(shipIdPos+1)*N_SHIP_BOX_LAYER]=i; // save ship id to empty box slot
    }
}

// put projectiles id to containing boxes
__kernel void putProjectilesToBoxes(__global float * restrict x,__global float * restrict y,__global int * restrict  box, __global unsigned char * restrict  states)
{
    int i=get_global_id(0); // projectile id
	if((states[i]&PROJECTILE_DEAD)!=0)
		return;
    int mapMaxX=@@mapWidth@@;
    int mapMaxY=@@mapHeight@@;
    int boxSize=@@projectileSearchBoxSize@@;
    int maxProjectilesPerBox=@@maxProjectilesPerBox@@;
    int x0=x[i];
    int y0=y[i];

    if((x0>25) && (x0<(mapMaxX-25)) && (y0>25) && (y0<(mapMaxY-25)))
    {
        int boxX= x0/boxSize;
        int boxY= y0/boxSize;
        int boxId=boxX + boxY*(mapMaxX/boxSize);
        int projectileIdPos=atomic_add(&box[boxId],1);
        if(projectileIdPos<maxProjectilesPerBox)
            box[boxId+(projectileIdPos+1)*N_PROJECTILE_BOX_LAYER]=i; // save ship id to empty box slot
    }
}

// reset force on ships
__kernel void resetForce(__global float * restrict  xTmp, __global float * restrict yTmp)
{ 
    int i=get_global_id(0); // ship id
	xTmp[i] = 0.0f;
	yTmp[i] = 0.0f;
}

// game logic: ship movement by engines or outer intervention
// capped at a maximum velocity of sqrt(2)
__kernel void moveShips(__global float * restrict  xTmp, __global float * restrict yTmp, __global float * restrict  rotation, 
						__global unsigned char * restrict  shipStates, __global float * restrict  xOld, 
						__global float * restrict yOld, __global float * restrict engineFrameTime)
{
    int i=get_global_id(0); // ship id
	if((shipStates[i]&PROJECTILE_DEAD)!=0)
		return;
	if((shipStates[i]&PROJECTILE_FORWARD)!=0)
	{ 
		float rot=rotation[i];
		//float dx = x[i]-xOld[i];
		//float dy = y[i]-yOld[i];
		//if((dx*dx + dy*dy) < 0.3f)
		{ 
			//if(engineFrameTime[0]>0.01f)
			{ 
				xTmp[i] += /* ((engineFrameTime[0])) * */ 15000.0f * cos((rot / 360.0f) * (3.14f * 2.0f));
				yTmp[i] += /* ((engineFrameTime[0])) * */ 15000.0f * sin((rot / 360.0f) * (3.14f * 2.0f));
			}
		}
	}
}

// game logic: ship movement by verlet integration (physics)
__kernel void moveShipsVerlet(__global float * restrict  x, __global float * restrict y, __global float *  restrict xOld,
							 __global float * restrict yOld,__global float * restrict xTmp,__global float * restrict yTmp,
							 __global unsigned char * restrict shipStates, __global float * restrict frameTime,
							 __global float * xBump, __global float *yBump)
{ 
	int i=get_global_id(0);
	float a=0.0001f;
	float ft=frameTime[0]/200.0f;
	float ftOld=frameTime[4]/200.0f;
	float ftMultiplier = 0.0f;

	if(frameTime[4]<0.01f)
		ftMultiplier=0.0f;
	else
		ftMultiplier=frameTime[0]/frameTime[4];
	if((shipStates[i]&PROJECTILE_DEAD)!=0)
		return;
	float x0=x[i];
	float y0=y[i];

	//x[i] = x0 * 1.994f - xOld[i]*0.994f; 

	x[i] = xBump[i]*2.0f+  x0 + (x0-xOld[i])*0.8f/* * 0.9999f * ftMultiplier * ft*/ +xTmp[i]*a*ft;

	//y[i] = y0 * 1.994f - yOld[i]*0.994f;

	y[i] = yBump[i]*2.0f+ y0 + (y0-yOld[i])*0.8f /** 0.9999f * ftMultiplier * ft*/ +yTmp[i]*a*ft;
	
	xOld[i]=x0;
	yOld[i]=y0;
}



// game logic: exclusion force 
// todo: make bump time dependent.(if xTmp is not xBump)
__kernel void checkShipShipCollision(__global float * restrict  x, __global float * restrict y, __global float * restrict  xTmp, 
									 __global float * restrict  yTmp, __global int * restrict  box,
									 __global uchar * restrict shipSizeType, __global unsigned char * shipStates)
{ 
	int i=get_global_id(0); // ship id
	if((shipStates[i]&PROJECTILE_DEAD)!=0)
		return;

	int boxSize=@@searchBoxSize@@;
	int mapMaxX=@@mapWidth@@;
	float xf=x[i];
    float yf=y[i];
	int x0=xf;
    int y0=yf;

    //int found=0;

                                                                                

    int boxX= x0/boxSize;
    int boxY= y0/boxSize;
    int boxId=boxX + boxY*(mapMaxX/boxSize);
	float shipSize2=(SHIP_SIZE+SHIP_SIZE)+(SHIP_SIZE*shipSizeType[i])+7.0f ;
	float xBump=0.0f;
	float yBump=0.0f;
	float numBump=0.0f;
	for(int h=-1;h<=1;h++)
	{
		int hi=h*(mapMaxX/boxSize);
		for(int w=-1;w<=1;w++)
		{ 
			
			int boxIdCurrent=boxId+w+hi;
			if((boxIdCurrent<2) || (boxIdCurrent>=@@((mapHeight/searchBoxSize)*(mapWidth/searchBoxSize))@@-2))
				continue;
			int nShipsInBox=box[boxIdCurrent];
            if(nShipsInBox>=@@maxShipsPerBox@@)
                nShipsInBox=@@maxShipsPerBox@@-1;
			for(int j=0;j<nShipsInBox;j++)
            {
				int selectedShipId=box[boxIdCurrent+(j+1)*N_SHIP_BOX_LAYER];
				if((selectedShipId==i) || ((shipStates[selectedShipId]&PROJECTILE_DEAD)!=0))
					continue;
				float dx=xf-x[selectedShipId];
				float dy=yf-y[selectedShipId];
				float r= sqrt(dx*dx+dy*dy+0.001f);
				float shipSize3=shipSize2+(SHIP_SIZE*shipSizeType[selectedShipId]);
				if(r < shipSize3)
				{
					xBump+=(dx/(r)) * (shipSize3 - r);
					yBump+=(dy/(r)) * (shipSize3 - r);
					numBump+=1.0f;
				}
			}
		}
	}
	numBump = 1.0f /( (numBump < 0.5f)? 1.0f: numBump );
	xTmp[i]=numBump * xBump / ((1.2f + 1.2f * shipSizeType[i])*(1.2f + 1.2f * shipSizeType[i]));
	yTmp[i]=numBump * yBump / ((1.2f + 1.2f * shipSizeType[i])*(1.2f + 1.2f * shipSizeType[i]));
}
        
// geometry logic: front part of ships
__kernel void calculateShipFronts(__global float *  restrict x, __global float * restrict y, 
__global float * restrict  rotation,__global float * restrict  fx, 
__global float * restrict fy, __global uchar * restrict shipSizeType)
{
    int i=get_global_id(0);
    float rot=rotation[i];
	float partDistance=(15.0f*shipSizeType[i]+15.0f);
	float angle = (rot / 360.0f) * (3.14f * 2.0f);
    fx[i] =x[i]+ partDistance * cos(angle);
    fy[i] =y[i]+ partDistance * sin(angle);
}

// calculate relative module coordinates on each ship
// 0: front, 9: back, 1-8: sides
__kernel void calculateModuleCoordinates(__global float * restrict shipX, __global float * restrict  shipY,
										 __global float * restrict  shipRotation, __global uchar * restrict  shipSizeType,
										 __global float * restrict  shipModuleX, __global float * restrict  shipModuleY,
										 __global uchar * restrict shipTeam)
{ 
    int i=get_global_id(0); // ship id
    float rot=shipRotation[i];
	float partDistance=(15.0f*shipSizeType[i]+15.0f);
	float angle = (rot / 360.0f) * (3.14f * 2.0f);

	if(shipSizeType[i]==0)
	{ 
		// corvette
		if(shipTeam[i]==0)
		{ 
			// team-red (defiant)

			// front
			shipModuleX[i+N_SHIP_MAX*0] =shipX[i]+ 0.44f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*0] =shipY[i]+ 0.44f*partDistance * sin(angle);	

			// back
			shipModuleX[i+N_SHIP_MAX*9] =shipX[i]- 0.45f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*9] =shipY[i]- 0.45f*partDistance * sin(angle);	

			// left side - 1
			shipModuleX[i+N_SHIP_MAX*1] =shipX[i]+ 0.3f*partDistance * cos(angle - 0.428f);
			shipModuleY[i+N_SHIP_MAX*1] =shipY[i]+ 0.3f*partDistance * sin(angle - 0.428f);	

			// left side - 2
			shipModuleX[i+N_SHIP_MAX*3] =shipX[i]+ 0.3f*partDistance * cos(angle - 1.128f);
			shipModuleY[i+N_SHIP_MAX*3] =shipY[i]+ 0.3f*partDistance * sin(angle - 1.128f);	

			// left side - 3
			shipModuleX[i+N_SHIP_MAX*5] =shipX[i]+ 0.39f*partDistance * cos(angle - 1.928f);
			shipModuleY[i+N_SHIP_MAX*5] =shipY[i]+ 0.39f*partDistance * sin(angle - 1.928f);	

			// left side - 4
			shipModuleX[i+N_SHIP_MAX*7] =shipX[i]+ 0.30f*partDistance * cos(angle - 2.528f);
			shipModuleY[i+N_SHIP_MAX*7] =shipY[i]+ 0.30f*partDistance * sin(angle - 2.528f);	

			// right side - 1
			shipModuleX[i+N_SHIP_MAX*2] =shipX[i]+ 0.3f*partDistance * cos(angle + 0.428f);
			shipModuleY[i+N_SHIP_MAX*2] =shipY[i]+ 0.3f*partDistance * sin(angle + 0.428f);	

			// right side - 2
			shipModuleX[i+N_SHIP_MAX*4] =shipX[i]+ 0.3f*partDistance * cos(angle + 1.128f);
			shipModuleY[i+N_SHIP_MAX*4] =shipY[i]+ 0.3f*partDistance * sin(angle + 1.128f);	

			// right side - 3
			shipModuleX[i+N_SHIP_MAX*6] =shipX[i]+ 0.39f*partDistance * cos(angle + 1.928f);
			shipModuleY[i+N_SHIP_MAX*6] =shipY[i]+ 0.39f*partDistance * sin(angle + 1.928f);	

			// right side - 4
			shipModuleX[i+N_SHIP_MAX*8] =shipX[i]+ 0.30f*partDistance * cos(angle + 2.528f);
			shipModuleY[i+N_SHIP_MAX*8] =shipY[i]+ 0.30f*partDistance * sin(angle + 2.528f);	
		}
		else if(shipTeam[i]==1)
		{ 
			// team-green (jem hadar fighter)

			// front
			shipModuleX[i+N_SHIP_MAX*0] =shipX[i]+ 0.44f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*0] =shipY[i]+ 0.44f*partDistance * sin(angle);	

			// back
			shipModuleX[i+N_SHIP_MAX*9] =shipX[i]- 0.25f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*9] =shipY[i]- 0.25f*partDistance * sin(angle);	

			// left side - 1
			shipModuleX[i+N_SHIP_MAX*1] =shipX[i]+ 0.35f*partDistance * cos(angle - 0.258f);
			shipModuleY[i+N_SHIP_MAX*1] =shipY[i]+ 0.35f*partDistance * sin(angle - 0.258f);	

			// left side - 2
			shipModuleX[i+N_SHIP_MAX*3] =shipX[i]+ 0.65f*partDistance * cos(angle - 1.258f);
			shipModuleY[i+N_SHIP_MAX*3] =shipY[i]+ 0.65f*partDistance * sin(angle - 1.258f);	

			// left side - 3
			shipModuleX[i+N_SHIP_MAX*5] =shipX[i]+ 0.20f*partDistance * cos(angle - 1.528f);
			shipModuleY[i+N_SHIP_MAX*5] =shipY[i]+ 0.20f*partDistance * sin(angle - 1.528f);	

			// left side - 4
			shipModuleX[i+N_SHIP_MAX*7] =shipX[i]+ 0.30f*partDistance * cos(angle - 2.228f);
			shipModuleY[i+N_SHIP_MAX*7] =shipY[i]+ 0.30f*partDistance * sin(angle - 2.228f);	

			// right side - 1
			shipModuleX[i+N_SHIP_MAX*2] =shipX[i]+ 0.35f*partDistance * cos(angle + 0.258f);
			shipModuleY[i+N_SHIP_MAX*2] =shipY[i]+ 0.35f*partDistance * sin(angle + 0.258f);	

			// right side - 2
			shipModuleX[i+N_SHIP_MAX*4] =shipX[i]+ 0.65f*partDistance * cos(angle + 1.258f);
			shipModuleY[i+N_SHIP_MAX*4] =shipY[i]+ 0.65f*partDistance * sin(angle + 1.258f);	

			// right side - 3
			shipModuleX[i+N_SHIP_MAX*6] =shipX[i]+ 0.20f*partDistance * cos(angle + 1.528f);
			shipModuleY[i+N_SHIP_MAX*6] =shipY[i]+ 0.20f*partDistance * sin(angle + 1.528f);	

			// right side - 4
			shipModuleX[i+N_SHIP_MAX*8] =shipX[i]+ 0.30f*partDistance * cos(angle + 2.228f);
			shipModuleY[i+N_SHIP_MAX*8] =shipY[i]+ 0.30f*partDistance * sin(angle + 2.228f);	
		}
		else if(shipTeam[i]==2)
		{ 
			// team-blue (millenium falcon)

			// front
			shipModuleX[i+N_SHIP_MAX*0] =shipX[i]+ 0.24f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*0] =shipY[i]+ 0.24f*partDistance * sin(angle);	

			// back
			shipModuleX[i+N_SHIP_MAX*9] =shipX[i]- 0.25f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*9] =shipY[i]- 0.25f*partDistance * sin(angle);	

			// left side - 1
			shipModuleX[i+N_SHIP_MAX*1] =shipX[i]+ 0.35f*partDistance * cos(angle - 0.258f);
			shipModuleY[i+N_SHIP_MAX*1] =shipY[i]+ 0.35f*partDistance * sin(angle - 0.258f);	

			// left side - 2
			shipModuleX[i+N_SHIP_MAX*3] =shipX[i]+ 0.28f*partDistance * cos(angle - 1.058f);
			shipModuleY[i+N_SHIP_MAX*3] =shipY[i]+ 0.28f*partDistance * sin(angle - 1.058f);	

			// left side - 3
			shipModuleX[i+N_SHIP_MAX*5] =shipX[i]+ 0.20f*partDistance * cos(angle - 1.528f);
			shipModuleY[i+N_SHIP_MAX*5] =shipY[i]+ 0.20f*partDistance * sin(angle - 1.528f);	

			// left side - 4
			shipModuleX[i+N_SHIP_MAX*7] =shipX[i]+ 0.30f*partDistance * cos(angle - 2.228f);
			shipModuleY[i+N_SHIP_MAX*7] =shipY[i]+ 0.30f*partDistance * sin(angle - 2.228f);	

			// right side - 1
			shipModuleX[i+N_SHIP_MAX*2] =shipX[i]+ 0.35f*partDistance * cos(angle + 0.258f);
			shipModuleY[i+N_SHIP_MAX*2] =shipY[i]+ 0.35f*partDistance * sin(angle + 0.258f);	

			// right side - 2
			shipModuleX[i+N_SHIP_MAX*4] =shipX[i]+ 0.28f*partDistance * cos(angle + 1.058f);
			shipModuleY[i+N_SHIP_MAX*4] =shipY[i]+ 0.28f*partDistance * sin(angle + 1.058f);	

			// right side - 3
			shipModuleX[i+N_SHIP_MAX*6] =shipX[i]+ 0.20f*partDistance * cos(angle + 1.528f);
			shipModuleY[i+N_SHIP_MAX*6] =shipY[i]+ 0.20f*partDistance * sin(angle + 1.528f);	

			// right side - 4
			shipModuleX[i+N_SHIP_MAX*8] =shipX[i]+ 0.30f*partDistance * cos(angle + 2.228f);
			shipModuleY[i+N_SHIP_MAX*8] =shipY[i]+ 0.30f*partDistance * sin(angle + 2.228f);	
		}
	}
	else if(shipSizeType[i]==1)
	{ 
		// frigate
		if(shipTeam[i]==0)
		{ 
			// team-red (akira)

			// front
			shipModuleX[i+N_SHIP_MAX*0] =shipX[i]+ 0.54f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*0] =shipY[i]+ 0.54f*partDistance * sin(angle);	

			// back
			shipModuleX[i+N_SHIP_MAX*9] =shipX[i]+ 0.05f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*9] =shipY[i]+ 0.05f*partDistance * sin(angle);	

			// left side - 1
			shipModuleX[i+N_SHIP_MAX*1] =shipX[i]+ 0.44f*partDistance * cos(angle - 0.528f);
			shipModuleY[i+N_SHIP_MAX*1] =shipY[i]+ 0.44f*partDistance * sin(angle - 0.528f);	

			// left side - 2
			shipModuleX[i+N_SHIP_MAX*3] =shipX[i]+ 0.25f*partDistance * cos(angle - 1.128f);
			shipModuleY[i+N_SHIP_MAX*3] =shipY[i]+ 0.25f*partDistance * sin(angle - 1.128f);	

			// left side - 3
			shipModuleX[i+N_SHIP_MAX*5] =shipX[i]+ 0.23f*partDistance * cos(angle - 2.258f);
			shipModuleY[i+N_SHIP_MAX*5] =shipY[i]+ 0.23f*partDistance * sin(angle - 2.258f);	

			// left side - 4
			shipModuleX[i+N_SHIP_MAX*7] =shipX[i]+ 0.49f*partDistance * cos(angle - 2.528f);
			shipModuleY[i+N_SHIP_MAX*7] =shipY[i]+ 0.49f*partDistance * sin(angle - 2.528f);

			// right side - 1
			shipModuleX[i+N_SHIP_MAX*2] =shipX[i]+ 0.44f*partDistance * cos(angle + 0.528f);
			shipModuleY[i+N_SHIP_MAX*2] =shipY[i]+ 0.44f*partDistance * sin(angle + 0.528f);	

			// right side - 2
			shipModuleX[i+N_SHIP_MAX*4] =shipX[i]+ 0.25f*partDistance * cos(angle + 1.128f);
			shipModuleY[i+N_SHIP_MAX*4] =shipY[i]+ 0.25f*partDistance * sin(angle + 1.128f);	

			// right side - 3
			shipModuleX[i+N_SHIP_MAX*6] =shipX[i]+ 0.23f*partDistance * cos(angle + 2.258f);
			shipModuleY[i+N_SHIP_MAX*6] =shipY[i]+ 0.23f*partDistance * sin(angle + 2.258f);	

			// right side - 4
			shipModuleX[i+N_SHIP_MAX*8] =shipX[i]+ 0.49f*partDistance * cos(angle + 2.528f);
			shipModuleY[i+N_SHIP_MAX*8] =shipY[i]+ 0.49f*partDistance * sin(angle + 2.528f);	
		}
		else if(shipTeam[i]==1)
		{ 
			// team-green (droid control ship)

			// front
			shipModuleX[i+N_SHIP_MAX*0] =shipX[i]+ 0.0f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*0] =shipY[i]+ 0.0f*partDistance * sin(angle);	

			// back
			shipModuleX[i+N_SHIP_MAX*9] =shipX[i]- 0.5f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*9] =shipY[i]- 0.5f*partDistance * sin(angle);	

			// left side - 1
			shipModuleX[i+N_SHIP_MAX*1] =shipX[i]+ 0.4f*partDistance * cos(angle - 0.7f);
			shipModuleY[i+N_SHIP_MAX*1] =shipY[i]+ 0.4f*partDistance * sin(angle - 0.7f);	

			// left side - 2
			shipModuleX[i+N_SHIP_MAX*3] =shipX[i]+ 0.4f*partDistance * cos(angle - 1.4f);
			shipModuleY[i+N_SHIP_MAX*3] =shipY[i]+ 0.4f*partDistance * sin(angle - 1.4f);	

			// left side - 3
			shipModuleX[i+N_SHIP_MAX*5] =shipX[i]+ 0.4f*partDistance * cos(angle - 2.1f);
			shipModuleY[i+N_SHIP_MAX*5] =shipY[i]+ 0.4f*partDistance * sin(angle - 2.1f);	

			// left side - 4
			shipModuleX[i+N_SHIP_MAX*7] =shipX[i]+ 0.4f*partDistance * cos(angle - 2.8f);
			shipModuleY[i+N_SHIP_MAX*7] =shipY[i]+ 0.4f*partDistance * sin(angle - 2.8f);	

			// right side - 1
			shipModuleX[i+N_SHIP_MAX*2] =shipX[i]+ 0.4f*partDistance * cos(angle + 0.7f);
			shipModuleY[i+N_SHIP_MAX*2] =shipY[i]+ 0.4f*partDistance * sin(angle + 0.7f);	

			// right side - 2
			shipModuleX[i+N_SHIP_MAX*4] =shipX[i]+ 0.4f*partDistance * cos(angle + 1.4f);
			shipModuleY[i+N_SHIP_MAX*4] =shipY[i]+ 0.4f*partDistance * sin(angle + 1.4f);	

			// right side - 3
			shipModuleX[i+N_SHIP_MAX*6] =shipX[i]+ 0.4f*partDistance * cos(angle + 2.1f);
			shipModuleY[i+N_SHIP_MAX*6] =shipY[i]+ 0.4f*partDistance * sin(angle + 2.1f);	

			// right side - 4
			shipModuleX[i+N_SHIP_MAX*8] =shipX[i]+ 0.4f*partDistance * cos(angle + 2.8f);
			shipModuleY[i+N_SHIP_MAX*8] =shipY[i]+ 0.4f*partDistance * sin(angle + 2.8f);	
		}
		else if(shipTeam[i]==2)
		{ 
			// team-blue (corellian)

			// front
			shipModuleX[i+N_SHIP_MAX*0] =shipX[i]+ 0.55f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*0] =shipY[i]+ 0.55f*partDistance * sin(angle);	

			// back
			shipModuleX[i+N_SHIP_MAX*9] =shipX[i]- 0.5f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*9] =shipY[i]- 0.5f*partDistance * sin(angle);	

			// left side - 1
			shipModuleX[i+N_SHIP_MAX*1] =shipX[i]+ 0.55f*partDistance * cos(angle - 0.15f);
			shipModuleY[i+N_SHIP_MAX*1] =shipY[i]+ 0.55f*partDistance * sin(angle - 0.15f);	

			// left side - 2
			shipModuleX[i+N_SHIP_MAX*3] =shipX[i]+ 0.25f*partDistance * cos(angle - 0.258f);
			shipModuleY[i+N_SHIP_MAX*3] =shipY[i]+ 0.25f*partDistance * sin(angle - 0.258f);	

			// left side - 3
			shipModuleX[i+N_SHIP_MAX*5] =shipX[i]+ 0.11f*partDistance * cos(angle - 0.52f);
			shipModuleY[i+N_SHIP_MAX*5] =shipY[i]+ 0.11f*partDistance * sin(angle - 0.52f);	

			// left side - 4
			shipModuleX[i+N_SHIP_MAX*7] =shipX[i]+ 0.30f*partDistance * cos(angle - 2.828f);
			shipModuleY[i+N_SHIP_MAX*7] =shipY[i]+ 0.30f*partDistance * sin(angle - 2.828f);	

			// right side - 1
			shipModuleX[i+N_SHIP_MAX*2] =shipX[i]+ 0.55f*partDistance * cos(angle + 0.15f);
			shipModuleY[i+N_SHIP_MAX*2] =shipY[i]+ 0.55f*partDistance * sin(angle + 0.15f);	

			// right side - 2
			shipModuleX[i+N_SHIP_MAX*4] =shipX[i]+ 0.25f*partDistance * cos(angle + 0.258f);
			shipModuleY[i+N_SHIP_MAX*4] =shipY[i]+ 0.25f*partDistance * sin(angle + 0.258f);	

			// right side - 3
			shipModuleX[i+N_SHIP_MAX*6] =shipX[i]+ 0.11f*partDistance * cos(angle + 0.52f);
			shipModuleY[i+N_SHIP_MAX*6] =shipY[i]+ 0.11f*partDistance * sin(angle + 0.52f);	

			// right side - 4
			shipModuleX[i+N_SHIP_MAX*8] =shipX[i]+ 0.30f*partDistance * cos(angle + 2.828f);
			shipModuleY[i+N_SHIP_MAX*8] =shipY[i]+ 0.30f*partDistance * sin(angle + 2.828f);	
		}
	}
	else if(shipSizeType[i]==2)
	{ 
		// destroyer
		if(shipTeam[i]==0)
		{ 
			// team-red (constitution)

			// front
			shipModuleX[i+N_SHIP_MAX*0] =shipX[i]+ 0.54f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*0] =shipY[i]+ 0.54f*partDistance * sin(angle);	

			// back
			shipModuleX[i+N_SHIP_MAX*9] =shipX[i]- 0.25f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*9] =shipY[i]- 0.25f*partDistance * sin(angle);	

			// left side - 1
			shipModuleX[i+N_SHIP_MAX*1] =shipX[i]+ 0.44f*partDistance * cos(angle - 0.528f);
			shipModuleY[i+N_SHIP_MAX*1] =shipY[i]+ 0.44f*partDistance * sin(angle - 0.528f);	

			// left side - 2
			shipModuleX[i+N_SHIP_MAX*3] =shipX[i]+ 0.22f*partDistance * cos(angle - 1.128f);
			shipModuleY[i+N_SHIP_MAX*3] =shipY[i]+ 0.22f*partDistance * sin(angle - 1.128f);	

			// left side - 3
			shipModuleX[i+N_SHIP_MAX*5] =shipX[i]+ 0.33f*partDistance * cos(angle - 2.258f);
			shipModuleY[i+N_SHIP_MAX*5] =shipY[i]+ 0.33f*partDistance * sin(angle - 2.258f);	

			// left side - 4
			shipModuleX[i+N_SHIP_MAX*7] =shipX[i]+ 0.49f*partDistance * cos(angle - 2.528f);
			shipModuleY[i+N_SHIP_MAX*7] =shipY[i]+ 0.49f*partDistance * sin(angle - 2.528f);

			// right side - 1
			shipModuleX[i+N_SHIP_MAX*2] =shipX[i]+ 0.44f*partDistance * cos(angle + 0.528f);
			shipModuleY[i+N_SHIP_MAX*2] =shipY[i]+ 0.44f*partDistance * sin(angle + 0.528f);	

			// right side - 2
			shipModuleX[i+N_SHIP_MAX*4] =shipX[i]+ 0.22f*partDistance * cos(angle + 1.128f);
			shipModuleY[i+N_SHIP_MAX*4] =shipY[i]+ 0.22f*partDistance * sin(angle + 1.128f);	

			// right side - 3
			shipModuleX[i+N_SHIP_MAX*6] =shipX[i]+ 0.33f*partDistance * cos(angle + 2.258f);
			shipModuleY[i+N_SHIP_MAX*6] =shipY[i]+ 0.33f*partDistance * sin(angle + 2.258f);	

			// right side - 4
			shipModuleX[i+N_SHIP_MAX*8] =shipX[i]+ 0.49f*partDistance * cos(angle + 2.528f);
			shipModuleY[i+N_SHIP_MAX*8] =shipY[i]+ 0.49f*partDistance * sin(angle + 2.528f);	
		}
		else if(shipTeam[i]==1)
		{ 
			// team-green (base ship)

			// front
			shipModuleX[i+N_SHIP_MAX*0] =shipX[i]+ 0.5f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*0] =shipY[i]+ 0.5f*partDistance * sin(angle);	

			// back
			shipModuleX[i+N_SHIP_MAX*9] =shipX[i]- 0.4f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*9] =shipY[i]- 0.4f*partDistance * sin(angle);	

			// left side - 1
			shipModuleX[i+N_SHIP_MAX*1] =shipX[i]+ 0.45f*partDistance * cos(angle - 0.6f);
			shipModuleY[i+N_SHIP_MAX*1] =shipY[i]+ 0.45f*partDistance * sin(angle - 0.6f);	

			// left side - 2
			shipModuleX[i+N_SHIP_MAX*3] =shipX[i]+ 0.27f*partDistance * cos(angle - 0.7f);
			shipModuleY[i+N_SHIP_MAX*3] =shipY[i]+ 0.27f*partDistance * sin(angle - 0.7f);	

			// left side - 3
			shipModuleX[i+N_SHIP_MAX*5] =shipX[i]+ 0.2f*partDistance * cos(angle -  2.5f);
			shipModuleY[i+N_SHIP_MAX*5] =shipY[i]+ 0.2f*partDistance * sin(angle -  2.5f);	

			// left side - 4
			shipModuleX[i+N_SHIP_MAX*7] =shipX[i]+ 0.5f*partDistance * cos(angle - 2.5f);
			shipModuleY[i+N_SHIP_MAX*7] =shipY[i]+ 0.5f*partDistance * sin(angle - 2.5f);	

			// right side - 1
			shipModuleX[i+N_SHIP_MAX*2] =shipX[i]+ 0.45f*partDistance * cos(angle + 0.6f);
			shipModuleY[i+N_SHIP_MAX*2] =shipY[i]+ 0.45f*partDistance * sin(angle + 0.6f);	

			// right side - 2
			shipModuleX[i+N_SHIP_MAX*4] =shipX[i]+ 0.27f*partDistance * cos(angle + 0.7f);
			shipModuleY[i+N_SHIP_MAX*4] =shipY[i]+ 0.27f*partDistance * sin(angle + 0.7f);	

			// right side - 3
			shipModuleX[i+N_SHIP_MAX*6] =shipX[i]+ 0.2f*partDistance * cos(angle + 2.5f);
			shipModuleY[i+N_SHIP_MAX*6] =shipY[i]+ 0.2f*partDistance * sin(angle + 2.5f);	

			// right side - 4
			shipModuleX[i+N_SHIP_MAX*8] =shipX[i]+ 0.5f*partDistance * cos(angle + 2.5f);
			shipModuleY[i+N_SHIP_MAX*8] =shipY[i]+ 0.5f*partDistance * sin(angle + 2.5f);	
		}
		else if(shipTeam[i]==2)
		{ 
			// team-blue (acclamator)

			// front
			shipModuleX[i+N_SHIP_MAX*0] =shipX[i]+ 0.55f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*0] =shipY[i]+ 0.55f*partDistance * sin(angle);	

			// back
			shipModuleX[i+N_SHIP_MAX*9] =shipX[i]- 0.5f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*9] =shipY[i]- 0.5f*partDistance * sin(angle);	

			// left side - 1
			shipModuleX[i+N_SHIP_MAX*1] =shipX[i]+ 0.35f*partDistance * cos(angle - 0.25f);
			shipModuleY[i+N_SHIP_MAX*1] =shipY[i]+ 0.35f*partDistance * sin(angle - 0.25f);	

			// left side - 2
			shipModuleX[i+N_SHIP_MAX*3] =shipX[i]+ 0.25f*partDistance * cos(angle - 0.758f);
			shipModuleY[i+N_SHIP_MAX*3] =shipY[i]+ 0.25f*partDistance * sin(angle - 0.758f);	

			// left side - 3
			shipModuleX[i+N_SHIP_MAX*5] =shipX[i]+ 0.31f*partDistance * cos(angle - 2.02f);
			shipModuleY[i+N_SHIP_MAX*5] =shipY[i]+ 0.31f*partDistance * sin(angle - 2.02f);	

			// left side - 4
			shipModuleX[i+N_SHIP_MAX*7] =shipX[i]+ 0.30f*partDistance * cos(angle - 2.828f);
			shipModuleY[i+N_SHIP_MAX*7] =shipY[i]+ 0.30f*partDistance * sin(angle - 2.828f);	

			// right side - 1
			shipModuleX[i+N_SHIP_MAX*2] =shipX[i]+ 0.35f*partDistance * cos(angle + 0.25f);
			shipModuleY[i+N_SHIP_MAX*2] =shipY[i]+ 0.35f*partDistance * sin(angle + 0.25f);	

			// right side - 2
			shipModuleX[i+N_SHIP_MAX*4] =shipX[i]+ 0.25f*partDistance * cos(angle + 0.758f);
			shipModuleY[i+N_SHIP_MAX*4] =shipY[i]+ 0.25f*partDistance * sin(angle + 0.758f);	

			// right side - 3
			shipModuleX[i+N_SHIP_MAX*6] =shipX[i]+ 0.31f*partDistance * cos(angle + 2.02f);
			shipModuleY[i+N_SHIP_MAX*6] =shipY[i]+ 0.31f*partDistance * sin(angle + 2.02f);	

			// right side - 4
			shipModuleX[i+N_SHIP_MAX*8] =shipX[i]+ 0.30f*partDistance * cos(angle + 2.828f);
			shipModuleY[i+N_SHIP_MAX*8] =shipY[i]+ 0.30f*partDistance * sin(angle + 2.828f);	
		}
	}
	else if(shipSizeType[i]==3)
	{ 
		// cruiser
		if(shipTeam[i]==0)
		{ 
			// team-red (ambassador)

			// front
			shipModuleX[i+N_SHIP_MAX*0] =shipX[i]+ 0.54f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*0] =shipY[i]+ 0.54f*partDistance * sin(angle);	

			// back
			shipModuleX[i+N_SHIP_MAX*9] =shipX[i]- 0.25f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*9] =shipY[i]- 0.25f*partDistance * sin(angle);	

			// left side - 1
			shipModuleX[i+N_SHIP_MAX*1] =shipX[i]+ 0.44f*partDistance * cos(angle - 0.528f);
			shipModuleY[i+N_SHIP_MAX*1] =shipY[i]+ 0.44f*partDistance * sin(angle - 0.528f);	

			// left side - 2
			shipModuleX[i+N_SHIP_MAX*3] =shipX[i]+ 0.22f*partDistance * cos(angle - 1.128f);
			shipModuleY[i+N_SHIP_MAX*3] =shipY[i]+ 0.22f*partDistance * sin(angle - 1.128f);	

			// left side - 3
			shipModuleX[i+N_SHIP_MAX*5] =shipX[i]+ 0.33f*partDistance * cos(angle - 2.258f);
			shipModuleY[i+N_SHIP_MAX*5] =shipY[i]+ 0.33f*partDistance * sin(angle - 2.258f);	

			// left side - 4
			shipModuleX[i+N_SHIP_MAX*7] =shipX[i]+ 0.49f*partDistance * cos(angle - 2.528f);
			shipModuleY[i+N_SHIP_MAX*7] =shipY[i]+ 0.49f*partDistance * sin(angle - 2.528f);

			// right side - 1
			shipModuleX[i+N_SHIP_MAX*2] =shipX[i]+ 0.44f*partDistance * cos(angle + 0.528f);
			shipModuleY[i+N_SHIP_MAX*2] =shipY[i]+ 0.44f*partDistance * sin(angle + 0.528f);	

			// right side - 2
			shipModuleX[i+N_SHIP_MAX*4] =shipX[i]+ 0.22f*partDistance * cos(angle + 1.128f);
			shipModuleY[i+N_SHIP_MAX*4] =shipY[i]+ 0.22f*partDistance * sin(angle + 1.128f);	

			// right side - 3
			shipModuleX[i+N_SHIP_MAX*6] =shipX[i]+ 0.33f*partDistance * cos(angle + 2.258f);
			shipModuleY[i+N_SHIP_MAX*6] =shipY[i]+ 0.33f*partDistance * sin(angle + 2.258f);	

			// right side - 4
			shipModuleX[i+N_SHIP_MAX*8] =shipX[i]+ 0.49f*partDistance * cos(angle + 2.528f);
			shipModuleY[i+N_SHIP_MAX*8] =shipY[i]+ 0.49f*partDistance * sin(angle + 2.528f);	
		}
		else if(shipTeam[i]==1)
		{ 
			// team-green (galactica)

			// front
			shipModuleX[i+N_SHIP_MAX*0] =shipX[i]+ 0.5f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*0] =shipY[i]+ 0.5f*partDistance * sin(angle);	

			// back
			shipModuleX[i+N_SHIP_MAX*9] =shipX[i]- 0.4f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*9] =shipY[i]- 0.4f*partDistance * sin(angle);	

			// left side - 1
			shipModuleX[i+N_SHIP_MAX*1] =shipX[i]+ 0.3f*partDistance * cos(angle - 0.25f);
			shipModuleY[i+N_SHIP_MAX*1] =shipY[i]+ 0.3f*partDistance * sin(angle - 0.25f);	

			// left side - 2
			shipModuleX[i+N_SHIP_MAX*3] =shipX[i]+ 0.22f*partDistance * cos(angle - 1.2f);
			shipModuleY[i+N_SHIP_MAX*3] =shipY[i]+ 0.22f*partDistance * sin(angle - 1.2f);	

			// left side - 3
			shipModuleX[i+N_SHIP_MAX*5] =shipX[i]+ 0.25f*partDistance * cos(angle -  2.3f);
			shipModuleY[i+N_SHIP_MAX*5] =shipY[i]+ 0.25f*partDistance * sin(angle -  2.3f);	

			// left side - 4
			shipModuleX[i+N_SHIP_MAX*7] =shipX[i]+ 0.15f*partDistance * cos(angle - 2.8f);
			shipModuleY[i+N_SHIP_MAX*7] =shipY[i]+ 0.15f*partDistance * sin(angle - 2.8f);	

			// right side - 1
			shipModuleX[i+N_SHIP_MAX*2] =shipX[i]+ 0.3f*partDistance * cos(angle + 0.25f);
			shipModuleY[i+N_SHIP_MAX*2] =shipY[i]+ 0.3f*partDistance * sin(angle + 0.25f);	

			// right side - 2
			shipModuleX[i+N_SHIP_MAX*4] =shipX[i]+ 0.22f*partDistance * cos(angle + 1.2f);
			shipModuleY[i+N_SHIP_MAX*4] =shipY[i]+ 0.22f*partDistance * sin(angle + 1.2f);	

			// right side - 3
			shipModuleX[i+N_SHIP_MAX*6] =shipX[i]+ 0.25f*partDistance * cos(angle + 2.3f);
			shipModuleY[i+N_SHIP_MAX*6] =shipY[i]+ 0.25f*partDistance * sin(angle + 2.3f);	

			// right side - 4
			shipModuleX[i+N_SHIP_MAX*8] =shipX[i]+ 0.15f*partDistance * cos(angle + 2.8f);
			shipModuleY[i+N_SHIP_MAX*8] =shipY[i]+ 0.15f*partDistance * sin(angle + 2.8f);	
		}
		else if(shipTeam[i]==2)
		{ 
			// team-blue (venator)

			// front
			shipModuleX[i+N_SHIP_MAX*0] =shipX[i]+ 0.55f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*0] =shipY[i]+ 0.55f*partDistance * sin(angle);	

			// back
			shipModuleX[i+N_SHIP_MAX*9] =shipX[i]- 0.5f*partDistance * cos(angle);
			shipModuleY[i+N_SHIP_MAX*9] =shipY[i]- 0.5f*partDistance * sin(angle);	

			// left side - 1
			shipModuleX[i+N_SHIP_MAX*1] =shipX[i]+ 0.35f*partDistance * cos(angle - 0.15f);
			shipModuleY[i+N_SHIP_MAX*1] =shipY[i]+ 0.35f*partDistance * sin(angle - 0.15f);	

			// left side - 2
			shipModuleX[i+N_SHIP_MAX*3] =shipX[i]+ 0.15f*partDistance * cos(angle - 0.758f);
			shipModuleY[i+N_SHIP_MAX*3] =shipY[i]+ 0.15f*partDistance * sin(angle - 0.758f);	

			// left side - 3
			shipModuleX[i+N_SHIP_MAX*5] =shipX[i]+ 0.15f*partDistance * cos(angle - 2.02f);
			shipModuleY[i+N_SHIP_MAX*5] =shipY[i]+ 0.15f*partDistance * sin(angle - 2.02f);	

			// left side - 4
			shipModuleX[i+N_SHIP_MAX*7] =shipX[i]+ 0.35f*partDistance * cos(angle - 2.828f);
			shipModuleY[i+N_SHIP_MAX*7] =shipY[i]+ 0.35f*partDistance * sin(angle - 2.828f);	

			// right side - 1
			shipModuleX[i+N_SHIP_MAX*2] =shipX[i]+ 0.35f*partDistance * cos(angle + 0.15f);
			shipModuleY[i+N_SHIP_MAX*2] =shipY[i]+ 0.35f*partDistance * sin(angle + 0.15f);	

			// right side - 2
			shipModuleX[i+N_SHIP_MAX*4] =shipX[i]+ 0.15f*partDistance * cos(angle + 0.758f);
			shipModuleY[i+N_SHIP_MAX*4] =shipY[i]+ 0.15f*partDistance * sin(angle + 0.758f);	

			// right side - 3
			shipModuleX[i+N_SHIP_MAX*6] =shipX[i]+ 0.15f*partDistance * cos(angle + 2.02f);
			shipModuleY[i+N_SHIP_MAX*6] =shipY[i]+ 0.15f*partDistance * sin(angle + 2.02f);	

			// right side - 4
			shipModuleX[i+N_SHIP_MAX*8] =shipX[i]+ 0.35f*partDistance * cos(angle + 2.828f);
			shipModuleY[i+N_SHIP_MAX*8] =shipY[i]+ 0.35f*partDistance * sin(angle + 2.828f);	
		}
	}
}




// game logic: find enemy ships in range (per ship, using box structure for neighbors)
// pick a random ship from list (max 10) of enemies found
// if weapon charged, spawn laser projectile (activate a dead one with coordinates = module hardpoint coordinates)
// if number of projectiles < 10 then continue spawning
// predict enemy movement, adjust firing angle accordingly with officer skill and dice d20
// each thread work on neighboring boxes of neighboring threads (8x8 patches)
__kernel void findEnemyShipsBlocked(	
								__global float * restrict  x,					__global float * restrict  y,		__global int *  restrict box,
                                __global float * restrict  frontX,				__global float *  restrict frontY,
                                __global float * restrict  projectileX,			__global float * restrict  projectileY,
                                __global unsigned char * restrict  shipState,	__global unsigned char * restrict  projectileState,
                                __global float * restrict  projectileRotation,	__global unsigned char * restrict  shipWeaponCharge,
                                __global unsigned int * restrict  randSeeds,	__global unsigned char * restrict  shipTeam,
								__global unsigned char *  restrict projectileLife,
								__global uchar * restrict  shipModuleType,		__global int * restrict  shipModuleEnergy,
								__global uchar * restrict  shipModuleHP,		__global uchar * restrict  shipModuleHPMax,
								__global uint *  restrict randBuf,				__global int * restrict  shipModuleEnergyMax,
								__global int * restrict  shipModuleWeight,		__global uchar * restrict  shipModuleState,
								__global uchar * restrict shipSizeType, 
								__global float * restrict shipModuleX,			__global float * restrict shipModuleY,
								__global int * restrict enemyShipBoxHintW,		__global int * restrict enemyShipBoxHintH,
								__global uchar * restrict projectileDamage,		__global int * restrict projectileEvadeShipId)
{
    int i=get_global_id(0); // box id (to select ships directly and use block algorithm - data locality)
	{ 
		// blocked computing with 8x8 patches of boxes(of ships)
		short nBoxesPerLine = MAP_WIDTH/SHIP_SEARCH_BOX_SIZE; // similar to pixels per scanline / render_width
		short patchId = i/64;

		// box's coordinates in its patch
		short localX = i%8;
		short localY = (i/8)%8;

		// first element of each patch will have this X and Y offsets
		short patchX = (patchId % (nBoxesPerLine/8)) * 8;
		short patchY = (patchId / (nBoxesPerLine/8)) * 8;

		short blockX=patchX + localX;
		short blockY=patchY + localY;

		// conversion from scanline to block algorithm
		i=blockX + blockY * nBoxesPerLine;
	}


	// for all ships in this box, do all pairs compares then check neighbor boxes
	// todo: convert all outer return to continue
	// todo: convert all i to shipId
	char4 registers0=0;
	char4 registers1=0;
	char4 registers2=0;
	char4 registers3=0;
	char4 registers4=0;

	// number of ships in this box
	registers0.s0=box[i];
    if(registers0.s0>=@@maxShipsPerBox@@)
         registers0.s0=@@maxShipsPerBox@@-1;
	// for loop counter for number of ships
	registers0.s1=0;

	// for loop counter for max projectiles per ship, target found
	registers0.s2=0;

	// local id
	registers0.s3=get_local_id(0);

	__local float targetDx[N_LOCAL_SIZE][20];
	__local int selectedShipId[N_LOCAL_SIZE];
	for(registers0.s1=0;registers0.s1<registers0.s0;registers0.s1++)
	{ 
		int shipId=box[i+(registers0.s1+1)*N_SHIP_BOX_LAYER];


		if((shipState[shipId]&PROJECTILE_DEAD)!=0)
			continue;
                                        
		unsigned char currentTeam = shipTeam[shipId];

		int nextProjectileId = -1;
		for(registers0.s2=0;registers0.s2<MAX_PROJECTILES_PER_SHIP;registers0.s2++)
		{
			if((projectileState[shipId+N_SHIP_MAX*registers0.s2]&PROJECTILE_DEAD)!=0)
			{
				nextProjectileId=shipId+N_SHIP_MAX*registers0.s2;
				projectileEvadeShipId[nextProjectileId]=-1;
				break;
			}
		}

		if(nextProjectileId<0)
			continue;


		float xf=x[shipId];
		float yf=y[shipId];
		registers0.s2=0;

                                                                                

		//int boxX= ((int)xf)/boxSize;
		//int boxY= ((int)yf)/boxSize;

		// id of box that this ship belongs to
		int boxId=i;


		float targetDy[20];

		// targets counter
		registers4.s0=0;

		// fast finding same ship with last time step if its in range again

		// w hint
		registers2.s0=enemyShipBoxHintW[shipId];

		// h hint
		registers2.s2=enemyShipBoxHintH[shipId];

		// ctr max
		registers2.s1=registers2.s0+6;
		registers2.s3=registers2.s2+6;

		float2 dxdy=(float2)(0.0f,0.0f);

		for(registers1.s0=0+registers2.s0;registers1.s0<=registers2.s1;registers1.s0++)
		{
			registers1.s2=(registers1.s0%7)-3;
			if(registers4.s0>16)
				break;     
			                   
			for(registers1.s1=0+registers2.s2;registers1.s1<=registers2.s3;registers1.s1++)
			{
				registers1.s3=(registers1.s1%7)-3;
				if(registers4.s0>16)
					break;                        

				int boxIdCurrent=boxId+registers1.s3+registers1.s2*(MAP_WIDTH/SHIP_SEARCH_BOX_SIZE);
				if((boxIdCurrent<2) || (boxIdCurrent>=@@((mapHeight/searchBoxSize)*(mapWidth/searchBoxSize))@@-2))
					continue;

				// number of ships in box
				registers3.s0=box[boxIdCurrent];
                if(registers3.s0>=@@maxShipsPerBox@@)
                    registers3.s0=@@maxShipsPerBox@@-1;
				// j
				for(registers3.s1=0;registers3.s1<registers3.s0;registers3.s1++)
				{
					if(registers4.s0>16)
						break;                        
					selectedShipId[registers0.s3]=box[boxIdCurrent+(registers3.s1+1)*N_SHIP_BOX_LAYER];
					mem_fence(CLK_LOCAL_MEM_FENCE);
					if(selectedShipId[registers0.s3]==boxId)
						continue;
					// check if (xf,yf) is in ship hull
					if( (selectedShipId[registers0.s3]>=0) && (selectedShipId[registers0.s3]<@@nShip@@))
					{
						if(shipTeam[selectedShipId[registers0.s3]]==currentTeam)
							continue;
						if(selectedShipId[registers0.s3]==i)
				  			continue;

						dxdy.x=xf-x[selectedShipId[registers0.s3]];
						dxdy.y=yf-y[selectedShipId[registers0.s3]];
						float targetDistance = (shipSizeType[selectedShipId[registers0.s3]] + shipSizeType[shipId]) * SHIP_SIZE + TARGET_DISTANCE;
						if((dxdy.x*dxdy.x + dxdy.y*dxdy.y)<(targetDistance*targetDistance))
						{
							registers0.s2=1;
                        
							targetDx[registers0.s3][registers4.s0]=dxdy.x;
							targetDy[registers4.s0]=dxdy.y;
							registers4.s0++;
							registers2.s0=registers1.s2;
							registers2.s2=registers1.s3;
						
						}
					}
				}
			}
		}
                                        
		if(registers0.s2>0)
		{

			enemyShipBoxHintW[shipId]=registers2.s0;
			enemyShipBoxHintH[shipId]=registers2.s2;

			// return enable
			registers4.s1=0;

			// i module
			for(registers3.s2=0;registers3.s2<MAX_MODULES_PER_SHIP;registers3.s2++)
			{ 
				registers4.s2=shipModuleType[shipId + registers3.s2*N_SHIP_MAX];
				registers4.s3=shipModuleState[shipId + registers3.s2*N_SHIP_MAX];
				if(registers4.s2==SHIP_MODULE_TYPE_CANNON_TURRET)
				{ 
					if((registers4.s3&SHIP_MODULE_STATE_WORKING)!=0)
					{ 
						if(shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX]>=SHIP_MODULE_CANNON_TURRET_ENERGY)
						{ 
							// box id is used instead of ship id(i is still i)
							// random target from registered target list (max 10)
							registers3.s3 =  floor(tw_rnd(randSeeds,i)*(registers4.s0-1)+0.5f);
							if(registers3.s3<0)
								registers3.s3=0;
							if(registers3.s3>=registers4.s0)
								registers3.s3=registers4.s0-1;

							// will be weapon mount coordinate / hardpoint 
							projectileX[nextProjectileId]=shipModuleX[shipId + registers3.s2*N_SHIP_MAX];
							projectileY[nextProjectileId]=shipModuleY[shipId + registers3.s2*N_SHIP_MAX];
		
		
							mem_fence(CLK_LOCAL_MEM_FENCE);
							float radian_slope=atan2(targetDy[registers3.s3],targetDx[registers0.s3][registers3.s3]);
							dxdy.x=targetDx[registers0.s3][registers3.s3];
							dxdy.y=targetDy[registers3.s3];
							float vectR=rsqrt(dxdy.x*dxdy.x+dxdy.y*dxdy.y+0.001f);
							dxdy.x*=vectR;
							dxdy.y*=vectR;

							// box id is used instead of ship id. i is still i
							projectileRotation[nextProjectileId]=radian_slope + (3.14f)+tw_rnd(randSeeds,i)*0.2f - 0.1f;  
							projectileState[nextProjectileId]=1;
							shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX] -= SHIP_MODULE_CANNON_TURRET_ENERGY;
							projectileLife[nextProjectileId]=0;
							projectileDamage[nextProjectileId]=d4(randSeeds,i); 


							registers4.s1=1;
						}
					}
				}
				else if(registers4.s2==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO)
				{ 
					if((registers4.s3&SHIP_MODULE_STATE_WORKING)!=0)
					{ 
						if(shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX]>=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY)
						{ 
							// box id is used instead of ship id(i is still i)
							// random target from registered target list (max 10)
							registers3.s3 =  floor(tw_rnd(randSeeds,i)*(registers4.s0-1)+0.5f);
							if(registers3.s3<0)
								registers3.s3=0;
							if(registers3.s3>=registers4.s0)
								registers3.s3=registers4.s0-1;

							// will be weapon mount coordinate / hardpoint 
							projectileX[nextProjectileId]=shipModuleX[shipId + registers3.s2*N_SHIP_MAX];
							projectileY[nextProjectileId]=shipModuleY[shipId + registers3.s2*N_SHIP_MAX];
		
		
							mem_fence(CLK_LOCAL_MEM_FENCE);
							float radian_slope=atan2(targetDy[registers3.s3],targetDx[registers0.s3][registers3.s3]);
							dxdy.x=targetDx[registers0.s3][registers3.s3];
							dxdy.y=targetDy[registers3.s3];
							float vectR=rsqrt(dxdy.x*dxdy.x+dxdy.y*dxdy.y+0.001f);
							dxdy.x*=vectR;
							dxdy.y*=vectR;

							// box id is used instead of ship id. i is still i
							projectileRotation[nextProjectileId]=radian_slope + (3.14f)+tw_rnd(randSeeds,i)*0.3f - 0.15f;  
							projectileState[nextProjectileId]=1;
							shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX] -= SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY;
							projectileLife[nextProjectileId]=0;
							int damage=d4(randSeeds,i)-2;
							if(damage<1)
								damage=1;
							projectileDamage[nextProjectileId]=damage;
							registers4.s1=1;
						}
					}
				}
				else if(registers4.s2==SHIP_MODULE_TYPE_CANNON_TURRET_FRIGATE)
				{ 
					if((registers4.s3&SHIP_MODULE_STATE_WORKING)!=0)
					{ 
						if(shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX]>=SHIP_MODULE_CANNON_TURRET_ENERGY_FRIGATE)
						{ 
							// box id is used instead of ship id. i is still i
							registers3.s3 =  floor(tw_rnd(randSeeds,i)*(registers4.s0-1)+0.5f);
							if(registers3.s3<0)
								registers3.s3=0;
							if(registers3.s3>=registers4.s0)
								registers3.s3=registers4.s0-1;

							// will be weapon mount coordinate / hardpoint 
							projectileX[nextProjectileId]=shipModuleX[shipId + registers3.s2*N_SHIP_MAX];
							projectileY[nextProjectileId]=shipModuleY[shipId + registers3.s2*N_SHIP_MAX];
		
		
							mem_fence(CLK_LOCAL_MEM_FENCE);
							float radian_slope=atan2(targetDy[registers3.s3],targetDx[registers0.s3][registers3.s3]);
							dxdy.x=targetDx[registers0.s3][registers3.s3];
							dxdy.y=targetDy[registers3.s3];
							float vectR=rsqrt(dxdy.x*dxdy.x+dxdy.y*dxdy.y+0.001f);
							dxdy.x*=vectR;
							dxdy.y*=vectR;

							// box id is used instead of ship id. i is still i
							projectileRotation[nextProjectileId]=radian_slope + (3.14f)+tw_rnd(randSeeds,i)*0.2f - 0.1f;  
							projectileState[nextProjectileId]=1;
							shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX] -= SHIP_MODULE_CANNON_TURRET_ENERGY_FRIGATE;
							projectileLife[nextProjectileId]=0;						
							projectileDamage[nextProjectileId]=1+d6(randSeeds,i); 

							registers4.s1=1;
						}
					}
				}
				else if(registers4.s2==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE)
				{ 
					if((registers4.s3&SHIP_MODULE_STATE_WORKING)!=0)
					{ 
						if(shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX]>=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_FRIGATE)
						{ 
							// box id is used instead of ship id. i is still i
							registers3.s3 =  floor(tw_rnd(randSeeds,i)*(registers4.s0-1)+0.5f);
							if(registers3.s3<0)
								registers3.s3=0;
							if(registers3.s3>=registers4.s0)
								registers3.s3=registers4.s0-1;

							// will be weapon mount coordinate / hardpoint 
							projectileX[nextProjectileId]=shipModuleX[shipId + registers3.s2*N_SHIP_MAX];
							projectileY[nextProjectileId]=shipModuleY[shipId + registers3.s2*N_SHIP_MAX];
		
		
							mem_fence(CLK_LOCAL_MEM_FENCE);
							float radian_slope=atan2(targetDy[registers3.s3],targetDx[registers0.s3][registers3.s3]);
							dxdy.x=targetDx[registers0.s3][registers3.s3];
							dxdy.y=targetDy[registers3.s3];
							float vectR=rsqrt(dxdy.x*dxdy.x+dxdy.y*dxdy.y+0.001f);
							dxdy.x*=vectR;
							dxdy.y*=vectR;

							// box id is used instead of ship id. i is still i
							projectileRotation[nextProjectileId]=radian_slope + (3.14f)+tw_rnd(randSeeds,i)*0.3f - 0.15f;  
							projectileState[nextProjectileId]=1;
							shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX] -= SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_FRIGATE;
							projectileLife[nextProjectileId]=0;
							int damage=d6(randSeeds,i)-2;
							if(damage<1)
								damage=1;
							projectileDamage[nextProjectileId]=damage; 
							registers4.s1=1;
						}
					}
				}
				else if(registers4.s2==SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER)
				{ 
					if((registers4.s3&SHIP_MODULE_STATE_WORKING)!=0)
					{ 
						if(shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX]>=SHIP_MODULE_CANNON_TURRET_ENERGY_DESTROYER)
						{ 
							// box id is used instead of ship id. i is still i
							registers3.s3 =  floor(tw_rnd(randSeeds,i)*(registers4.s0-1)+0.5f);
							if(registers3.s3<0)
								registers3.s3=0;
							if(registers3.s3>=registers4.s0)
								registers3.s3=registers4.s0-1;

							// will be weapon mount coordinate / hardpoint 
							projectileX[nextProjectileId]=shipModuleX[shipId + registers3.s2*N_SHIP_MAX];
							projectileY[nextProjectileId]=shipModuleY[shipId + registers3.s2*N_SHIP_MAX];
		
		
							mem_fence(CLK_LOCAL_MEM_FENCE);
							float radian_slope=atan2(targetDy[registers3.s3],targetDx[registers0.s3][registers3.s3]);
							dxdy.x=targetDx[registers0.s3][registers3.s3];
							dxdy.y=targetDy[registers3.s3];
							float vectR=rsqrt(dxdy.x*dxdy.x+dxdy.y*dxdy.y+0.001f);
							dxdy.x*=vectR;
							dxdy.y*=vectR;

							// box id is used instead of ship id. i is still i
							projectileRotation[nextProjectileId]=radian_slope + (3.14f)+tw_rnd(randSeeds,i)*0.2f - 0.1f;  
							projectileState[nextProjectileId]=1;
							shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX] -= SHIP_MODULE_CANNON_TURRET_ENERGY_DESTROYER;
							projectileLife[nextProjectileId]=0;
							projectileDamage[nextProjectileId]=3+d12(randSeeds,i); 


							registers4.s1=1;

						}
					}
				}
				else if(registers4.s2==SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER)
				{ 
					if((registers4.s3&SHIP_MODULE_STATE_WORKING)!=0)
					{ 
						if(shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX]>=SHIP_MODULE_CANNON_TURRET_ENERGY_CRUISER)
						{ 
							// box id is used instead of ship id. i is still i
							registers3.s3 =  floor(tw_rnd(randSeeds,i)*(registers4.s0-1)+0.5f);
							if(registers3.s3<0)
								registers3.s3=0;
							if(registers3.s3>=registers4.s0)
								registers3.s3=registers4.s0-1;

							// will be weapon mount coordinate / hardpoint 
							projectileX[nextProjectileId]=shipModuleX[shipId + registers3.s2*N_SHIP_MAX];
							projectileY[nextProjectileId]=shipModuleY[shipId + registers3.s2*N_SHIP_MAX];
		
		
							mem_fence(CLK_LOCAL_MEM_FENCE);
							float radian_slope=atan2(targetDy[registers3.s3],targetDx[registers0.s3][registers3.s3]);
							dxdy.x=targetDx[registers0.s3][registers3.s3];
							dxdy.y=targetDy[registers3.s3];
							float vectR=rsqrt(dxdy.x*dxdy.x+dxdy.y*dxdy.y+0.001f);
							dxdy.x*=vectR;
							dxdy.y*=vectR;

							// box id is used instead of ship id. i is still i
							projectileRotation[nextProjectileId]=radian_slope + (3.14f)+tw_rnd(randSeeds,i)*0.2f - 0.1f;  
							projectileState[nextProjectileId]=1;
							shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX] -= SHIP_MODULE_CANNON_TURRET_ENERGY_CRUISER;
							projectileLife[nextProjectileId]=0;
							projectileDamage[nextProjectileId]=10+d8(randSeeds,i)+d8(randSeeds,i); 
							registers4.s1=1;
						}
					}
				}
				else if(registers4.s2==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER)
				{ 
					if((registers4.s3&SHIP_MODULE_STATE_WORKING)!=0)
					{ 
						if(shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX]>=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_DESTROYER)
						{ 
							// box id is used instead of ship id. i is still i
							registers3.s3 =  floor(tw_rnd(randSeeds,i)*(registers4.s0-1)+0.5f);
							if(registers3.s3<0)
								registers3.s3=0;
							if(registers3.s3>=registers4.s0)
								registers3.s3=registers4.s0-1;

							// will be weapon mount coordinate / hardpoint 
							projectileX[nextProjectileId]=shipModuleX[shipId + registers3.s2*N_SHIP_MAX];
							projectileY[nextProjectileId]=shipModuleY[shipId + registers3.s2*N_SHIP_MAX];
		
		
							mem_fence(CLK_LOCAL_MEM_FENCE);
							float radian_slope=atan2(targetDy[registers3.s3],targetDx[registers0.s3][registers3.s3]);
							dxdy.x=targetDx[registers0.s3][registers3.s3];
							dxdy.y=targetDy[registers3.s3];
							float vectR=rsqrt(dxdy.x*dxdy.x+dxdy.y*dxdy.y+0.001f);
							dxdy.x*=vectR;
							dxdy.y*=vectR;

							// box id is used instead of ship id. i is still i
							projectileRotation[nextProjectileId]=radian_slope + (3.14f)+tw_rnd(randSeeds,i)*0.3f - 0.15f;  
							projectileState[nextProjectileId]=1;
							shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX] -= SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_DESTROYER;
							projectileLife[nextProjectileId]=0;
							projectileDamage[nextProjectileId]=d12(randSeeds,i)-2; 

							registers4.s1=1;
						}
					}
				}
				else if(registers4.s2==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_CRUISER)
				{ 
					if((registers4.s3&SHIP_MODULE_STATE_WORKING)!=0)
					{ 
						if(shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX]>=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_CRUISER)
						{ 
							// box id is used instead of ship id. i is still i
							registers3.s3 =  floor(tw_rnd(randSeeds,i)*(registers4.s0-1)+0.5f);
							if(registers3.s3<0)
								registers3.s3=0;
							if(registers3.s3>=registers4.s0)
								registers3.s3=registers4.s0-1;

							// will be weapon mount coordinate / hardpoint 
							projectileX[nextProjectileId]=shipModuleX[shipId + registers3.s2*N_SHIP_MAX];
							projectileY[nextProjectileId]=shipModuleY[shipId + registers3.s2*N_SHIP_MAX];
		
		
							mem_fence(CLK_LOCAL_MEM_FENCE);
							float radian_slope=atan2(targetDy[registers3.s3],targetDx[registers0.s3][registers3.s3]);
							dxdy.x=targetDx[registers0.s3][registers3.s3];
							dxdy.y=targetDy[registers3.s3];
							float vectR=rsqrt(dxdy.x*dxdy.x+dxdy.y*dxdy.y+0.001f);
							dxdy.x*=vectR;
							dxdy.y*=vectR;

							// box id is used instead of ship id. i is still i
							projectileRotation[nextProjectileId]=radian_slope + (3.14f)+tw_rnd(randSeeds,i)*0.3f - 0.15f;  
							projectileState[nextProjectileId]=1;
							shipModuleEnergy[shipId + registers3.s2*N_SHIP_MAX] -= SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_CRUISER;
							projectileLife[nextProjectileId]=0;
							int damage=d8(randSeeds,i)+d8(randSeeds,i)-2; 
							if(damage<1)
								damage=1;
							projectileDamage[nextProjectileId]=damage;
							registers4.s1=1;
						}
					}
				}
				if(registers4.s1)
					break;
			}

			if(registers4.s1)
				continue;

			// new codes here
			// 

		}
	}
}

// game logic: check hitpoints, weapon charge, ... then apply game logic
// todo: make frametime dependant
__kernel void processShipStates(__global int *  restrict shipHp, 
								__global unsigned char * restrict  shipState, 
								__global int * restrict  shipShield,
								__global float * restrict frameTime)
{
	int i=get_global_id(0); // ship id
	if((shipHp[i]<=0) && ((shipState[i]&PROJECTILE_DEAD)==0))
	{
		shipState[i]=PROJECTILE_DEAD | PROJECTILE_EXPLOSION;
		shipHp[i]=30;// ship explosion life time ( in frame time  deprecated: simulation steps)
	}
	else if((shipHp[i]>0) && ((shipState[i]&PROJECTILE_EXPLOSION)!=0))
	{
		shipHp[i]-=floor(frameTime[2]+0.1f);
	}
	else if((shipHp[i]<=0) && ((shipState[i]&PROJECTILE_EXPLOSION)!=0))
	{
		shipState[i]=PROJECTILE_DEAD;
	}


}


// game logic: increment projectile states
// maximum life = 90 steps
// explosion life = 70 steps 
// then dead
__kernel void incrementProjectileStates(__global unsigned char * restrict  lives, __global unsigned char * restrict  states,
										__global unsigned int * restrict rndSeed,
										__global float * restrict frameTime)
{
	int i=get_global_id(0); // projectile id
	unsigned char life=lives[i];
	unsigned char state=states[i];
	if((state&PROJECTILE_DEAD)!=0)
		return;

	// is moving
	life+=((frameTime[2]>0.0f) ? (floor(frameTime[2]+0.1f)) : (int)0);

	// is exploding
	if((state&PROJECTILE_EXPLOSION)!=0)
	{
		if(life>(@@projectileLife@@+@@projectileExplosionLife@@))
		{ 
			state|=PROJECTILE_DEAD;
		}
	}
	else
	{ 
		// out of effective range
		if(life>@@projectileLife@@)
		{ 
			state|=PROJECTILE_DEAD;
		}
	}
	lives[i]=life;
	states[i]=state;
}

// game logic: projectile movement state
// only if projectile is alive or in explosion state
__kernel void moveProjectiles(__global float * restrict  x, __global float * restrict y, __global float * restrict  rotation, __global unsigned char * restrict  state,
							  __global float * restrict  shipX, __global float * restrict  shipY,
							  __global float * restrict engineFrameTime)
{
    int i=get_global_id(0);
	if((state[i]&PROJECTILE_DEAD)!=0)
		return;
	if((state[i]&PROJECTILE_EXPLOSION)!=0)
		return;
    float rot=rotation[i];

	if(engineFrameTime[0]>0.01f)
	{ 
		x[i] += (engineFrameTime[0]/33.0f)* 6.0f*cos(rot);
		y[i] += (engineFrameTime[0]/33.0f)* 6.0f*sin(rot);
	}

}


int findFirstCaptain(__global uchar * crewData,int shipId)
{ 
	for(int i=0;i<MAX_CREW_PER_SHIP;i++)
	{ 
		if(isCrewFirstCaptain(crewData[shipId+i*N_SHIP_MAX]))
			return shipId+i*N_SHIP_MAX;
	}
	return -1;
}


// game logic: check projectile - ship collisions using ship-box structure
// if collides, put projectile in an explosion state
// test: dead state for now
__kernel void checkProjectileShipCollisions(__global float * restrict  projectileX, __global float * restrict  projectileY,
											__global float * restrict  shipX, __global float * restrict  shipY,
											__global unsigned char * restrict  projectileStates, __global int *  restrict box,
											__global float * restrict  shipFrontX, __global float * restrict  shipFrontY,
											__global unsigned char * restrict  shipTeam, __global int * restrict  shipHp,
											__global unsigned int * restrict  randBuffer, __global int * restrict  shipShield,
											__global unsigned char * restrict  projectileLife, __global int *  restrict shieldDamaged,
											__global uchar * restrict shipSizeType, __global uchar * restrict shipModuleType,
											__global float * restrict shipModuleX, __global float * restrict shipModuleY,
											__global uchar * restrict shipModuleState , __global int * restrict shipModuleShieldDamaged,
											__global uchar4 * restrict shipPixels, __global float * restrict shipRotation,
											__global uchar * restrict projectileDamage, __global uchar * restrict shipState,
											__global int * restrict crewExperience, __global uchar * restrict crewData,
											__global uchar * restrict crewLevel,
											__global uchar * crewEvasionSkillLevel,
											__global int * projectileEvadedShipId,
											__global uchar * crewTacticalCriticalHitSkillLevel,
											__global uchar * projectileCritExplosion,
											__global uchar * crewFastLearningSkillLevel)
{
	int i=get_global_id(0); // projectile id
	unsigned char state = projectileStates[i];
	if((state&PROJECTILE_DEAD)!=0) // dead projectile
		return;
	if((state&PROJECTILE_EXPLOSION)!=0) // already exploded projectile
		return;
	float px0=projectileX[i];
	float py0=projectileY[i];
	

	int mapMaxX=@@mapWidth@@;

    int boxSize=@@searchBoxSize@@;

	unsigned char currentTeam=shipTeam[i%N_SHIP_MAX];

	// todo: uchar4 instead of int for values < 256 (increase occupation)
	int minDistance=SHIP_SIZE+PROJECTILE_SIZE;
	//int minDistance2=5+PROJECTILE_SIZE; // front
	int shieldMinDistance = 20 + SHIP_SIZE + PROJECTILE_SIZE + SHIP_SHIELD_DISTANCE;
	int shieldMinDistanceReal = PROJECTILE_SIZE + SHIP_SHIELD_DISTANCE;
    float xf=px0;
    float yf=py0;
    int found=0;
	int foundModuleId=0;
    int foundShipId=-1;
                                                                                
    
    int boxX= px0/boxSize;
    int boxY= py0/boxSize;
    int boxId=boxX + boxY*(mapMaxX/boxSize);
	int shieldDamagedAnimation=0;
	char frontDamageReduction=0;
    for(int w=-1;w<=1;w++)
    {
        int wi=w*(mapMaxX/boxSize);
        for(int h=-1;h<=1;h++)
        {

            int boxIdCurrent=boxId+h+wi;
            if((boxIdCurrent<2) || (boxIdCurrent>=@@((mapHeight/searchBoxSize)*(mapWidth/searchBoxSize))@@-2))
                continue;
            int nShipsInBox=box[boxIdCurrent];
            if(nShipsInBox>=@@maxShipsPerBox@@)
                 nShipsInBox=@@maxShipsPerBox@@-1;
            for(int j=0;j<nShipsInBox;j++)
            {
                        
                int selectedShipId=box[boxIdCurrent+(j+1)*N_SHIP_BOX_LAYER];
			
                // check if (xf,yf) is in ship hull
                if( (selectedShipId>=0) && (selectedShipId<@@nShip@@))
                {
					if(currentTeam==shipTeam[selectedShipId])
						continue;

					if((shipState[selectedShipId]&PROJECTILE_EXPLOSION)!=0)
						continue;

                    float dx=xf-shipX[selectedShipId];
                    float dy=yf-shipY[selectedShipId];
					float shipSizeComplete = shipSizeType[selectedShipId]*SHIP_SIZE;
					float shipSizeComplete2 = shipSizeType[selectedShipId]*5;

					// check if its in a ship's bounding area
					// todo: check shield generator positions and shield radius
					if((dx*dx + dy*dy)<((shieldMinDistance+shipSizeComplete) * (shieldMinDistance+shipSizeComplete)))
					{
						// if ship has not already evaded this projectile
						if(projectileEvadedShipId[i]==selectedShipId)
							continue;

						// iterate over all modules

						for(int im=0;im<MAX_MODULES_PER_SHIP;im++)
						{ 
							// if shield generator, check if in shield radius 
							// using shieldMinDistanceReal + normal heavy capital
							if(shipModuleType[selectedShipId + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR)
							{ 
								// only if it is working
								if((shipModuleState[selectedShipId + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
								{ 
									float dxModule = xf - shipModuleX[selectedShipId + im *N_SHIP_MAX];
									float dyModule = yf - shipModuleY[selectedShipId + im *N_SHIP_MAX];
								
									if(dxModule*dxModule + dyModule*dyModule < 
									(shieldMinDistanceReal+SHIP_MODULE_SHIELD_GENERATOR_SHIELD_RADIUS)*
									(shieldMinDistanceReal+SHIP_MODULE_SHIELD_GENERATOR_SHIELD_RADIUS))
									{ 
										// check if ship has some shield hitpoints left
										int shieldDamagedAnimationTmp=atomic_add(&shipShield[selectedShipId],0);
										if(shieldDamagedAnimationTmp>0)
										{ 
											found=1;

											if(foundShipId<selectedShipId)
											{ 
												foundShipId=selectedShipId; 
												foundModuleId=im;
												shieldDamagedAnimation=shieldDamagedAnimationTmp;
											}
											break;	
										}
									}
								}
							}
							else
							if(shipModuleType[selectedShipId + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE)
							{ 
								// only if it is working
								if((shipModuleState[selectedShipId + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
								{ 
									float dxModule = xf - shipModuleX[selectedShipId + im *N_SHIP_MAX];
									float dyModule = yf - shipModuleY[selectedShipId + im *N_SHIP_MAX];
								
									if(dxModule*dxModule + dyModule*dyModule < 
									(shieldMinDistanceReal+SHIP_MODULE_SHIELD_GENERATOR_FRIGATE_SHIELD_RADIUS)*
									(shieldMinDistanceReal+SHIP_MODULE_SHIELD_GENERATOR_FRIGATE_SHIELD_RADIUS))
									{ 
										// check if ship has some shield hitpoints left
										int shieldDamagedAnimationTmp=atomic_add(&shipShield[selectedShipId],0);
										if(shieldDamagedAnimationTmp>0)
										{ 
											found=1;
											if(foundShipId<selectedShipId)
											{ 
												foundShipId=selectedShipId; 
												foundModuleId=im;
												shieldDamagedAnimation=shieldDamagedAnimationTmp;
											}
											break;	
										}
									}
								}
							}
							else
							if(shipModuleType[selectedShipId + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_DESTROYER)
							{ 
								// only if it is working
								if((shipModuleState[selectedShipId + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
								{ 
									float dxModule = xf - shipModuleX[selectedShipId + im *N_SHIP_MAX ];
									float dyModule = yf - shipModuleY[selectedShipId + im *N_SHIP_MAX];
								
									if(dxModule*dxModule + dyModule*dyModule < 
									(shieldMinDistanceReal+SHIP_MODULE_SHIELD_GENERATOR_DESTROYER_SHIELD_RADIUS)*
									(shieldMinDistanceReal+SHIP_MODULE_SHIELD_GENERATOR_DESTROYER_SHIELD_RADIUS))
									{ 
										// check if ship has some shield hitpoints left
										int shieldDamagedAnimationTmp=atomic_add(&shipShield[selectedShipId],0);
										if(shieldDamagedAnimationTmp>0)
										{ 
											found=1;
											if(foundShipId<selectedShipId)
											{ 
												foundShipId=selectedShipId; 
												foundModuleId=im;
												shieldDamagedAnimation=shieldDamagedAnimationTmp;
											}
											break;	
										}
									}
								}
							}
							else
							if(shipModuleType[selectedShipId + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER)
							{ 
								// only if it is working
								if((shipModuleState[selectedShipId + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
								{ 
									float dxModule = xf - shipModuleX[selectedShipId + im *N_SHIP_MAX ];
									float dyModule = yf - shipModuleY[selectedShipId + im *N_SHIP_MAX];
								
									if(dxModule*dxModule + dyModule*dyModule < 
									(shieldMinDistanceReal+SHIP_MODULE_SHIELD_GENERATOR_CRUISER_SHIELD_RADIUS)*
									(shieldMinDistanceReal+SHIP_MODULE_SHIELD_GENERATOR_CRUISER_SHIELD_RADIUS))
									{ 
										// check if ship has some shield hitpoints left
										int shieldDamagedAnimationTmp=atomic_add(&shipShield[selectedShipId],0);
										if(shieldDamagedAnimationTmp>0)
										{ 
											found=1;
											if(foundShipId<selectedShipId)
											{ 
												foundShipId=selectedShipId; 
												foundModuleId=im;
												shieldDamagedAnimation=shieldDamagedAnimationTmp;
											}
											break;	
										}
									}
								}
							}
						}
					}

					// check if its in ship bounding area
                    if((dx*dx + dy*dy)<((minDistance+shipSizeComplete+15.0f)*(minDistance+shipSizeComplete+15.0f)))
                    {

						// if there is a ship pixel(hull) in this projectile position
						int shipTeamAndTypeBitmapOffset=offsets0[shipSizeType[selectedShipId]]; 
						shipTeamAndTypeBitmapOffset+=offsets1[shipTeam[selectedShipId]]; 
						int shipSquareBitmapWidth = shipSizes[shipSizeType[selectedShipId]];

						float bitmapX= xf - shipX[selectedShipId];
						float bitmapY= yf - shipY[selectedShipId];
						float sr = degreeToRadian(270.0f-shipRotation[selectedShipId]);
						float cosSr=cos(sr);
						float sinSr=sin(sr);
						float bX2 = bitmapX * cosSr - bitmapY * sinSr;
						float bY2 = bitmapX * sinSr + bitmapY * cosSr;
						int bX = bX2+shipSquareBitmapWidth/2;
						int bY = bY2+shipSquareBitmapWidth/2;
						if((bX>=0) && (bX<shipSquareBitmapWidth) && (bY>=0) && (bY<shipSquareBitmapWidth))
						{ 
							uchar4 sampledPixel=shipPixels[bX + shipSquareBitmapWidth*bY + shipTeamAndTypeBitmapOffset];
							// if projectile hits a ship pixel
							if(sampledPixel.s3!=0)
							{ 
								// if ship evades projectile (by captain's evasive maneuver skill)
								int cap=findFirstCaptain(crewData, selectedShipId);
								if(cap<0)
								{ 
									// no captain found, no evasion, %100 hit
									found=1;
									if(foundShipId<selectedShipId)
										foundShipId=selectedShipId; 
									continue;
								}
								else
								{ 
									int capSkillLevel=crewEvasionSkillLevel[cap];
									if(capSkillLevel==0)
									{ 
										// no captain skill level, %100 hit
										found=1;
										if(foundShipId<selectedShipId)
											foundShipId=selectedShipId; 
										continue;
									}
									else
									{ 
										int minDiceNeeded = 21 - capSkillLevel;
										int roll = d20(randBuffer,i);
										if(roll>=minDiceNeeded)
										{ 
											// ship evaded projectile
											// will continue to evade on next collisions
											projectileEvadedShipId[i]=selectedShipId;
										}
										else
										{ 
											// evasion failed
											found=1;
											if(foundShipId<selectedShipId)
												foundShipId=selectedShipId; 
											continue;
										}
									}
								}

							}
						}
                    }


                }



            }
        }
    }

	if(found>0)
	{
		//projectileStates[i]=state|PROJECTILE_DEAD;
		projectileStates[i]=state|PROJECTILE_EXPLOSION;
		int damage = projectileDamage[i];
		bool crit=false;
		int capId=findFirstCaptain(crewData,i%N_SHIP_MAX);
		if(capId>=0)
		{ 
			int criticalSkillLevel=crewTacticalCriticalHitSkillLevel[capId];
			int minDice=21-criticalSkillLevel;
			crit=(d20(randBuffer,i)>=minDice);
		}

		projectileLife[i]=(@@projectileLife@@)+d6(randBuffer,i)*(crit?-2:1);




		projectileCritExplosion[i]=(crit?1:0);

		int damageTmp=damage;
		int currentShield=atomic_add(&shipShield[foundShipId],-damage); // shield gets damage first
		int damagedShield=currentShield-damage;
		mem_fence(CLK_GLOBAL_MEM_FENCE);
		if(currentShield>=0)
		{ 
			atomic_add(&shieldDamaged[foundShipId],4); // for later shield animation, for 4 time steps
			if(damagedShield<0)
				damage=-damagedShield; // if shield is depleted, damage done to ship hull is negative of negative shield
			else
				damage=frontDamageReduction + 1 + shipSizeType[foundShipId]; //  equal to damage reduction (0 heals ship)
		}
		else
		{ 
			// no shield
			damage=damageTmp;
			if(damage<(frontDamageReduction+1+ shipSizeType[foundShipId]))
				damage=(frontDamageReduction+1+ shipSizeType[foundShipId]);
		}
		int hpBefore= atomic_add(&shipHp[foundShipId],0);
		mem_fence(CLK_GLOBAL_MEM_FENCE);
		// else, damage is directly done to hull
		// but only if it is beam based weapon
		// projectile/explosive doesn't damage until it reaches hull

		int shipSizeTypeTmp=shipSizeType[foundShipId];

		if(shieldDamagedAnimation==0)
		{
			if(crit) 
			{ 
				damage*=3;
			}
			atomic_add(&shipHp[foundShipId],-damage+(frontDamageReduction+1+ shipSizeTypeTmp)); // front hull has more damage reduction
		}
		else
			atomic_add(&shipModuleShieldDamaged[foundShipId + foundModuleId * N_SHIP_MAX],16);
			
		mem_fence(CLK_GLOBAL_MEM_FENCE);

		int hpAfter= atomic_add(&shipHp[foundShipId],0);

		// if enemy ship is destroyed by this projectile's ship's damage contribution
		if((hpBefore>0) && (hpAfter<=0))
		{ 
			// gain experience for attacker ship
			
			
			int firstCaptainId = findFirstCaptain(crewData,i%N_SHIP_MAX/* current ship(attacker) */);
			if(firstCaptainId>=0)
			{ 
				// if there is a first captain in ship, add experience
				// depending on target ship class, its captain's level and this captain's fast learnin skill
				atomic_add(&crewExperience[firstCaptainId],
				1+shipSizeTypeTmp+
				crewLevel[findFirstCaptain(crewData,foundShipId%N_SHIP_MAX)]+
				crewFastLearningSkillLevel[firstCaptainId]);
			}
		}
	}

}

// render output (projectiles)
// for each pixel, search for projectiles in near-projectile-boxes to draw
// -point on line- algorithm for projectile
// -point in circle- algorithm for explosion
__kernel void renderProjectilesToTexture(__global uchar4 * restrict  buf, __global int * restrict  pBox,
                                            __global float * restrict  pX, __global float * restrict  pY,
                                            __global float * restrict  parametersFloat, __global int * restrict  parametersInt,
                                            __global unsigned char * restrict  shipTeam, __global float * restrict  pRotation,
                                            __global unsigned char * restrict  pState, __global unsigned char * restrict  pLife,
											__global uchar * restrict shipSizeType, __global uchar4 * restrict projectilePixels,
											__global uchar4 * skyPixels, __global float * restrict bufLightR,
											__global uchar * pixelUsed,__global float * restrict bufLightG,
											__global float * restrict bufLightB,
											__global uchar * restrict projectileCritExplosion)
{
    int i=get_global_id(0); // pixel id
	
	// blocked computing with 16x16 patches of pixels
	int patchId = i/PROJECTILE_RENDER_PATCH_SIZE;

	// pixel's coordinates in its patch
	int localX = i%PROJECTILE_RENDER_PATCH_SIZE_SQRT;
	int localY = (i/PROJECTILE_RENDER_PATCH_SIZE_SQRT)%PROJECTILE_RENDER_PATCH_SIZE_SQRT;

	// first element of each patch will have this X and Y offsets
	int patchX = (patchId % (RENDER_WIDTH/PROJECTILE_RENDER_PATCH_SIZE_SQRT)) * PROJECTILE_RENDER_PATCH_SIZE_SQRT;
	int patchY = (patchId / (RENDER_WIDTH/PROJECTILE_RENDER_PATCH_SIZE_SQRT)) * PROJECTILE_RENDER_PATCH_SIZE_SQRT;

	int blockX=patchX + localX;
	int blockY=patchY + localY;

	// conversion from scanline to blocked
	i=blockX + blockY * RENDER_WIDTH;

    int mapMaxX=@@mapWidth@@;

    int maxProjectilesPerBox=@@maxProjectilesPerBox@@;
    int nShipProjectiles=@@nShipProjectiles@@;
    int projectileSearchBoxSize=@@projectileSearchBoxSize@@;
	int totalMaxProjectiles=@@nShip@@*nShipProjectiles;

    float scale=parametersFloat[0];
    float translateX=parametersFloat[1];
    float translateY=parametersFloat[2];
                                        
    int x0=((i%RENDER_WIDTH)*scale + (translateX))-(RENDER_WIDTH/2)*scale;
    int y0=((i/RENDER_WIDTH)*scale + (translateY))-(RENDER_HEIGHT/2)*scale;
    float xf=x0;
    float yf=y0;
    int found=0;
    int foundProjectileId=-1;

    int boxX= x0/projectileSearchBoxSize;
    int boxY= y0/projectileSearchBoxSize;
    int boxId=boxX + boxY*(mapMaxX/projectileSearchBoxSize);
	float explosionSize = 0.0f;
	float lightR=0.0f;
	float lightG=0.0f;
	float lightB=0.0f;
	uchar4 foundProjectilePixel = (uchar4)(255,255,255,255);
    for(int w=-1;w<=1;w++)
    {
        int wi=w*(mapMaxX/projectileSearchBoxSize);
        for(int h=-1;h<=1;h++)
        {

            int boxIdCurrent=boxId+h+wi;
            if((boxIdCurrent<2) || (boxIdCurrent>=@@((mapHeight/projectileSearchBoxSize)*(mapWidth/projectileSearchBoxSize))@@-2))
                continue;
            int nProjectilesInBox=pBox[boxIdCurrent];

            // nProjectilesInBox is not overflowing
            if(nProjectilesInBox>=maxProjectilesPerBox)
                nProjectilesInBox=maxProjectilesPerBox-1;
            
            for(int j=0;j<nProjectilesInBox;j++)
            {
                // todo: check projectile data layout: strided - parallel
                int selectedProjectileId=pBox[boxIdCurrent+(j+1)*N_PROJECTILE_BOX_LAYER];
                // check if (xf,yf) is in projectile
                if( (selectedProjectileId>=0) && (selectedProjectileId<totalMaxProjectiles))
                {
					unsigned char tmpState = pState[selectedProjectileId];
					int tmpSize= 10+ PROJECTILE_SIZE + PROJECTILE_SIZE*shipSizeType[selectedProjectileId%N_SHIP_MAX];
					if((tmpState&PROJECTILE_DEAD)!=0)
						continue;
					if((tmpState&PROJECTILE_EXPLOSION)!=0)
						tmpSize= ((((@@projectileLife@@+@@projectileExplosionLife@@) - pLife[selectedProjectileId]))) ;
					
                    float dx=xf-pX[selectedProjectileId];
                    float dy=yf-pY[selectedProjectileId];
					float dr=(dx*dx + dy*dy);
					float tmpDr=(tmpSize*tmpSize);
					int shipIdOfSelectedProjectile = selectedProjectileId%N_SHIP_MAX;
					uchar stTmp=shipTeam[shipIdOfSelectedProjectile];
					float tmpEfct= 5.0f/(dr+3.0f);
					
					if((pState[selectedProjectileId]&PROJECTILE_EXPLOSION)==0)
					{ 
						if(dr<325.0f)
						{ 
								if(stTmp==0)
									lightR += tmpEfct*2.0f;
								else if(stTmp==1)
									lightG += tmpEfct*2.0f;
								else if(stTmp==2)
									lightB += tmpEfct*2.0f;
						}
					}
					else
					{ 
						if(dr<725.0f)
						{ 
							float explosionSizeTmp=(10.0f - dr/tmpDr);
							if(explosionSizeTmp<0.0f)
								explosionSizeTmp=0.01f;
							if(stTmp==0)
							{lightR += tmpEfct*explosionSizeTmp; lightG += tmpEfct*explosionSizeTmp;lightB += tmpEfct*explosionSizeTmp;}
							else if(stTmp==1)
							{ 	lightR += tmpEfct*explosionSizeTmp;lightG += tmpEfct*explosionSizeTmp;lightB += tmpEfct*explosionSizeTmp;}
							else if(stTmp==2)
							{ lightR += tmpEfct*explosionSizeTmp;lightG += tmpEfct*explosionSizeTmp;lightB += tmpEfct*explosionSizeTmp;}
						}
					}
					// if inside of bounding area of projectile
                    if(dr<tmpDr)
                    {
						if((pState[selectedProjectileId]&PROJECTILE_EXPLOSION)!=0)
						{ 								
							explosionSize=dr/tmpDr;
							found=1;
							if(foundProjectileId<selectedProjectileId)
							{   
								foundProjectileId=selectedProjectileId; 
							}

							break;
						}
						float bitmapX= dx;
						float bitmapY= dy;
						float sr = degreeToRadian( 270.0f - radianToDegree( pRotation[selectedProjectileId]));
						float cosSr=cos(sr);
						float sinSr=sin(sr);
						float bX2 = bitmapX * cosSr - bitmapY * sinSr;
						float bY2 = bitmapX * sinSr + bitmapY * cosSr;
						int bX = bX2+1; // projectile bitmap size / 2
						int bY = bY2+5; // projectile bitmap size / 2
						if((bX>=0) && (bX<3) && (bY>=0) && (bY<10))
						{ 
						    int projectileTeamOffset=shipTeam[shipIdOfSelectedProjectile];
							uchar4 sampledPixel=projectilePixels[bX + 3*bY + 30* projectileTeamOffset];
							if(sampledPixel.s3!=0)
							{ 
								found=1;
								if(foundProjectileId<selectedProjectileId)
								{   
									foundProjectileId=selectedProjectileId; 
								}

								foundProjectilePixel=sampledPixel;

							}
							
						}
                    }
                }
            }
        }
    }

    if(found>0)
    {
        //uchar st=shipTeam[foundProjectileId%N_SHIP_MAX];
		// projectile is in explosion animation
        
		if(((pState[foundProjectileId]&PROJECTILE_EXPLOSION)!=0))
		{
			// not critical explosion
			if(projectileCritExplosion[foundProjectileId]==0)
			{ 
				uchar red=255;
				uchar green=255-255*explosionSize;
				uchar blue=255-255*explosionSize;
				uchar alpha=255;
				// explosion being beneath of ship is 1 and 2 on 1d4. same height is 3. above is 4 on 1d4
				pixelUsed[i]=1;
				buf[i]=(uchar4)(blue,green,red,alpha);	
			}
			else
			{ 
				uchar red=255;
				uchar green=255-255*explosionSize;
				uchar blue=0; // criticl hit = yellow explosion
				uchar alpha=255;
				// explosion being beneath of ship is 1 and 2 on 1d4. same height is 3. above is 4 on 1d4
				pixelUsed[i]=1;
				buf[i]=(uchar4)(blue,green,red,alpha);		
			}
		}
		else
		{
			// no explosion, only projectile pixel
			if(foundProjectilePixel.s0!=0)
			{ 
				buf[i]=foundProjectilePixel;
				pixelUsed[i]=1;
			}
			else
			{ 
				pixelUsed[i]=0;
			}
		}
    }
	else
	{ 
		pixelUsed[i]=0;
		// render sky
		bufLightR[i]=lightR;
		bufLightG[i]=lightG;
		bufLightB[i]=lightB;
		float bitmapX=((xf - MAP_WIDTH/2) + ((xf )*5.0f - translateX*5.0f)/scale)*0.2f;
		float bitmapY=((yf - MAP_WIDTH/2) + ((yf )*5.0f - translateY*5.0f)/scale)*0.2f;
		float sr = degreeToRadian(270.0f);
		float cosSr=cos(sr);
		float sinSr=sin(sr);
		float bX2 = bitmapX * cosSr - bitmapY * sinSr;
		float bY2 = bitmapX * sinSr + bitmapY * cosSr;
		int bX = bX2+SKY_BITMAP_WIDTH/2;
		int bY = bY2+SKY_BITMAP_HEIGHT/2;
		if((bX>=0) && (bX<SKY_BITMAP_WIDTH) && (bY>=0) && (bY<SKY_BITMAP_HEIGHT))
		{ 
			uchar4 result=skyPixels[bX + bY * SKY_BITMAP_WIDTH];
			if(result.s3!=0)
				buf[i]=(uchar4)((result.s0*2.2f)/3.0f,(result.s1*1.2f)/3.0f,(result.s2*1.2f)/3.0f,255);
		}
	}

}

// clear texture
__kernel void clearTexture(__global uchar4 * restrict  buf)
{ 
    int i=get_global_id(0); // pixel id
	uchar red=0;
    uchar green=0;
    uchar blue=0;
    uchar alpha=255;
    buf[i]=(uchar4)(blue,green,red,alpha);
}

// postprocess (smooth)
__kernel void postProcessSmooth(__global uchar4 * restrict  buf, 
                                __global uchar4 * restrict  bufTmp, __global float * restrict userInterface, 
                                __global float * restrict userInterface2)
{
	int i=get_global_id(0); // pixel id
    if(i==0)
    {
        float tft=0.0f;
        userInterface2[0]=userInterface[0];
        mem_fence(CLK_GLOBAL_MEM_FENCE);

        for(int j=100;j>0;j--)
        {
            userInterface2[j]=userInterface2[j-1];
            mem_fence(CLK_GLOBAL_MEM_FENCE);
            tft+=userInterface2[j];
        }
        tft*=0.01f;
        userInterface2[0]=1000.0f/tft;
        userInterface2[101]=userInterface[1];
    }
	// blocked computing with 16x16 patches of pixels
	int patchId = i/256;

	// pixel's coordinates in its patch
	int localX = i%16;
	int localY = (i/16)%16;

	// first element of each patch will have this X and Y offsets
	int patchX = (patchId % (RENDER_WIDTH/16)) * 16;
	int patchY = (patchId / (RENDER_WIDTH/16)) * 16;

	int blockX=patchX + localX;
	int blockY=patchY + localY;

	// conversion from scanline to blocked
	i=blockX + blockY * RENDER_WIDTH;

	float averageRed=0.0f;
	float averageGreen=0.0f;
	float averageBlue=0.0f;

	float averageRed2=0.0f;
	float averageGreen2=0.0f;
	float averageBlue2=0.0f;
	int iMRenderWidth = i%RENDER_WIDTH;
	int iDRenderWidth = i/RENDER_WIDTH;
	float averageDivider=0;
	float averageDivider2=0;
	for(int h=-2;h<=2;h++)
	{
		int hi=h*RENDER_WIDTH;
		if((((iDRenderWidth)+h)>=0) && (((iDRenderWidth)+h)<(RENDER_HEIGHT)))
		for(int w=-2;w<2;w++)
		{
			int index=w+i+hi;
			if((((iMRenderWidth)+w)>=0) && (((iMRenderWidth)+w)<(RENDER_WIDTH)))
			{ 
				if(h*h + w*w <= 8)
				{ 
					uchar4 tmp=buf[index];
					uchar red=tmp.z;
					uchar green=tmp.y;
					uchar blue=tmp.x;
					averageRed+=red;
					averageGreen+=green;
					averageBlue+=blue;
					averageDivider+=1.0f;
				}
			}
		}
	}

	for(int h=-1;h<=1;h++)
	{
		int hi=h*RENDER_WIDTH;
		if((((iDRenderWidth)+h)>=0) && (((iDRenderWidth)+h)<(RENDER_HEIGHT)))
		for(int w=-1;w<=1;w++)
		{
			int index=w+i+hi;
			if((((iMRenderWidth)+w)>=0) && (((iMRenderWidth)+w)<(RENDER_WIDTH)))
			{ 
				if(h*h + w*w <= 2)
				{ 
					uchar4 tmp=buf[index];
					uchar red=tmp.z;
					uchar green=tmp.y;
					uchar blue=tmp.x;
					averageRed2+=red;
					averageGreen2+=green;
					averageBlue2+=blue;
					averageDivider2+=1.0f;
				}
			}
		}
	}
	uchar4 inp = buf[i];

	float resultRed = -averageRed/(averageDivider*10.0f) -  averageRed2/(averageDivider2*10.0f) + ((float)inp.z*1.2f);
	float resultGreen = -averageGreen/(averageDivider*10.0f) -  averageGreen2/(averageDivider2*10.0f)+ ((float)inp.y*1.2f);
	float resultBlue = -averageBlue/(averageDivider*10.0f) -  averageBlue2/(averageDivider2*10.0f)+ ((float)inp.x*1.2f);
	if(resultRed>255.0f)
		resultRed=255.0f;

	if(resultGreen>255.0f)
		resultGreen=255.0f;

	if(resultBlue>255.0f)
		resultBlue=255.0f;

	if(resultRed<0.0f)
		resultRed=0.0f;

	if(resultGreen<0.0f)
		resultGreen=0.0f;

	if(resultBlue<0.0f)
		resultBlue=0.0f;


	uchar4 result = (uchar4)(resultBlue,resultGreen,resultRed,255);
	bufTmp[i] = result;
}



// postprocess output
__kernel void postProcessOutput(__global uchar4 *  restrict buf, __global uchar4 * restrict  bufTmp,
								__global int * restrict numShips,__global int * restrict crewLevelHistogram,
                                __global uchar4 * restrict charBuf, __global float * restrict userInterface2)
{ 
	int i=get_global_id(0); // pixel id
	uchar4 val = bufTmp[i];
    float xf = i%RENDER_WIDTH;
    float yf = i/RENDER_WIDTH;
    if(yf<32.0f)
    {
        int spsI=(int)userInterface2[0];
        int spsI_1000=(spsI/1000)%10;
        int spsI_100=(spsI/100)%10;
        int spsI_10=(spsI/10)%10;
        int spsI_1=spsI%10;
        int spsI_01=((int)(userInterface2[0]*10))%10;
        uchar sps[10]={'S','P','S',':','0'+spsI_100,'0'+spsI_10,'0'+spsI_1,'.','0'+spsI_01,' '};

        int nst1=numShips[0];
        int nst1_1000000=(nst1/1000000)%10;
        int nst1_100000=(nst1/100000)%10;
        int nst1_10000=(nst1/10000)%10;
        int nst1_1000=(nst1/1000)%10;
        int nst1_100=(nst1/100)%10;
        int nst1_10=(nst1/10)%10;
        int nst2=numShips[1];
        int nst2_1000000=(nst2/1000000)%10;
        int nst2_100000=(nst2/100000)%10;
        int nst2_10000=(nst2/10000)%10;
        int nst2_1000=(nst2/1000)%10;
        int nst2_100=(nst2/100)%10;
        int nst2_10=(nst2/10)%10;
        int nst3=numShips[2];
        int nst3_1000000=(nst3/1000000)%10;
        int nst3_100000=(nst3/100000)%10;
        int nst3_10000=(nst3/10000)%10;
        int nst3_1000=(nst3/1000)%10;
        int nst3_100=(nst3/100)%10;
        int nst3_10=(nst3/10)%10;

    
        uchar ns[64]={'N','u','m','b','e','r',' ','o','f',' ','s','h','i','p','s',':',
            ' ',' ',
            't','e','a','m','-','1','=',
            '0'+nst1_1000000,'0'+nst1_100000,'0'+nst1_10000,'0'+nst1_1000,'0'+nst1_100,'0'+nst1_10,'0'+(nst1%10),
            ' ',' ',
            't','e','a','m','-','2','=',
            '0'+nst2_1000000,'0'+nst2_100000,'0'+nst2_10000,'0'+nst2_1000,'0'+nst2_100,'0'+nst2_10,'0'+(nst2%10),
            ' ',' ',
            't','e','a','m','-','3','=',
            '0'+nst3_1000000,'0'+nst3_100000,'0'+nst3_10000,'0'+nst3_1000,'0'+nst3_100,'0'+nst3_10,'0'+(nst3%10)
            };


        int cl2=(int)crewLevelHistogram[1];
        int cl2_1000000=(cl2/1000000)%10;
        int cl2_100000=(cl2/100000)%10;
        int cl2_10000=(cl2/10000)%10;
        int cl2_1000=(cl2/1000)%10;
        int cl2_100=(cl2/100)%10;
        int cl2_10=(cl2/10)%10;

        int cl3=(int)crewLevelHistogram[2];
        int cl3_1000000=(cl3/1000000)%10;
        int cl3_100000=(cl3/100000)%10;
        int cl3_10000=(cl3/10000)%10;
        int cl3_1000=(cl3/1000)%10;
        int cl3_100=(cl3/100)%10;
        int cl3_10=(cl3/10)%10;

        int cl5=(int)crewLevelHistogram[4];
        int cl5_1000000=(cl5/1000000)%10;
        int cl5_100000=(cl5/100000)%10;
        int cl5_10000=(cl5/10000)%10;
        int cl5_1000=(cl5/1000)%10;
        int cl5_100=(cl5/100)%10;
        int cl5_10=(cl5/10)%10;

        int cl10=(int)crewLevelHistogram[9];
        int cl10_1000000=(cl10/1000000)%10;
        int cl10_100000=(cl10/100000)%10;
        int cl10_10000=(cl10/10000)%10;
        int cl10_1000=(cl10/1000)%10;
        int cl10_100=(cl10/100)%10;
        int cl10_10=(cl10/10)%10;

        int cl15=(int)crewLevelHistogram[14];
        int cl15_1000000=(cl15/1000000)%10;
        int cl15_100000=(cl15/100000)%10;
        int cl15_10000=(cl15/10000)%10;
        int cl15_1000=(cl15/1000)%10;
        int cl15_100=(cl15/100)%10;
        int cl15_10=(cl15/10)%10;

        uchar tc[103]={'T','e','a','m','-','1',' ','c','a','p','t','a','i','n','s',':',
                      ' ',' ','l','e','v','e','l','-','2','=','0'+cl2_1000000,'0'+cl2_100000,'0'+cl2_10000,'0'+cl2_1000,'0'+cl2_100,'0'+cl2_10,'0'+(cl2%10),
                      ' ',' ','l','e','v','e','l','-','3','=','0'+cl3_1000000,'0'+cl3_100000,'0'+cl3_10000,'0'+cl3_1000,'0'+cl3_100,'0'+cl3_10,'0'+(cl3%10),
                      ' ',' ','l','e','v','e','l','-','5','=','0'+cl5_1000000,'0'+cl5_100000,'0'+cl5_10000,'0'+cl5_1000,'0'+cl5_100,'0'+cl5_10,'0'+(cl5%10),
                      ' ',' ','l','e','v','e','l','-','1','0','=','0'+cl10_1000000,'0'+cl10_100000,'0'+cl10_10000,'0'+cl10_1000,'0'+cl10_100,'0'+cl10_10,'0'+(cl10%10),
                      ' ',' ','l','e','v','e','l','-','1','5','=','0'+cl15_1000000,'0'+cl15_100000,'0'+cl15_10000,'0'+cl15_1000,'0'+cl15_100,'0'+cl15_10,'0'+(cl15%10)
        };


        int scr=(int)userInterface2[101];
        int scr_100000=(scr/100000)%10;
        int scr_10000=(scr/10000)%10;
        int scr_1000=(scr/1000)%10;
        int scr_100=(scr/100)%10;
        int scr_10=(scr/10)%10;
        int scr_01=((int)(userInterface2[101]*10.0f))%10;
        int scr_001=((int)(userInterface2[101]*100.0f))%10;
        int scr_0001=((int)(userInterface2[101]*1000.0f))%10;
        int scr_00001=((int)(userInterface2[101]*10000.0f))%10;
        uchar sc[17]={'S','c','o','r','e',':','0'+scr_100000,'0'+scr_10000,'0'+scr_1000,'0'+scr_100,'0'+scr_10,'0'+(scr%10),'.','0'+scr_01,'0'+scr_001,'0'+scr_0001,'0'+scr_00001};


        // render simulations per second
        for(int j=0;j<10;j++)
        {
            int curChar = sps[j];
            float charX=320.0f+12*j; // center of char
            float charY=8.0f; // center of char
            float bitmapX= xf - charX;
            float bitmapY= yf - charY;

            int bX = bitmapX+12/2; // monospace char width
            int bY = bitmapY+16/2; // monospace char height
            if((bX>=0) && (bX<12) && (bY>=0) && (bY<16))
            { 
	            uchar4 sampledPixel=charBuf[bX + 12*bY + curChar*12*16];
                val=sampledPixel;
                break;    
            }
        }

        // render number of ships
        for(int j=0;j<64;j++)
        {
            int curChar = ns[j];
            float charX=488.0f+12*j; // center of char
            float charY=8.0f; // center of char
            float bitmapX= xf - charX;
            float bitmapY= yf - charY;

            int bX = bitmapX+12/2; // monospace char width
            int bY = bitmapY+16/2; // monospace char height
            if((bX>=0) && (bX<12) && (bY>=0) && (bY<16))
            { 
	            uchar4 sampledPixel=charBuf[bX + 12*bY + curChar*12*16];
                val=sampledPixel;
                break;    
            }
        }

        // render number of captains(with levels)
        for(int j=0;j<103;j++)
        {
            int curChar = tc[j];
            float charX=20.0f+12*j; // center of char
            float charY=24.0f; // center of char
            float bitmapX= xf - charX;
            float bitmapY= yf - charY;

            int bX = bitmapX+12/2; // monospace char width
            int bY = bitmapY+16/2; // monospace char height
            if((bX>=0) && (bX<12) && (bY>=0) && (bY<16))
            { 
	            uchar4 sampledPixel=charBuf[bX + 12*bY + curChar*12*16];
                val=sampledPixel;
                break;    
            }
        }

        // render score
        for(int j=0;j<17;j++)
        {
            int curChar = sc[j];
            float charX=20.0f+12*j; // center of char
            float charY=8.0f; // center of char
            float bitmapX= xf - charX;
            float bitmapY= yf - charY;

            int bX = bitmapX+12/2; // monospace char width
            int bY = bitmapY+16/2; // monospace char height
            if((bX>=0) && (bX<12) && (bY>=0) && (bY<16))
            { 
	            uchar4 sampledPixel=charBuf[bX + 12*bY + curChar*12*16];
                if(sampledPixel.z!=0)
                {
                    sampledPixel.x=255;sampledPixel.y=255;
                }
                val=sampledPixel;
                break;    
            }
        }
    }

	if(val.x < 15)
		val.x=0;

	if(val.y < 15)
		val.y=0;

	if(val.z < 15)
		val.z=0;
	buf[i]=	val;


}

// loads into graphics card(will be optimized later for iGPUs, with a true/false switch, using clArray.zeroCopy opion)
// with some future preprocessing with output as other buffers
__kernel void loadFloatIntParameters(__global float * floatParameter, __global int * intParameter, __global float * engineFrameTime)
{ 

}


__kernel void shipTargetClear(__global int * restrict shipTargetShip)
{ 
	int i=get_global_id(0); // ship id
	shipTargetShip[i]=-1; // no target id
}



// right-click event. parametersFloat --> click[7],x[3],y[4],scale[8], mapXTranslation[1], mapYTranslation[2]
// if rightclicked
// if selected
// add command to shipmovecommand (will be computed in ship state iterator kernel)
__kernel void rightClickCompute(__global float * restrict  shipTargetX, __global float * restrict  shipTargetY, 
								__global int * restrict  shipCommand, __global float * restrict  rightClickXY, 
								__global int * restrict  userCommand , __global int * restrict shipSelected,
								__global float * restrict  parametersFloat, __global int * restrict shipTargetShip,
								__global float * restrict shipX, __global float * restrict shipY)
{ 
	int i=get_global_id(0); // ship id

	// process ships, if there is a right click command or script command
	if(shipSelected[i]!=0)
	{ 
		// only selected(>0) ships or script controlled(<0) ships
		if((parametersFloat[7]>0) || shipSelected[i]<0)
		{ 

		    float scale=parametersFloat[0];
			float translateX=parametersFloat[1];
			float translateY=parametersFloat[2];
            float mousePosX=  parametersFloat[5];    
            float mousePosY=  parametersFloat[6];    

			float x0=((mousePosX)*scale + (translateX))-(RENDER_WIDTH/2)*scale;
			float y0=((mousePosY)*scale + (translateY))-(RENDER_HEIGHT/2)*scale;
			if(shipSelected[i]>0)
			{ 
				shipTargetX[i] =x0 ;
				shipTargetY[i] =y0 ;
			}
			if(shipTargetShip[i]>=0)
			{ 
				shipTargetX[i] =shipX[shipTargetShip[i]] ;
				shipTargetY[i] =shipY[shipTargetShip[i]];
			}
			shipCommand[i] = SHIP_COMMAND_MOVE;  // free to use weapons while moving
			mem_fence(CLK_GLOBAL_MEM_FENCE);
			if(shipSelected[i]>0)
				shipSelected[i]=0;
		}
	}
}




// only for living ships
// only if ship has command to rotate
// if not in tolerated angle range, rotate
// else end rotation command
// todo: make frame time dependent
__kernel void rotateShipByCommand(	__global float * restrict  shipTargetX,	__global float * restrict  shipTargetY,
									__global float * restrict  shipX,			__global float * restrict  shipY,
									__global int * restrict  shipCommand,		__global uchar * restrict  shipState,
									__global float * restrict  shipRotation, __global float * restrict frameTime)
{ 
	int i=get_global_id(0); // ship id
    int ftStep=(   (frameTime[2]>0.0f) ?  floor(frameTime[2]+0.1f)  :   0   );
    for(int ft=0;ft<ftStep;ft++)
    {
	    if((shipState[i]&PROJECTILE_DEAD)==0)
	    { 
		    if((shipCommand[i]&SHIP_COMMAND_MOVE)!=0)
		    { 

			    float dx= shipTargetX[i] - shipX[i];
			    float dy= shipTargetY[i] - shipY[i];
			
			    float radian_slope=atan2(dy,dx);
			
			    float commandRotation = radianToDegree(radian_slope);
			    float commandRotationMax = commandRotation+360.0f;
			    float commandRotationMin = commandRotation-360.0f;
			
			    float currentRotation = shipRotation[i] ;
			
			    mem_fence(CLK_GLOBAL_MEM_FENCE);
			    float a0=fabs(commandRotation - currentRotation);
			    float a1=fabs(commandRotationMax - currentRotation);
			    float a2=fabs(commandRotationMin - currentRotation);
			    if(a0<a1)
			    { 
				    if(a0<a2)
				    { 
					    currentRotation += sign(commandRotation - currentRotation);
				    }
				    else
				    { 
					    currentRotation += sign(commandRotationMin - currentRotation);
				    }
			    }
			    else
			    { 
				    if(a1<a2)
				    { 
					    currentRotation += sign(commandRotationMax - currentRotation);
				    }
				    else
				    { 
					    currentRotation += sign(commandRotationMin - currentRotation);
				    }
			    }

			    shipRotation[i] = currentRotation;
			    mem_fence(CLK_GLOBAL_MEM_FENCE);
		    }
	    }
    }
}







// render output (ships)
// for each pixel, search for its box and its neighbor boxes for ships to draw
// by -point in triangle- or -point int circle- algorithms
__kernel void renderShipsToTexture(__global uchar4 * restrict  buf, __global int * restrict box/*renderBox*/,
                                    __global float * restrict  shipX, __global float * restrict  shipY, 
                                    __global float * restrict  parametersFloat,__global int * restrict  parametersInt,
                                    __global uchar * restrict  shipTeam, __global float * restrict  shipRotation,
                                    __global float * restrict  shipFrontX, __global float * restrict  shipFrontY,
									__global unsigned char * restrict  shipStates, __global int * restrict  shipHp, 
									__global int * restrict  shieldDamaged, __global int * restrict  shipSelected,
									__global float * restrict  rightClickXY, __global int * restrict  userCommand,
									__global uchar * restrict shipSizeType,
									__global float * restrict  shipModuleX, __global float * restrict  shipModuleY,
									__global int * restrict shipModuleShieldDamaged, 
									__global uchar * restrict shipModuleState, __global uchar * restrict shipModuleType,
									__global uchar4 * restrict shipPixels, __global float * restrict bufLightR,
									__global uchar * restrict pixelUsed,__global float * restrict bufLightG,
									__global float * restrict bufLightB, __global uchar4 * restrict captainRankPixels,
									__global uchar * restrict crewData, __global uchar * restrict crewLevel)
{
    int i=get_global_id(0); // pixel id

	{ 
		// blocked computing with 16x16 patches of pixels
		int patchId = i/SHIP_RENDER_PATCH_SIZE;

		// pixel's coordinates in its patch
		short localX = i%SHIP_RENDER_PATCH_SIZE_SQRT;
		short localY = (i/SHIP_RENDER_PATCH_SIZE_SQRT)%SHIP_RENDER_PATCH_SIZE_SQRT;

		// first element of each patch will have this X and Y offsets
		int patchX = (patchId % (RENDER_WIDTH/SHIP_RENDER_PATCH_SIZE_SQRT)) * SHIP_RENDER_PATCH_SIZE_SQRT;
		int patchY = (patchId / (RENDER_WIDTH/SHIP_RENDER_PATCH_SIZE_SQRT)) * SHIP_RENDER_PATCH_SIZE_SQRT;

		int blockX=patchX + localX;
		int blockY=patchY + localY;

		i=blockX + blockY * RENDER_WIDTH;
	}
	if(pixelUsed[i]!=0) 
		return;

    //int maxShipsPerBox=@@maxShipsPerBox@@;

    float scale=parametersFloat[0];
    float translateX=parametersFloat[1];
    float translateY=parametersFloat[2];
                                        
    int x0=((i%RENDER_WIDTH)*scale + (translateX))-(RENDER_WIDTH/2)*scale;
    int y0=((i/RENDER_WIDTH)*scale + (translateY))-(RENDER_HEIGHT/2)*scale;
    float xf=x0;
    float yf=y0;
    int found=0;
    int foundShipId=-1;

    int boxX= x0/SHIP_SEARCH_BOX_SIZE;
    int boxY= y0/SHIP_SEARCH_BOX_SIZE;
    int boxId=boxX + boxY*(MAP_WIDTH/SHIP_SEARCH_BOX_SIZE);
	float shieldDamagedAnimation=0.0f;
	//float shieldDamagedAnimationModule=0.0f;

	char8 registers=0;
	
	registers.s0=0;

	uchar4 foundShipColor=(uchar4)(255,255,255,255);

    for(registers.s1=-1;registers.s1<=1;registers.s1++)
    {
        int wi=registers.s1*(MAP_WIDTH/SHIP_SEARCH_BOX_SIZE);
        for(registers.s4=-1;registers.s4<=1;registers.s4++)
        {

            int boxIdCurrent=boxId+registers.s4+wi;
            if((boxIdCurrent<2) || (boxIdCurrent>=@@((mapHeight/searchBoxSize)*(mapWidth/searchBoxSize))@@-2))
                continue;
            registers.s5=box[boxIdCurrent];
           
            for(registers.s6=0;registers.s6<registers.s5;registers.s6++)
            {
                        
                int selectedShipId=box[boxIdCurrent+(registers.s6+1)*N_SHIP_BOX_LAYER];

                // check if (xf,yf) is in ship hull
                if( (selectedShipId>=0) && (selectedShipId<@@nShip@@))
                {

					float explosionExtraRadius=(((shipStates[selectedShipId]&PROJECTILE_EXPLOSION)==0)?0:(shipHp[selectedShipId]-20.0f));

                    float dx=xf-shipX[selectedShipId];
                    float dy=yf-shipY[selectedShipId];
					float shipSize = SHIP_SIZE + (shipSizeType[selectedShipId]*SHIP_SIZE);

					int selectedShieldGeneratorId=0;
					float additionalShieldRadius=0.0f;
					for(int im=0;im<MAX_MODULES_PER_SHIP;im++)
					{ 
						registers.s7=0;
						int tmpId=selectedShipId + im*N_SHIP_MAX;
						uchar smt = shipModuleType[tmpId];
						uchar sms = shipModuleState[tmpId];
						// if module is shield generator
						if(smt==SHIP_MODULE_TYPE_SHIELD_GENERATOR)
						{ 
							// only if it is working
							if((sms&SHIP_MODULE_STATE_WORKING)!=0)
							{ 
								shieldDamagedAnimation=shipModuleShieldDamaged[tmpId]/4;
								selectedShieldGeneratorId=tmpId;
								additionalShieldRadius=SHIP_MODULE_SHIELD_GENERATOR_SHIELD_RADIUS+SHIP_SHIELD_DISTANCE;
							}
						}
						// if module is shield generator
						else if(smt==SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE)
						{ 
							// only if it is working
							if((sms&SHIP_MODULE_STATE_WORKING)!=0)
							{ 
								shieldDamagedAnimation=shipModuleShieldDamaged[tmpId]/4;
								selectedShieldGeneratorId=tmpId;
								additionalShieldRadius=SHIP_MODULE_SHIELD_GENERATOR_FRIGATE_SHIELD_RADIUS+SHIP_SHIELD_DISTANCE;
							}
						}
						// if module is shield generator
						else if(smt==SHIP_MODULE_TYPE_SHIELD_GENERATOR_DESTROYER)
						{ 
							// only if it is working
							if((sms&SHIP_MODULE_STATE_WORKING)!=0)
							{ 
								shieldDamagedAnimation=shipModuleShieldDamaged[tmpId]/4;
								selectedShieldGeneratorId=tmpId;
								additionalShieldRadius=SHIP_MODULE_SHIELD_GENERATOR_DESTROYER_SHIELD_RADIUS+SHIP_SHIELD_DISTANCE;
							}
						}
						// if module is shield generator
						else if(smt==SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER)
						{ 
							// only if it is working
							if((sms&SHIP_MODULE_STATE_WORKING)!=0)
							{ 
								shieldDamagedAnimation=shipModuleShieldDamaged[tmpId]/4;
								selectedShieldGeneratorId=tmpId;
								additionalShieldRadius=SHIP_MODULE_SHIELD_GENERATOR_CRUISER_SHIELD_RADIUS+SHIP_SHIELD_DISTANCE;
							}
						}

						if(shieldDamagedAnimation>0)
						{
							float dxModule=xf-shipModuleX[selectedShieldGeneratorId];
							float dyModule=yf-shipModuleY[selectedShieldGeneratorId];
							if((dxModule*dxModule + dyModule*dyModule)<
							((additionalShieldRadius)*
							(additionalShieldRadius)))
							{
								if((dxModule*dxModule + dyModule*dyModule)>
								((additionalShieldRadius-shieldDamagedAnimation)*
								 (additionalShieldRadius-shieldDamagedAnimation)))
								{ 
									found=1;
									if(foundShipId<selectedShipId)
									{ 
										foundShipId=selectedShipId; 
										registers.s0=1;
									}
									registers.s7=1;
								}
							}
						}
						if(registers.s7)
							break;
					}	

					

					// if pixel is in ship bounding area
                    if((dx*dx + dy*dy)<((shipSize+explosionExtraRadius+20.0f)*(shipSize+explosionExtraRadius+20.0f)))
                    {

						// if ship is exploding
						if((shipStates[selectedShipId]&PROJECTILE_EXPLOSION)!=0)
						{ 
							found=1;
							if(foundShipId<selectedShipId)
								foundShipId=selectedShipId; 
							continue;
						}

						// if there is a ship pixel(hull) in this pixel thread position
						uchar2 sst = (uchar2)(shipSizeType[selectedShipId],shipTeam[selectedShipId]);
						int shipSquareBitmapWidth = shipSizes[sst.s0];

						float bitmapX= xf - shipX[selectedShipId];
						float bitmapY= yf - shipY[selectedShipId];
						float sr = degreeToRadian(270.0f-shipRotation[selectedShipId]);
						float cosSr=cos(sr);
						float sinSr=sin(sr);
						float bX2 = bitmapX * cosSr - bitmapY * sinSr;
						float bY2 = bitmapX * sinSr + bitmapY * cosSr;
						int bX = bX2+shipSquareBitmapWidth/2;
						int bY = bY2+shipSquareBitmapWidth/2;
						if((bX>=0) && (bX<shipSquareBitmapWidth) && (bY>=0) && (bY<shipSquareBitmapWidth))
						{ 
							uchar4 sampledPixel=shipPixels[bX + shipSquareBitmapWidth*bY + offsets0[sst.s0]+offsets1[sst.s1]];
							if(sampledPixel.s3!=0)
							{ 
								foundShipColor=sampledPixel;
								if(parametersInt[13]!=0)
								{ 
									int capId=findFirstCaptain(crewData,selectedShipId);
									if(capId>=0)
									{ 
										int lvl=crewLevel[capId];
										if(lvl>10)
											lvl=10;
										if((bitmapX*bitmapX <= 100) && (bitmapY*bitmapY <=100))
										{ 
											// captain rank indicator pixels
											bX = bitmapX+5;
											bY = bitmapY+5;
											if((bX>=0) && (bX<10) && (bY>=0) && (bY<10))
											{ 
												uchar4 sampledRankPixel=captainRankPixels[bX + bY*10 + (10*10*(lvl-1))];
												if(sampledRankPixel.s3!=0)
													foundShipColor=sampledRankPixel;
											}
										}
									}
								}
								found=1;
								if(foundShipId<selectedShipId)
									foundShipId=selectedShipId; 
								continue;
							}
						}
                    }

                }
            }
        }
    }

    if(found>0)
    {
		
		if((shipStates[foundShipId]&PROJECTILE_EXPLOSION)!=0)
		{ 
			int index=i;
			//uchar st=shipTeam[foundShipId];
			uchar red=255;
			uchar green=255;
			uchar blue=255;
			uchar alpha=255;
			buf[index]=(uchar4)(blue,green,red,alpha);		
		}
		else
		{ 
			// shield is damaged
			if(registers.s0>0)
			{
				int index=i;
				uchar red=15;
				uchar green=75;
				uchar blue=200;
				uchar alpha=255;
				buf[index]=(uchar4)(blue,green,red,alpha);		 
			}
			else
			{

				float mapWidth=@@mapWidth@@;
				float mapHeight=@@mapHeight@@;
				int tx=parametersFloat[5];
				int ty=parametersFloat[6];
				int dxR=(i%RENDER_WIDTH) - tx;
				int dyR=(i/RENDER_WIDTH) - ty;

				if( dxR * dxR + dyR * dyR < (1024.0f / scale) * (1024.0f / scale))
				{ 
					if((x0>0) && (y0>0) && (x0<mapWidth) && (y0<mapHeight))
					{ 
						if((parametersInt[0]>0) && (parametersInt[11]==shipTeam[foundShipId]))
						{ 
							atomic_add(&shipSelected[foundShipId],1); // select ship found by pixel
						}
					}
				}
				mem_fence(CLK_GLOBAL_MEM_FENCE);


				int index=i;
				if(shipSelected[foundShipId]<=0)
				{ 
					float enlightmentR=(1.0f + bufLightR[i]*3.0f);
					float enlightmentG=(1.0f + bufLightG[i]*3.0f);
					float enlightmentB=(1.0f + bufLightB[i]*3.0f);
					uchar st=shipTeam[foundShipId];
					uchar red= clamp( foundShipColor.s2 * enlightmentR, 0.0f, 255.0f);
					uchar green= clamp(foundShipColor.s1 * enlightmentG,0.0f,255.0f);
					uchar blue= clamp(foundShipColor.s0 * enlightmentB,0.0f,255.0f);
					uchar alpha=255;



					// draw ship modules
					
					if(parametersInt[12]!=0)
					{ 
						for(char im=0;im<10;im++)
						{ 
							float dx = xf - shipModuleX[foundShipId + N_SHIP_MAX * im];
							float dy = yf - shipModuleY[foundShipId + N_SHIP_MAX * im];
							float sMSize = 1.0f + (1.0f)*shipSizeType[foundShipId];
							if(dx*dx+dy*dy < (sMSize*sMSize))
							{ 
							
								if(st==0)
								{ 	red=255; blue=0; green=0;}
								else if(st==1)
								{ green=255; red=0; blue=0;}
								else if(st==2)
								{ 	blue=255; red=0;green=0;}
								
								break;
							}
						}
					}

					buf[index]=(uchar4)(blue*0.8f,green*0.8f,red*0.8f,alpha);

				}
				else
				{ 
					// ship is selected
					//uchar st=shipTeam[foundShipId];
					uchar red=25;
					uchar green=240;
					uchar blue=180;
					uchar alpha=255;
					buf[index]=(uchar4)(blue,green,red,alpha);				
				}
			}
		}
    }
	else
	{ 
		// nothing to draw. check if there is mouse pointer lines
		
		short v1=(x0%512);
		short v2=(y0%512);

		float mapWidth=@@mapWidth@@;
		float mapHeight=@@mapHeight@@;
		int tx=parametersFloat[5];
		int ty=parametersFloat[6];
		int dxR=(i%RENDER_WIDTH) - tx;
		int dyR=(i/RENDER_WIDTH) - ty;

		if( dxR * dxR + dyR * dyR < (1024.0f / scale) * (1024.0f / scale))
		{ 
			if((x0>0) && (y0>0) && (x0<mapWidth) && (y0<mapHeight))
			{ 
			
				if(parametersInt[0]==0)
				{ 
					int lim=2*scale;
					if((v1>(512-lim)) || (v1<lim) || (v2>(512-lim)) || (v2<lim) )
					{ 
						uchar red=255;
						uchar green=255;
						uchar blue=0;
						uchar alpha=255;
						buf[i]=(uchar4)(blue,green,red,alpha);
						return;
					}
				}

				// if mouse right-clicked, fill area with this color
				if(parametersFloat[7]>0.5f)
				{ 
						uchar red=77;
						uchar green=77;
						uchar blue=0;
						uchar alpha=255;
						buf[i]=(uchar4)(blue,green,red,alpha);
						return;
				}

			}
		}

	}


}

// reset ship counters
__kernel void resetShipCounter(	__global int * ctr0Ping,__global int * ctr1Ping,__global int * ctr2Ping,
								__global int * ctr0Pong,__global int * ctr1Pong,__global int * ctr2Pong)
{ 
	int i=get_global_id(0);// counter id

	ctr0Ping[i]=0;
	ctr1Ping[i]=0;
	ctr2Ping[i]=0;

	ctr0Pong[i]=0;
	ctr1Pong[i]=0;
	ctr2Pong[i]=0;
}



// count intact ships accordingly with their states and teams 0,1,2
// if they are inside map borders
__kernel void countShips(__global unsigned char * teams, __global unsigned char * states,
			 __global int * ctr0Ping, __global int * ctr1Ping, __global int * ctr2Ping,
			 __global int * ctr0Pong, __global int * ctr1Pong, __global int * ctr2Pong,
			 __global float * shipX, __global float * shipY)
{ 
	int i=get_global_id(0); // count id (2 ships per count), size=total ships/s
	int nShips=@@nShip@@/2;
	unsigned char team=teams[i];
	unsigned char team2=teams[i+nShips];
	unsigned char state=states[i];
	unsigned char state2=states[i+nShips];
	int ctr0=0;
	int ctr1=0;
	int ctr2=0;
	
	if(team==0)
	{ 
		ctr0+=(((state&PROJECTILE_DEAD)==0)?1:0) * ((shipX[i]>20.0f) && (shipY[i]>20.0f) && (shipX[i]<((float)MAP_WIDTH-20.0f)) && (shipX[i]<((float)MAP_HEIGHT-20.0f)));
	}
	else if(team==1)
	{
		ctr1+=(((state&PROJECTILE_DEAD)==0)?1:0)* ((shipX[i]>20.0f) && (shipY[i]>20.0f) && (shipX[i]<((float)MAP_WIDTH-20.0f)) && (shipX[i]<((float)MAP_HEIGHT-20.0f)));
	}
	else if(team==2)
	{
		ctr2+=(((state&PROJECTILE_DEAD)==0)?1:0)* ((shipX[i]>20.0f) && (shipY[i]>20.0f) && (shipX[i]<((float)MAP_WIDTH-20.0f)) && (shipX[i]<((float)MAP_HEIGHT-20.0f)));
	}

	if(team2==0)
	{ 
		ctr0+=(((state2&PROJECTILE_DEAD)==0)?1:0)* ((shipX[i+nShips]>20.0f) && (shipY[i+nShips]>20.0f) && (shipX[i+nShips]<((float)MAP_WIDTH-20.0f)) && (shipX[i+nShips]<((float)MAP_HEIGHT-20.0f)));
	}
	else if(team2==1)
	{
		ctr1+=(((state2&PROJECTILE_DEAD)==0)?1:0)* ((shipX[i+nShips]>20.0f) && (shipY[i+nShips]>20.0f) && (shipX[i+nShips]<((float)MAP_WIDTH-20.0f)) && (shipX[i+nShips]<((float)MAP_HEIGHT-20.0f)));
	}
	else if(team2==2)
	{
		ctr2+=(((state2&PROJECTILE_DEAD)==0)?1:0)* ((shipX[i+nShips]>20.0f) && (shipY[i+nShips]>20.0f) && (shipX[i+nShips]<((float)MAP_WIDTH-20.0f)) && (shipX[i+nShips]<((float)MAP_HEIGHT-20.0f)));
	}

	

	ctr0Ping[i]+=ctr0;
	ctr1Ping[i]+=ctr1;
	ctr2Ping[i]+=ctr2;
}

// reduction step reset
__kernel void countStepReset(__global int * reductionStep)
{ 
	int i=get_global_id(0);
	if(i==0)
	{ 
		reductionStep[0]=4;
	}
}

// reduction step increment
__kernel void countStepIncrement(__global int * reductionStep)
{ 
	int i=get_global_id(0);
	if(i==0)
	{ 
		reductionStep[0]*=2;
	}
}


// reduction for number of ships
__kernel void countShipsPing(	__global int * ctr0Ping, __global int * ctr1Ping, __global int * ctr2Ping,
								__global int * ctr0Pong, __global int * ctr1Pong, __global int * ctr2Pong,
								__global int * reductionStep)
{ 
	int i=get_global_id(0); 
	int nShips=@@nShip@@/reductionStep[0];
	ctr0Pong[i]=(ctr0Ping[i]+ctr0Ping[i+nShips]);
	ctr1Pong[i]=(ctr1Ping[i]+ctr1Ping[i+nShips]);
	ctr2Pong[i]=(ctr2Ping[i]+ctr2Ping[i+nShips]);
	
	ctr0Ping[i]=0;
	ctr0Ping[i+nShips]=0;
	ctr1Ping[i]=0;
	ctr1Ping[i+nShips]=0;
	ctr2Ping[i]=0;
	ctr2Ping[i+nShips]=0;
	
}

// reduction for number of ships
__kernel void countShipsPong(	__global int * ctr0Ping, __global int * ctr1Ping, __global int * ctr2Ping,
								__global int * ctr0Pong, __global int * ctr1Pong, __global int * ctr2Pong,
								__global int * reductionStep)
{ 
	int i=get_global_id(0); 
	int nShips=@@nShip@@/reductionStep[0];
	ctr0Ping[i]=(ctr0Pong[i]+ctr0Pong[i+nShips]);
	ctr1Ping[i]=(ctr1Pong[i]+ctr1Pong[i+nShips]);
	ctr2Ping[i]=(ctr2Pong[i]+ctr2Pong[i+nShips]);
	
	ctr0Pong[i]=0;
	ctr0Pong[i+nShips]=0;
	ctr1Pong[i]=0;
	ctr1Pong[i+nShips]=0;
	ctr2Pong[i]=0;
	ctr2Pong[i+nShips]=0;
	
}

// pass number of ships for output array
__kernel void copyNumberOfShips(__global int * ctr0Ping, __global int * ctr1Ping, __global int * ctr2Ping,
								__global int * ctr0Pong, __global int * ctr1Pong, __global int * ctr2Pong,
								__global int * numberOfShips)
{ 
	int i=get_global_id(0);
	if(i==0)
	{ 
		numberOfShips[0]=ctr0Ping[0]+ctr0Pong[0]; // team 0 ships
		numberOfShips[1]=ctr1Ping[0]+ctr1Pong[0]; // team 1 ships
		numberOfShips[2]=ctr2Ping[0]+ctr2Pong[0]; // team 2 ships
	}
}

// crew levelups at:
// 5 15 30 50 75 105 140 180 225 275 330 ...
int computeCrewLevel(int experience)
{ 
	int tmp=0;
	int ctr=0;
	while(tmp<experience)
	{ 
		tmp+=ctr*5;
		ctr++;
	}
	return ctr-1;
}

// levelup crews with new skills
// do regenerations
// apply state transitions (mission, boarding, escaping, ..)
__kernel void computeCrewLogic(	__global uchar * crewLevel, __global int * crewExperience,
								__global uint * randBuf, __global uchar * crewEvasionSkillLevel,
								__global uchar * crewTacticalCriticalHitSkillLevel,
								__global uchar * crewFastLearningSkillLevel)
{ 
	int i=get_global_id(0); // crew id
	while(computeCrewLevel(crewExperience[i])>crewLevel[i])
	{ 	
		mem_fence(CLK_GLOBAL_MEM_FENCE);
		crewLevel[i]++;
		mem_fence(CLK_GLOBAL_MEM_FENCE);
		int newCaptainSkill = d4(randBuf,i);
		mem_fence(CLK_GLOBAL_MEM_FENCE);
		if(newCaptainSkill == 1)
		{ 
			crewEvasionSkillLevel[i]++;
		}
		else if(newCaptainSkill==2)
		{ 
			// criticals hits work only on hull. 
			crewTacticalCriticalHitSkillLevel[i]++;
		}
		else if(newCaptainSkill==3)
		{ 
			crewFastLearningSkillLevel[i]++;
		}
		mem_fence(CLK_GLOBAL_MEM_FENCE);
	}
}





// default ship customization
// move shield, maxshield to here, make independent of initShip kernel
__kernel void initShipModule(__global uchar * shipModuleType, __global int * shipModuleEnergy,
							 __global uchar * shipModuleHP, __global uchar * shipModuleHPMax,
							 __global uint * randBuf,__global int * shipModuleEnergyMax,
							 __global int * shipModuleWeight, __global uchar * shipModuleState,
							 __global int * shipShieldMax, __global int * shipShield,
							 __global uchar * shipTeam, __global int * parametersInt,
							 __global uchar * shipSizeType)
{ 
	int i=get_global_id(0); // ship id
	// 10 modules per ship
	// 0: front, 1:left front, 2: right front, .... 9: right back
	
	// p11 = team, p1-10 = customized modules bitfields
	if(shipTeam[i]!=parametersInt[11])
	{ 
		if(shipSizeType[i]==SHIP_SIZE_TYPE_CORVETTE)
		{ 
			shipModuleType[i+N_SHIP_MAX*0]=SHIP_MODULE_TYPE_CANNON_TURRET;
			shipModuleType[i+N_SHIP_MAX*1]=SHIP_MODULE_TYPE_CANNON_TURRET_TURBO;
			shipModuleType[i+N_SHIP_MAX*2]=SHIP_MODULE_TYPE_CANNON_TURRET_TURBO;
			shipModuleType[i+N_SHIP_MAX*3]=SHIP_MODULE_TYPE_CANNON_TURRET_TURBO;
			shipModuleType[i+N_SHIP_MAX*4]=SHIP_MODULE_TYPE_POWER_SOURCE;
			shipModuleType[i+N_SHIP_MAX*5]=SHIP_MODULE_TYPE_POWER_SOURCE;
			shipModuleType[i+N_SHIP_MAX*6]=SHIP_MODULE_TYPE_POWER_SOURCE;
			shipModuleType[i+N_SHIP_MAX*7]=SHIP_MODULE_TYPE_SHIELD_GENERATOR;
			shipModuleType[i+N_SHIP_MAX*8]=SHIP_MODULE_TYPE_SHIELD_GENERATOR;
			shipModuleType[i+N_SHIP_MAX*9]=SHIP_MODULE_TYPE_ENERGY_CAPACITOR;


		}
		else if(shipSizeType[i]==SHIP_SIZE_TYPE_FRIGATE)
		{ 
			shipModuleType[i+N_SHIP_MAX*0]=SHIP_MODULE_TYPE_CANNON_TURRET_FRIGATE;
			shipModuleType[i+N_SHIP_MAX*1]=SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE;
			shipModuleType[i+N_SHIP_MAX*2]=SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE;
			shipModuleType[i+N_SHIP_MAX*3]=SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE;
			shipModuleType[i+N_SHIP_MAX*4]=SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE;
			shipModuleType[i+N_SHIP_MAX*5]=SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE;
			shipModuleType[i+N_SHIP_MAX*6]=SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE;
			shipModuleType[i+N_SHIP_MAX*7]=SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE;
			shipModuleType[i+N_SHIP_MAX*8]=SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE;
			shipModuleType[i+N_SHIP_MAX*9]=SHIP_MODULE_TYPE_ENERGY_CAPACITOR_FRIGATE;

		}
		else if(shipSizeType[i]==SHIP_SIZE_TYPE_DESTROYER)
		{ 
			shipModuleType[i+N_SHIP_MAX*0]=SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER;
			shipModuleType[i+N_SHIP_MAX*1]=SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER;
			shipModuleType[i+N_SHIP_MAX*2]=SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER;
			shipModuleType[i+N_SHIP_MAX*3]=SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER;
			shipModuleType[i+N_SHIP_MAX*4]=SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER;
			shipModuleType[i+N_SHIP_MAX*5]=SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER;
			shipModuleType[i+N_SHIP_MAX*6]=SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER;
			shipModuleType[i+N_SHIP_MAX*7]=SHIP_MODULE_TYPE_SHIELD_GENERATOR_DESTROYER;
			shipModuleType[i+N_SHIP_MAX*8]=SHIP_MODULE_TYPE_SHIELD_GENERATOR_DESTROYER;
			shipModuleType[i+N_SHIP_MAX*9]=SHIP_MODULE_TYPE_ENERGY_CAPACITOR_DESTROYER;

		}
		else if(shipSizeType[i]==SHIP_SIZE_TYPE_CRUISER)
		{ 
			shipModuleType[i+N_SHIP_MAX*0]=SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER;
			shipModuleType[i+N_SHIP_MAX*1]=SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_CRUISER;
			shipModuleType[i+N_SHIP_MAX*2]=SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_CRUISER;
			shipModuleType[i+N_SHIP_MAX*3]=SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_CRUISER;
			shipModuleType[i+N_SHIP_MAX*4]=SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER;
			shipModuleType[i+N_SHIP_MAX*5]=SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER;
			shipModuleType[i+N_SHIP_MAX*6]=SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER;
			shipModuleType[i+N_SHIP_MAX*7]=SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER;
			shipModuleType[i+N_SHIP_MAX*8]=SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER;
			shipModuleType[i+N_SHIP_MAX*9]=SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER;
		}
			shipModuleState[i+N_SHIP_MAX*0]=SHIP_MODULE_STATE_WORKING;
			shipModuleState[i+N_SHIP_MAX*1]=SHIP_MODULE_STATE_WORKING;
			shipModuleState[i+N_SHIP_MAX*2]=SHIP_MODULE_STATE_WORKING;
			shipModuleState[i+N_SHIP_MAX*3]=SHIP_MODULE_STATE_WORKING;
			shipModuleState[i+N_SHIP_MAX*4]=SHIP_MODULE_STATE_WORKING;
			shipModuleState[i+N_SHIP_MAX*5]=SHIP_MODULE_STATE_WORKING;
			shipModuleState[i+N_SHIP_MAX*6]=SHIP_MODULE_STATE_WORKING;
			shipModuleState[i+N_SHIP_MAX*7]=SHIP_MODULE_STATE_WORKING;
			shipModuleState[i+N_SHIP_MAX*8]=SHIP_MODULE_STATE_WORKING;
			shipModuleState[i+N_SHIP_MAX*9]=SHIP_MODULE_STATE_WORKING;
	}
	else
	{
		if(shipSizeType[i]==SHIP_SIZE_TYPE_CORVETTE)
		{ 
			shipModuleType[i+N_SHIP_MAX*0]=parametersInt[1];
			shipModuleType[i+N_SHIP_MAX*1]=parametersInt[2];
			shipModuleType[i+N_SHIP_MAX*2]=parametersInt[3];
			shipModuleType[i+N_SHIP_MAX*3]=parametersInt[4];
			shipModuleType[i+N_SHIP_MAX*4]=parametersInt[5];
			shipModuleType[i+N_SHIP_MAX*5]=parametersInt[6];
			shipModuleType[i+N_SHIP_MAX*6]=parametersInt[7];
			shipModuleType[i+N_SHIP_MAX*7]=parametersInt[8];
			shipModuleType[i+N_SHIP_MAX*8]=parametersInt[9];
			shipModuleType[i+N_SHIP_MAX*9]=parametersInt[10];
		}
		else if(shipSizeType[i]==SHIP_SIZE_TYPE_FRIGATE)
		{ 
			shipModuleType[i+N_SHIP_MAX*0]=16 + parametersInt[1];
			shipModuleType[i+N_SHIP_MAX*1]=16 + parametersInt[2];
			shipModuleType[i+N_SHIP_MAX*2]=16 + parametersInt[3];
			shipModuleType[i+N_SHIP_MAX*3]=16 + parametersInt[4];
			shipModuleType[i+N_SHIP_MAX*4]=16 + parametersInt[5];
			shipModuleType[i+N_SHIP_MAX*5]=16 + parametersInt[6];
			shipModuleType[i+N_SHIP_MAX*6]=16 + parametersInt[7];
			shipModuleType[i+N_SHIP_MAX*7]=16 + parametersInt[8];
			shipModuleType[i+N_SHIP_MAX*8]=16 + parametersInt[9];
			shipModuleType[i+N_SHIP_MAX*9]=16 + parametersInt[10];
		}
		else if(shipSizeType[i]==SHIP_SIZE_TYPE_DESTROYER)
		{ 
			shipModuleType[i+N_SHIP_MAX*0]=32 + parametersInt[1];
			shipModuleType[i+N_SHIP_MAX*1]=32 + parametersInt[2];
			shipModuleType[i+N_SHIP_MAX*2]=32 + parametersInt[3];
			shipModuleType[i+N_SHIP_MAX*3]=32 + parametersInt[4];
			shipModuleType[i+N_SHIP_MAX*4]=32 + parametersInt[5];
			shipModuleType[i+N_SHIP_MAX*5]=32 + parametersInt[6];
			shipModuleType[i+N_SHIP_MAX*6]=32 + parametersInt[7];
			shipModuleType[i+N_SHIP_MAX*7]=32 + parametersInt[8];
			shipModuleType[i+N_SHIP_MAX*8]=32 + parametersInt[9];
			shipModuleType[i+N_SHIP_MAX*9]=32 + parametersInt[10];
		}
		else if(shipSizeType[i]==SHIP_SIZE_TYPE_CRUISER)
		{ 
			shipModuleType[i+N_SHIP_MAX*0]=48 + parametersInt[1];
			shipModuleType[i+N_SHIP_MAX*1]=48 + parametersInt[2];
			shipModuleType[i+N_SHIP_MAX*2]=48 + parametersInt[3];
			shipModuleType[i+N_SHIP_MAX*3]=48 + parametersInt[4];
			shipModuleType[i+N_SHIP_MAX*4]=48 + parametersInt[5];
			shipModuleType[i+N_SHIP_MAX*5]=48 + parametersInt[6];
			shipModuleType[i+N_SHIP_MAX*6]=48 + parametersInt[7];
			shipModuleType[i+N_SHIP_MAX*7]=48 + parametersInt[8];
			shipModuleType[i+N_SHIP_MAX*8]=48 + parametersInt[9];
			shipModuleType[i+N_SHIP_MAX*9]=48 + parametersInt[10];
		}
		shipModuleState[i+N_SHIP_MAX*0]=SHIP_MODULE_STATE_WORKING;
		shipModuleState[i+N_SHIP_MAX*1]=SHIP_MODULE_STATE_WORKING;
		shipModuleState[i+N_SHIP_MAX*2]=SHIP_MODULE_STATE_WORKING;
		shipModuleState[i+N_SHIP_MAX*3]=SHIP_MODULE_STATE_WORKING;
		shipModuleState[i+N_SHIP_MAX*4]=SHIP_MODULE_STATE_WORKING;
		shipModuleState[i+N_SHIP_MAX*5]=SHIP_MODULE_STATE_WORKING;
		shipModuleState[i+N_SHIP_MAX*6]=SHIP_MODULE_STATE_WORKING;
		shipModuleState[i+N_SHIP_MAX*7]=SHIP_MODULE_STATE_WORKING;
		shipModuleState[i+N_SHIP_MAX*8]=SHIP_MODULE_STATE_WORKING;
		shipModuleState[i+N_SHIP_MAX*9]=SHIP_MODULE_STATE_WORKING;
	}
	mem_fence(CLK_GLOBAL_MEM_FENCE);

	for(int j=0;j<MAX_MODULES_PER_SHIP;j++)
	{ 
		if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET)
		{
		 	shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY; 
		 	shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY; 
		 	int hp=d8(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=5; // 50 ton 
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_FRIGATE)
		{
		 	shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY_FRIGATE; 
		 	shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY_FRIGATE; 
		 	int hp=3+d12(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=12; // 120 ton 
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER)
		{
		 	shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY_DESTROYER; 
		 	shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY_DESTROYER; 
		 	int hp=5+d20(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=30; // 300 ton 
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER)
		{
		 	shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY_CRUISER; 
		 	shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_ENERGY_CRUISER; 
		 	int hp=15+d20(randBuf,i)+d20(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=100; // 1000 ton 
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO)
		{
		 	shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY; 
		 	shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY; 
		 	int hp=d8(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=5; // 50 ton 
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE)
		{
		 	shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_FRIGATE; 
		 	shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_FRIGATE; 
		 	int hp=3+d12(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=12; // 120 ton 
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER)
		{
		 	shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_DESTROYER; 
		 	shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_DESTROYER; 
		 	int hp=5+d20(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=30; // 300 ton 
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_CRUISER)
		{
		 	shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_CRUISER; 
		 	shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_CRUISER; 
		 	int hp=15+d20(randBuf,i)+d20(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=100; // 1000 ton 
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_POWER_SOURCE)
		{ 	
			shipModuleEnergy[i + N_SHIP_MAX*j]=1;
			shipModuleEnergyMax[i + N_SHIP_MAX*j]=1;
		 	int hp=d4(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=8;  
		} 
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE)
		{ 	
			shipModuleEnergy[i + N_SHIP_MAX*j]=5;
			shipModuleEnergyMax[i + N_SHIP_MAX*j]=5;
		 	int hp=5+d6(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=20;  
		} 
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER)
		{ 	
			shipModuleEnergy[i + N_SHIP_MAX*j]=20;
			shipModuleEnergyMax[i + N_SHIP_MAX*j]=20;
		 	int hp=15+d20(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=50;  
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER)
		{ 	
			shipModuleEnergy[i + N_SHIP_MAX*j]=100;
			shipModuleEnergyMax[i + N_SHIP_MAX*j]=100;
		 	int hp=25+d20(randBuf,i)+d20(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=150;  
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_SHIELD_GENERATOR)
		{ 	
			shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY;
			shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY; 
		 	int hp=d4(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=50;  
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE)
		{ 	
			shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_FRIGATE;
			shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_FRIGATE; 
		 	int hp=2+d4(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=90;  
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_DESTROYER)
		{ 	
			shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_DESTROYER;
			shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_DESTROYER; 
		 	int hp=5+d10(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=290;  
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER)
		{ 	
			shipModuleEnergy[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_CRUISER;
			shipModuleEnergyMax[i + N_SHIP_MAX*j]=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_CRUISER; 
		 	int hp=15+d10(randBuf,i)+d10(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=290;  
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR)
		{ 	
			shipModuleEnergy[i + N_SHIP_MAX*j]=100;
			shipModuleEnergyMax[i + N_SHIP_MAX*j]=100;
		 	int hp=d6(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=10;  
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR_FRIGATE)
		{ 	
			shipModuleEnergy[i + N_SHIP_MAX*j]=250;
			shipModuleEnergyMax[i + N_SHIP_MAX*j]=250;
		 	int hp=5+d6(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=30;  
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR_DESTROYER)
		{ 	
			shipModuleEnergy[i + N_SHIP_MAX*j]=700;
			shipModuleEnergyMax[i + N_SHIP_MAX*j]=700;
		 	int hp=15+d20(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=100;  
		}
		else if(shipModuleType[i+N_SHIP_MAX*j]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER)
		{ 	
			shipModuleEnergy[i + N_SHIP_MAX*j]=2000;
			shipModuleEnergyMax[i + N_SHIP_MAX*j]=2000;
		 	int hp=25+d20(randBuf,i)+d20(randBuf,i);
			shipModuleHP[i + N_SHIP_MAX*j]=hp; 
			shipModuleHPMax[i + N_SHIP_MAX*j]=hp; 
			shipModuleWeight[i + N_SHIP_MAX*j]=300;  
		}
	}

	mem_fence(CLK_GLOBAL_MEM_FENCE);

	int tmpShield = 0;
	for(int im=0;im<MAX_MODULES_PER_SHIP;im++)
	{ 
		// get number of shield generators
		if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR)
		{ 
			if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
			{ 
				tmpShield+=16;
			}
		}
		else
		if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE)
		{ 
			if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
			{ 
				tmpShield+=32;
			}
		}
		else
		if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_DESTROYER)
		{ 
			if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
			{ 
				tmpShield+=48;
			}
		}
		else
		if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER)
		{ 
			if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
			{ 
				tmpShield+=64;
			}
		}
	}

	shipShield[i]=tmpShield;
	shipShieldMax[i]=tmpShield;
}


// calculate ship module logic
// todo: make frametime dependent
__kernel void incrementShipModuleStates(__global uchar * restrict  shipModuleType, __global int * restrict  shipModuleEnergy,
										__global uchar *  restrict shipModuleHP, __global uchar *  restrict shipModuleHPMax,
										__global uint * restrict  randBuf,__global int * restrict  shipModuleEnergyMax,
										__global int *  restrict shipModuleWeight, __global uchar * restrict  shipModuleState,
										__global int * restrict  shipShieldMax, __global int * restrict shipShield,
										__global float * restrict frameTime)
{ 
	int i=get_global_id(0); // ship id
	int ftStep=(   (frameTime[2]>0.0f) ?  floor(frameTime[2]+0.1f)  :   0   );
	for(int ft=0;ft<ftStep;ft++)
	{ 
		// get total power
		int totalPowerThisTurn=0;

		// get total power from both energy generation and stored energy capacitors
		for(int im=0;im<MAX_MODULES_PER_SHIP;im++)
		{ 
			// power source gives energy
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_POWER_SOURCE)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					totalPowerThisTurn++; // 1 power per source regardless of capacity
					if(shipModuleEnergy[i + im*N_SHIP_MAX]>0)
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						totalPowerThisTurn+=shipModuleEnergy[i + im*N_SHIP_MAX];
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						shipModuleEnergy[i + im*N_SHIP_MAX]=0;
					}
				}
			}
			else
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					totalPowerThisTurn+=2; // 2 power per source regardless of capacity
					if(shipModuleEnergy[i + im*N_SHIP_MAX]>0)
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						totalPowerThisTurn+=shipModuleEnergy[i + im*N_SHIP_MAX];
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						shipModuleEnergy[i + im*N_SHIP_MAX]=0;
					}
				}
			}
			else
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					totalPowerThisTurn+=4; // 4 power per source regardless of capacity
					if(shipModuleEnergy[i + im*N_SHIP_MAX]>0)
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						totalPowerThisTurn+=shipModuleEnergy[i + im*N_SHIP_MAX];
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						shipModuleEnergy[i + im*N_SHIP_MAX]=0;
					}
				}
			}
			else
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					totalPowerThisTurn+=8; // 8 power per source regardless of capacity
					if(shipModuleEnergy[i + im*N_SHIP_MAX]>0)
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						totalPowerThisTurn+=shipModuleEnergy[i + im*N_SHIP_MAX];
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						shipModuleEnergy[i + im*N_SHIP_MAX]=0;
					}
				}
			}
			else
			// energy capacitor gives energy
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					if(shipModuleEnergy[i + im*N_SHIP_MAX]>0)
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						totalPowerThisTurn+=shipModuleEnergy[i + im*N_SHIP_MAX];
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						shipModuleEnergy[i + im*N_SHIP_MAX]=0;
					}
				}
			}
			else
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR_FRIGATE)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					if(shipModuleEnergy[i + im*N_SHIP_MAX]>0)
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						totalPowerThisTurn+=shipModuleEnergy[i + im*N_SHIP_MAX];
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						shipModuleEnergy[i + im*N_SHIP_MAX]=0;
					}
				}
			}
			else
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR_DESTROYER)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					if(shipModuleEnergy[i + im*N_SHIP_MAX]>0)
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						totalPowerThisTurn+=shipModuleEnergy[i + im*N_SHIP_MAX];
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						shipModuleEnergy[i + im*N_SHIP_MAX]=0;
					}
				}
			}
			else
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					if(shipModuleEnergy[i + im*N_SHIP_MAX]>0)
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						totalPowerThisTurn+=shipModuleEnergy[i + im*N_SHIP_MAX];
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						shipModuleEnergy[i + im*N_SHIP_MAX]=0;
					}
				}
			}
		}

		mem_fence(CLK_GLOBAL_MEM_FENCE);
		int r=dice(10, randBuf,i);
		mem_fence(CLK_GLOBAL_MEM_FENCE);


		// iterate all modules of ship (random starting point for equal distribution(not simple iteration because of anti-predictability))
		for(int im0=0;im0<MAX_MODULES_PER_SHIP;im0++)
		{ 
			int im=((im0+r)%MAX_MODULES_PER_SHIP);
			// charge weapons, only if there is enough power in ship
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_CANNON_TURRET)
			{ 
				// only if weapon is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					// only if charge is less than max charge of weapon
					if(shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX])
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						// 1 to 1 conversion of energy to weapon charge
						if(totalPowerThisTurn>=SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE; 
							totalPowerThisTurn-=SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE;
						}
					}
				}
			}
			else if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_CANNON_TURRET_FRIGATE)
			{ 
				// only if weapon is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					// only if charge is less than max charge of weapon
					if(shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX])
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						// 1 to 1 conversion of energy to weapon charge
						if(totalPowerThisTurn>=SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE_FRIGATE)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE_FRIGATE; 
							totalPowerThisTurn-=SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE_FRIGATE;
						}
					}
				}
			}
			else if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER)
			{ 
				// only if weapon is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					// only if charge is less than max charge of weapon
					if(shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX])
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						// 1 to 1 conversion of energy to weapon charge
						if(totalPowerThisTurn>=SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE_DESTROYER)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE_DESTROYER; 
							totalPowerThisTurn-=SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE_DESTROYER;
						}
					}
				}
			}
			else if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER)
			{ 
				// only if weapon is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					// only if charge is less than max charge of weapon
					if(shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX])
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						// 1 to 1 conversion of energy to weapon charge
						if(totalPowerThisTurn>=SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE_CRUISER)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE_CRUISER; 
							totalPowerThisTurn-=SHIP_MODULE_CANNON_TURRET_ENERGY_TRADE_CRUISER;
						}
					}
				}
			}
			else
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO)
			{ 
				// only if weapon is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					// only if charge is less than max charge of weapon
					if(shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX])
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						// 1 to 1 conversion of energy to weapon charge
						if(totalPowerThisTurn>=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE; 
							totalPowerThisTurn-=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE;
						}
					}
				}
			}
			else if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE)
			{ 
				// only if weapon is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					// only if charge is less than max charge of weapon
					if(shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX])
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						// 1 to 1 conversion of energy to weapon charge
						if(totalPowerThisTurn>=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE_FRIGATE)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE_FRIGATE; 
							totalPowerThisTurn-=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE_FRIGATE;
						}
					}
				}
			}
			else if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER)
			{ 
				// only if weapon is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					// only if charge is less than max charge of weapon
					if(shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX])
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						// 1 to 1 conversion of energy to weapon charge
						if(totalPowerThisTurn>=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE_DESTROYER)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE_DESTROYER; 
							totalPowerThisTurn-=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE_DESTROYER;
						}
					}
				}
			}
			else
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_CRUISER)
			{ 
				// only if weapon is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					// only if charge is less than max charge of weapon
					if(shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX])
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						// 1 to 1 conversion of energy to weapon charge
						if(totalPowerThisTurn>=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE_CRUISER)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE_CRUISER; 
							totalPowerThisTurn-=SHIP_MODULE_CANNON_TURRET_TURBO_ENERGY_TRADE_CRUISER;
						}
					}
				}
			}
			else
			// charge shield generators	

			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR)
			{ 
				// only if weapon is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					// only if charge is less than max charge of shield generator
					if(shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX])
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						// 1 to 1 conversion of energy to weapon charge
						if(totalPowerThisTurn>0)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]++; 
							totalPowerThisTurn--;

							mem_fence(CLK_GLOBAL_MEM_FENCE);
						}
					}
					else
					{ 
						// shield recharge is full, regenerate shield, deplete recharge, recharge 1(as in upper case)
						int currentShield=shipShield[i];
						if(currentShield<0)
							currentShield=0;
						
						mem_fence(CLK_GLOBAL_MEM_FENCE);

						// only if shield needs regeneration
						if(currentShield<(shipShieldMax[i]))
						{
							if(totalPowerThisTurn>0)
							{ 
								shipModuleEnergy[i + im*N_SHIP_MAX]-=SHIP_MODULE_SHIELD_GENERATOR_ENERGY-1; // deplete and charge by 1 
								totalPowerThisTurn--;
								mem_fence(CLK_GLOBAL_MEM_FENCE);
								shipShield[i]=currentShield+1;
							}
						}
					}
				}
			}
			else 
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE)
			{ 
				// only if weapon is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					// only if charge is less than max charge of shield generator
					if(shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX])
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						// 1 to 1 conversion of energy to weapon charge
						if(totalPowerThisTurn>1)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=2; 
							totalPowerThisTurn-=2;

							mem_fence(CLK_GLOBAL_MEM_FENCE);
						}
					}
					else
					{ 
						// shield recharge is full, regenerate shield, deplete recharge, recharge 1(as in upper case)
						int currentShield=shipShield[i];
						if(currentShield<0)
							currentShield=0;
						
						mem_fence(CLK_GLOBAL_MEM_FENCE);

						// only if shield needs regeneration
						if(currentShield<(shipShieldMax[i]))
						{
							if(totalPowerThisTurn>1)
							{ 
								shipModuleEnergy[i + im*N_SHIP_MAX]-=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_FRIGATE-1; // deplete and charge by 1 
								totalPowerThisTurn-=2;
								mem_fence(CLK_GLOBAL_MEM_FENCE);
								shipShield[i]=currentShield+1;
							}
						}
					}
				}
			}
			else 
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_DESTROYER)
			{ 
				// only if weapon is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					// only if charge is less than max charge of shield generator
					if(shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX])
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						// 1 to 1 conversion of energy to weapon charge
						if(totalPowerThisTurn>3)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=4; 
							totalPowerThisTurn-=4;

							mem_fence(CLK_GLOBAL_MEM_FENCE);
						}
					}
					else
					{ 
						// shield recharge is full, regenerate shield, deplete recharge, recharge 1(as in upper case)
						int currentShield=shipShield[i];
						if(currentShield<0)
							currentShield=0;
						
						mem_fence(CLK_GLOBAL_MEM_FENCE);

						// only if shield needs regeneration
						if(currentShield<(shipShieldMax[i]))
						{
							if(totalPowerThisTurn>3)
							{ 
								shipModuleEnergy[i + im*N_SHIP_MAX]-=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_DESTROYER-1; // deplete and charge by 1 
								totalPowerThisTurn-=4;
								mem_fence(CLK_GLOBAL_MEM_FENCE);
								shipShield[i]=currentShield+1;
							}
						}
					}
				}
			}
			else
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER)
			{ 
				// only if weapon is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					// only if charge is less than max charge of shield generator
					if(shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX])
					{ 
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						// 1 to 1 conversion of energy to weapon charge
						if(totalPowerThisTurn>7)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=8; 
							totalPowerThisTurn-=8;

							mem_fence(CLK_GLOBAL_MEM_FENCE);
						}
					}
					else
					{ 
						// shield recharge is full, regenerate shield, deplete recharge, recharge 1(as in upper case)
						int currentShield=shipShield[i];
						if(currentShield<0)
							currentShield=0;
						
						mem_fence(CLK_GLOBAL_MEM_FENCE);

						// only if shield needs regeneration
						if(currentShield<(shipShieldMax[i]))
						{
							if(totalPowerThisTurn>7)
							{ 
								shipModuleEnergy[i + im*N_SHIP_MAX]-=SHIP_MODULE_SHIELD_GENERATOR_ENERGY_CRUISER-1; // deplete and charge by 1 
								totalPowerThisTurn-=8;
								mem_fence(CLK_GLOBAL_MEM_FENCE);
								shipShield[i]=currentShield+1;
							}
						}
					}
				}
			}
		}


		// charge energy capacitors and power sources back with excessive power
		for(int im=0;im<MAX_MODULES_PER_SHIP;im++)
		{ 
			// power source takes energy
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_POWER_SOURCE)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					if((shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX]))
					{ 
						if(totalPowerThisTurn>0)
						{ 
							mem_fence(CLK_GLOBAL_MEM_FENCE);
							totalPowerThisTurn--;
							shipModuleEnergy[i + im*N_SHIP_MAX]++;
						}
					}
				}
			}

			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					if((shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX]))
					{ 
						if(totalPowerThisTurn>4)
						{ 
							mem_fence(CLK_GLOBAL_MEM_FENCE);
							totalPowerThisTurn-=5;
							shipModuleEnergy[i + im*N_SHIP_MAX]+=5;
						}
					}
				}
			}

			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					if((shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX]))
					{ 
						if(totalPowerThisTurn>19)
						{ 
							mem_fence(CLK_GLOBAL_MEM_FENCE);
							totalPowerThisTurn-=20;
							shipModuleEnergy[i + im*N_SHIP_MAX]+=20;
						}
					}
				}
			}

			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					if((shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX]))
					{ 
						// to do: charge all values between 1-100, not only 100
						if(totalPowerThisTurn>99)
						{ 
							mem_fence(CLK_GLOBAL_MEM_FENCE);
							totalPowerThisTurn-=100;
							shipModuleEnergy[i + im*N_SHIP_MAX]+=100;
						}
					}
				}
			}

			// energy capacitor takes energy
			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					if((shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX]) && (totalPowerThisTurn>0))
					{ 
						int maxChargeBack = shipModuleEnergyMax[i + im*N_SHIP_MAX]-shipModuleEnergy[i + im*N_SHIP_MAX];
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						if(maxChargeBack >= totalPowerThisTurn)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=totalPowerThisTurn;
							totalPowerThisTurn=0;
						}

						if(maxChargeBack < totalPowerThisTurn)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=maxChargeBack;
							totalPowerThisTurn-=maxChargeBack;
						}
					}
				}
			}

			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR_FRIGATE)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					if((shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX]) && (totalPowerThisTurn>0))
					{ 
						int maxChargeBack = shipModuleEnergyMax[i + im*N_SHIP_MAX]-shipModuleEnergy[i + im*N_SHIP_MAX];
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						if(maxChargeBack >= totalPowerThisTurn)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=totalPowerThisTurn;
							totalPowerThisTurn=0;
						}

						if(maxChargeBack < totalPowerThisTurn)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=maxChargeBack;
							totalPowerThisTurn-=maxChargeBack;
						}
					}
				}
			}

			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR_DESTROYER)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					if((shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX]) && (totalPowerThisTurn>0))
					{ 
						int maxChargeBack = shipModuleEnergyMax[i + im*N_SHIP_MAX]-shipModuleEnergy[i + im*N_SHIP_MAX];
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						if(maxChargeBack >= totalPowerThisTurn)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=totalPowerThisTurn;
							totalPowerThisTurn=0;
						}

						if(maxChargeBack < totalPowerThisTurn)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=maxChargeBack;
							totalPowerThisTurn-=maxChargeBack;
						}
					}
				}
			}

			if(shipModuleType[i + im*N_SHIP_MAX]==SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER)
			{ 
				// only if it is working
				if((shipModuleState[i + im*N_SHIP_MAX]&SHIP_MODULE_STATE_WORKING)!=0)
				{ 
					if((shipModuleEnergy[i + im*N_SHIP_MAX]<shipModuleEnergyMax[i + im*N_SHIP_MAX]) && (totalPowerThisTurn>0))
					{ 
						int maxChargeBack = shipModuleEnergyMax[i + im*N_SHIP_MAX]-shipModuleEnergy[i + im*N_SHIP_MAX];
						mem_fence(CLK_GLOBAL_MEM_FENCE);
						if(maxChargeBack >= totalPowerThisTurn)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=totalPowerThisTurn;
							totalPowerThisTurn=0;
						}

						if(maxChargeBack < totalPowerThisTurn)
						{ 
							shipModuleEnergy[i + im*N_SHIP_MAX]+=maxChargeBack;
							totalPowerThisTurn-=maxChargeBack;
						}
					}
				}
			}
		}
	}
}

__kernel void loadBitmaps(__global uchar4 * shipPixels, __global uchar4 * projectilePixels,
						  __global uchar4 * skyPixels, __global uchar4 * captainRankPixels,
						  __global uchar4 * charPixels)
{ 
	int i=get_global_id(0);
}

__kernel void boardEnemyShips(__global float * restrict shipX, __global float * restrict shipY)
{ 
	int i=get_global_id(0); // ship id
}

__kernel void prepareBoardingMarinesForPod()
{ 
	int i=get_global_id(0);
}

@@customKernels@@