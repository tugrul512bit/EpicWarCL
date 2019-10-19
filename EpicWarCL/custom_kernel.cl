

#define N_SCRIPT_WORKER @@scriptWorkerN@@

// Script engine commands
// executed by N_SCRIPT_WORKER workitems, controlled by 0th workitem
// pseudo opencl2.0 dynamic parallelism in opencl1.2
// *************************************************************
// *************************************************************

// commands

// waits for COMMAND_PARAMETER_0(c) miliseconds after time of this command
#define COMMAND_WAIT_MS @@uid@@

// waits for COMMAND_PARAMETER_0(c) miliseconds after beginning
#define COMMAND_WAIT_FOR_TOTAL_TIME @@uid@@

// waits until a frame no is reached
#define COMMAND_WAIT_FOR_FRAME @@uid@@

// bind command flow to a worker(parmeter0), jump current worker by step size(parmeter1)
#define COMMAND_BIND_WORKER @@uid@@

// check next command at leap point (N_SCRIPT_WORKER * step size) - (step size - 1)
// if it is BIND with same id, continue from that point
// else if, id==0, continue by leap 1
// else, stop worker
#define COMMAND_STOP_WORKER @@uid@@

// waits for all workers completed
#define COMMAND_SYNC_WORKER @@uid@@

// lock camera to ship center
#define COMMAND_LOCK_CAMERA_TO_SHIP @@uid@@

// move ships outside of map(close to negative infinity), they can't find enemy, move, attack there
#define COMMAND_MOVE_ALL_SHIPS_OUT @@uid@@

// move ships outside of map(close to negative infinity), they can't find enemy, move, attack there
// each ship is moved by a different worker
#define COMMAND_PARALLEL_MOVE_ALL_SHIPS_OUT @@uid@@

// enable hardpoint layout view for all ships
#define COMMAND_ENABLE_HARDPOINT_VIEW @@uid@@

// enable captain experience view for all ships
#define COMMAND_ENABLE_CAPTAIN_EXPERIENCE_VIEW @@uid@@


// create custom ship (with class, team, hardpoints, crew)
// using a pointer to a data block on integer data buffer
// which contains ship id, class type, team, crew, hardpoint, position info
#define COMMAND_CREATE_SHIP_BY_DATA @@uid@@

// create custom ship (with class, team, hardpoints, crew)
// using a pointer to a data block on integer data buffer
// which contains ship id, class type, team, crew, hardpoint, position info
#define COMMAND_PARALLEL_CREATE_SHIP_BY_DATA @@uid@@

// move ship instantly
#define COMMAND_MOVE_SHIP @@uid@@

// set target location for ship to move itself
#define COMMAND_SET_SHIP_MOVE_TARGET @@uid@@

// set target ship for a ship to move itself
#define COMMAND_SET_SHIP_SHIP_TARGET @@uid@@

// gets ship(from id in commandData) coordinates into data[c] and data[c+1]
#define COMMAND_GET_SHIP_COORDINATES_TO_DATA @@uid@@


// for loop begin
// next int value is counter(as start value)
// next is limit (exclusive)
// increments
// executes all commands inside
// nesting not supported
#define COMMAND_FLOW_FOR_BEGIN @@uid@@

// i is index in commands array that points to for loop begin
// used in script engine
#define COMMAND_FLOW_FOR_COUNTER(i) (commands[i+1])
#define COMMAND_FLOW_FOR_LIMIT(i) (commands[i+2])

// for loop end
#define COMMAND_FLOW_FOR_END @@uid@@

// instantly move camera to x,y position on map which is defined on float scriptData array
// uses 2 parameters  (if command is 5th on int array, x=6th on float, y=7th on float)
#define COMMAND_WARP_CAMERA @@uid@@

// change scale, use parameter 0
#define COMMAND_ZOOM_CAMERA @@uid@@

// command parameters are on float array(2x long)
#define COMMAND_PARAMETER_0(c) (2*c)
#define COMMAND_PARAMETER_1(c) (2*c+1)

#define COMMAND_DISABLE_MOUSE_POINTER @@uid@@
#define COMMAND_ENABLE_MOUSE_POINTER @@uid@@

// slowly move camera to x,y version of warp camera command
#define COMMAND_MOVE_CAMERA_TO_SHIP_ANIMATED @@uid@@
#define COMMAND_MOVE_CAMERA_BEGIN @@uid@@
#define COMMAND_MOVE_CAMERA_CURRENT_POS @@uid@@
#define COMMAND_MOVE_CAMERA_END @@uid@@

// array indices for all angine states in engineState array
#define ENGINE_STATE_PER_THREAD 15
#define ENGINE_STATE_FRAME_COUNT 0
#define ENGINE_STATE_WORKER_ACTIVE 1
#define ENGINE_STATE_WORKER_JUMP_SIZE 2
#define ENGINE_STATE_WORKER_NUM_JUMPS_LEFT 3
#define ENGINE_STATE_WORKER_RUNNING_COUNT 4

// user variables. mouse positions, camera positions, map properties, ...
// as array indices (float variables)
#define USER_VAR_MAP_SCALE 0

// camera position on map
#define USER_VAR_MAP_X 1
#define USER_VAR_MAP_Y 2

// mouse position on screen
#define USER_VAR_MOUSE_X 5
#define USER_VAR_MOUSE_Y 6

// user variables. integers (hardpoint view toggle, experience view toggle, ...)
#define USER_VAR_HARDPOINT_VIEW 12
#define USER_VAR_CAPTAIN_EXPERIENCE_VIEW 13


// time variables
// as array indices
#define TIME_TOTAL_ELAPSED 3
#define TIME_CHECKPOINT 4

// **************************************************************
// **************************************************************

            __kernel void incrementBenchmarkFrame(__global int * engineState)
            {
                int i=get_global_id(0);
                if(i==0)
                {
                    engineState[ENGINE_STATE_FRAME_COUNT]++;
                }
            }


            // todo: 1024 --> 4096 array alignment
            __constant uchar cruiserDesignAntiCorvette[11]={
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,
                SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,
                SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,
                SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,
                3 /* cruiser */
            };

            __constant uchar cruiserDesignAntiCruiser[11]={
                SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER,SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER,
                SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,
                SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,
                SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,
                SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,
                3 /* cruiser */
            };

            __constant uchar cruiserDesignAntiFrigate[11]={
                SHIP_MODULE_TYPE_SHIELD_GENERATOR_CRUISER,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER,
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER,SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,
                SHIP_MODULE_TYPE_CANNON_TURRET_CRUISER,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER,
                SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,
                SHIP_MODULE_TYPE_POWER_SOURCE_CRUISER,SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,
                3 /* cruiser */
            };

            __constant uchar frigateDesignAntiCorvette[11]={
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE,SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,
                SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,
                SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE,
                SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE,SHIP_MODULE_TYPE_SHIELD_GENERATOR_FRIGATE,
                1 /* frigate */
            };

            __constant uchar heavyFrigateDesignAntiCorvette[11]={
                SHIP_MODULE_TYPE_CANNON_TURRET_FRIGATE,SHIP_MODULE_TYPE_CANNON_TURRET_FRIGATE,
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE,SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_FRIGATE,
                SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,
                SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,SHIP_MODULE_TYPE_POWER_SOURCE_FRIGATE,
                SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,
                1 /* frigate */
            };

            __constant uchar destroyerDesignAntiCruiser[11]={
                SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER,SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER,
                SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER,SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER,
                SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER,SHIP_MODULE_TYPE_CANNON_TURRET_DESTROYER,
                SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER,SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER,
                SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER,SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,
                2 /* destroyer */
            };

            __constant uchar destroyerDesignAntiCorvette[11]={
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO_DESTROYER,SHIP_MODULE_TYPE_CANNON_TURRET,
                SHIP_MODULE_TYPE_CANNON_TURRET,SHIP_MODULE_TYPE_CANNON_TURRET,
                SHIP_MODULE_TYPE_CANNON_TURRET,SHIP_MODULE_TYPE_CANNON_TURRET,
                SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER,SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER,
                SHIP_MODULE_TYPE_POWER_SOURCE_DESTROYER,SHIP_MODULE_TYPE_ENERGY_CAPACITOR_CRUISER,
                2 /* destroyer */
            };

            __constant uchar heavyCorvetteDesignAntiFrigate[11]={
                SHIP_MODULE_TYPE_SHIELD_GENERATOR,SHIP_MODULE_TYPE_SHIELD_GENERATOR,
                SHIP_MODULE_TYPE_CANNON_TURRET,SHIP_MODULE_TYPE_CANNON_TURRET,
                SHIP_MODULE_TYPE_POWER_SOURCE,SHIP_MODULE_TYPE_POWER_SOURCE,
                SHIP_MODULE_TYPE_POWER_SOURCE,SHIP_MODULE_TYPE_POWER_SOURCE,
                SHIP_MODULE_TYPE_ENERGY_CAPACITOR,SHIP_MODULE_TYPE_ENERGY_CAPACITOR,
                0 /* corvette */
            };



            __constant uchar corvetteDesignAntiCorvette[11]={
                SHIP_MODULE_TYPE_CANNON_TURRET_TURBO,SHIP_MODULE_TYPE_CANNON_TURRET,
                SHIP_MODULE_TYPE_SHIELD_GENERATOR,SHIP_MODULE_TYPE_SHIELD_GENERATOR,
                SHIP_MODULE_TYPE_POWER_SOURCE,SHIP_MODULE_TYPE_POWER_SOURCE,
                SHIP_MODULE_TYPE_ENERGY_CAPACITOR,SHIP_MODULE_TYPE_ENERGY_CAPACITOR,
                SHIP_MODULE_TYPE_SHIELD_GENERATOR,SHIP_MODULE_TYPE_SHIELD_GENERATOR,
                0 /* corvette */
            };


            void clearMap(int * adr, __global int * command)
            {
                command[(*adr)++]=COMMAND_MOVE_ALL_SHIPS_OUT; 
            }

            void disableMousePointer(int * adr, __global int * command)
            {
                command[(*adr)++]=COMMAND_DISABLE_MOUSE_POINTER; 
            }

            void enableMousePointer(int * adr, __global int * command)
            {
                command[(*adr)++]=COMMAND_ENABLE_MOUSE_POINTER; 
            }



            void enableHardpointView(int * adr, __global int * command)
            {
                command[(*adr)++]=COMMAND_ENABLE_HARDPOINT_VIEW; 
            }

            void enableCaptainExperienceView(int * adr, __global int * command)
            {
                command[(*adr)++]=COMMAND_ENABLE_CAPTAIN_EXPERIENCE_VIEW; 
            }


            void lockCameraToShipForTimeSpan(int shipId, float forMilisecond, int * adr, __global int * command, __global float * commandData)
            {
                command[*adr]=COMMAND_LOCK_CAMERA_TO_SHIP; 
                commandData[COMMAND_PARAMETER_0((*adr))]=(float)shipId; 
                commandData[COMMAND_PARAMETER_1((*adr))]=forMilisecond;
                (*adr)++;
            }

            void waitForTimePoint(int atMilisecond, int * adr, __global int * command,  __global float * commandData)
            {
                command[(*adr)]=COMMAND_WAIT_FOR_TOTAL_TIME;   
                commandData[COMMAND_PARAMETER_0((*adr))]=atMilisecond;     
                (*adr)++;
            }

            void warpCameraAtTime(int atMilisecond, float X, float Y, int * adr, __global int * command,  __global float * commandData)
            {
                command[(*adr)]=COMMAND_WAIT_FOR_TOTAL_TIME;   
                commandData[COMMAND_PARAMETER_0((*adr))]=atMilisecond;     
                (*adr)++;
                command[(*adr)]=COMMAND_WARP_CAMERA;    // define instant camera move action
                commandData[COMMAND_PARAMETER_0((*adr))]=X;      // define x of new cam position
                commandData[COMMAND_PARAMETER_1((*adr))]=Y;      // define y of new cam position
                (*adr)++;
            }

            void zoomCameraAtTime(int atMilisecond,float zoomScale, int * adr, __global int * command,  __global float * commandData)
            {
                command[(*adr)]=COMMAND_WAIT_FOR_TOTAL_TIME;  
                commandData[COMMAND_PARAMETER_0((*adr))]=atMilisecond;      
                (*adr)++;
                command[(*adr)]=COMMAND_ZOOM_CAMERA;    
                commandData[COMMAND_PARAMETER_0((*adr))]=zoomScale;    
                (*adr)++;
            }

            void waitForTimeSpan(float forMilisecond, int * adr, __global int * command, __global float * commandData)
            {
                command[(*adr)]=COMMAND_WAIT_MS; 
                commandData[COMMAND_PARAMETER_0((*adr))]=forMilisecond;
                (*adr)++;
            }

            void createShipAtScreenCenter(int shipId, uchar team, bool isMoving, float direction, float X, float Y, bool isCameraOrigin, 
                            __constant uchar * design, int * adr, int * dataAdr, 
                            __global int * command, __global float * commandData, __global int * dataInt,
                            __global float * dataFloat)
            {
                command[(*adr)]=COMMAND_CREATE_SHIP_BY_DATA; 
                commandData[COMMAND_PARAMETER_0((*adr))] = (float)(*dataAdr); // points to a data[] address
                dataInt[(*dataAdr)++]=shipId; // new ship's id value(position in array)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:X); // create at (center of camera view if negative) X pixel
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:Y); // create at (center of camera view if negative) Y pixel
                dataFloat[(*dataAdr)++]=(isCameraOrigin?X:0.0f); // translation X if its created at camera view
                dataFloat[(*dataAdr)++]=(isCameraOrigin?Y:0.0f); // translation Y if its created at camera view
                dataInt[(*dataAdr)++]=team; // team number
                dataInt[(*dataAdr)++]=design[10]; // size class 0=corvette, 1=frigate, 2=destroyer, 3=cruiser
                dataInt[(*dataAdr)++]=design[0]; 
                dataInt[(*dataAdr)++]=design[1]; 
                dataInt[(*dataAdr)++]=design[2];
                dataInt[(*dataAdr)++]=design[3]; 
                dataInt[(*dataAdr)++]=design[4]; 
                dataInt[(*dataAdr)++]=design[5]; 
                dataInt[(*dataAdr)++]=design[6]; 
                dataInt[(*dataAdr)++]=design[7]; 
                dataInt[(*dataAdr)++]=design[8]; 
                dataInt[(*dataAdr)++]=design[9]; 
                dataInt[(*dataAdr)++]=(isMoving?1:0); // moving
                dataFloat[(*dataAdr)++]=direction; // direction
                (*adr)++;
            }

            void createShipAtMapCoordinate(int shipId, uchar team, bool isMoving, float direction, float X, float Y, 
                            __constant uchar * design, int * adr, int * dataAdr, 
                            __global int * command, __global float * commandData, __global int * dataInt,
                            __global float * dataFloat)
            {
                command[(*adr)]=COMMAND_CREATE_SHIP_BY_DATA; 
                commandData[COMMAND_PARAMETER_0((*adr))] = (float)(*dataAdr); // points to a data[] address
                dataInt[(*dataAdr)++]=shipId; // new ship's id value(position in array)
                dataFloat[(*dataAdr)++]=(X); // create at (center of camera view if negative) X pixel
                dataFloat[(*dataAdr)++]=(Y); // create at (center of camera view if negative) Y pixel
                dataFloat[(*dataAdr)++]=(0.0f); // translation X if its created at camera view
                dataFloat[(*dataAdr)++]=(0.0f); // translation Y if its created at camera view
                dataInt[(*dataAdr)++]=team; // team number
                dataInt[(*dataAdr)++]=design[10]; // size class 0=corvette, 1=frigate, 2=destroyer, 3=cruiser
                dataInt[(*dataAdr)++]=design[0]; 
                dataInt[(*dataAdr)++]=design[1]; 
                dataInt[(*dataAdr)++]=design[2];
                dataInt[(*dataAdr)++]=design[3]; 
                dataInt[(*dataAdr)++]=design[4]; 
                dataInt[(*dataAdr)++]=design[5]; 
                dataInt[(*dataAdr)++]=design[6]; 
                dataInt[(*dataAdr)++]=design[7]; 
                dataInt[(*dataAdr)++]=design[8]; 
                dataInt[(*dataAdr)++]=design[9]; 
                dataInt[(*dataAdr)++]=(isMoving?1:0); // moving
                dataFloat[(*dataAdr)++]=direction; // direction
                (*adr)++;
            }

            void placeShipAtTime(   int shipId, int atMiliseconds, bool isMoving, float direction, bool isCameraOrigin, float X, float Y,
                                    int * adr, int * dataAdr, __global int * command, __global float * commandData,
                                    __global int * dataInt, __global float * dataFloat)
            {
                command[(*adr)]=COMMAND_WAIT_FOR_TOTAL_TIME;  
                commandData[COMMAND_PARAMETER_0((*adr))]=atMiliseconds;     
                (*adr)++;
                command[(*adr)]=COMMAND_MOVE_SHIP; 
                commandData[COMMAND_PARAMETER_0((*adr))]=(float)(*dataAdr); // move ship with data of id, target coordinates
                dataInt[(*dataAdr)++]=shipId; // ship id
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:X); // X (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:Y); // Y (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?X:0.0f); // X translation from camera 
                dataFloat[(*dataAdr)++]=(isCameraOrigin?Y:0.0f); // Y translation from camera
                dataInt[(*dataAdr)++]=(isMoving?1:0); // moving
                dataFloat[(*dataAdr)++]=direction; // direction
                (*adr)++;
            }


            void placeShipAfterTimeSpan(   int shipId, int forMiliseconds, bool isMoving, float direction, bool isCameraOrigin, float X, float Y,
                                    int * adr, int * dataAdr, __global int * command, __global float * commandData,
                                    __global int * dataInt, __global float * dataFloat)
            {
                command[(*adr)]=COMMAND_WAIT_MS;  
                commandData[COMMAND_PARAMETER_0((*adr))]=forMiliseconds;     
                (*adr)++;
                command[(*adr)]=COMMAND_MOVE_SHIP; 
                commandData[COMMAND_PARAMETER_0((*adr))]=(float)(*dataAdr); // move ship with data of id, target coordinates
                dataInt[(*dataAdr)++]=shipId; // ship id
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:X); // X (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:Y); // Y (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?X:0.0f); // X translation from camera 
                dataFloat[(*dataAdr)++]=(isCameraOrigin?Y:0.0f); // Y translation from camera
                dataInt[(*dataAdr)++]=(isMoving?1:0); // moving
                dataFloat[(*dataAdr)++]=direction; // direction
                (*adr)++;
            }

            void translateShipAfterTimeSpan(   int shipId, int forMiliseconds, bool isMoving, bool isCameraOrigin, float X, float Y,
                                    int * adr, int * dataAdr, __global int * command, __global float * commandData,
                                    __global int * dataInt, __global float * dataFloat)
            {
                command[(*adr)]=COMMAND_WAIT_MS;  
                commandData[COMMAND_PARAMETER_0((*adr))]=forMiliseconds;     
                (*adr)++;
                command[(*adr)]=COMMAND_MOVE_SHIP; 
                commandData[COMMAND_PARAMETER_0((*adr))]=(float)(*dataAdr); // move ship with data of id, target coordinates
                dataInt[(*dataAdr)++]=shipId; // ship id
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:X); // X (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:Y); // Y (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?X:0.0f); // X translation from camera 
                dataFloat[(*dataAdr)++]=(isCameraOrigin?Y:0.0f); // Y translation from camera
                dataInt[(*dataAdr)++]=(isMoving?1:0); // moving
                dataFloat[(*dataAdr)++]=999999999.0f; // direction
                (*adr)++;
            }


            void translateShipAtTime(   int shipId, int atMiliseconds, bool isMoving, bool isCameraOrigin, float X, float Y,
                                    int * adr, int * dataAdr, __global int * command, __global float * commandData,
                                    __global int * dataInt, __global float * dataFloat)
            {
                command[(*adr)]=COMMAND_WAIT_FOR_TOTAL_TIME;  
                commandData[COMMAND_PARAMETER_0((*adr))]=atMiliseconds;     
                (*adr)++;
                command[(*adr)]=COMMAND_MOVE_SHIP; 
                commandData[COMMAND_PARAMETER_0((*adr))]=(float)(*dataAdr); // move ship with data of id, target coordinates
                dataInt[(*dataAdr)++]=shipId; // ship id
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:X); // X (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?-1.0f:Y); // Y (negative means to camera)
                dataFloat[(*dataAdr)++]=(isCameraOrigin?X:0.0f); // X translation from camera 
                dataFloat[(*dataAdr)++]=(isCameraOrigin?Y:0.0f); // Y translation from camera
                dataInt[(*dataAdr)++]=(isMoving?1:0); // moving
                dataFloat[(*dataAdr)++]=999999999.0f; // direction
                (*adr)++;
            }

#define parallelForScript(cmdAdr,commandArray,commandDataArray,iBegin,iEnd,jLoop,cBlock) \
{ \
    int adrDifference=0; \
    int nSerial=((iEnd-iBegin)%(N_SCRIPT_WORKER-1)); \
    int nParallel=(iEnd-iBegin)-nSerial; \
    int iParallelEnd=iBegin+nParallel; \
    for(int jLoop=iBegin;jLoop<iParallelEnd;jLoop++) \
    { \
        commandArray[cmdAdr]=COMMAND_BIND_WORKER;              \
        int tmpAdr=cmdAdr; \
        commandDataArray[COMMAND_PARAMETER_0(cmdAdr)]=1+jLoop%(N_SCRIPT_WORKER-1);  \
        cmdAdr++; \
        adrDifference = -cmdAdr; \
        cBlock \
        adrDifference+=cmdAdr;   \
        commandArray[cmdAdr++]=COMMAND_STOP_WORKER;           \
        commandDataArray[COMMAND_PARAMETER_1(tmpAdr)]=adrDifference+2; \
    } \
    int iSerialEnd=iParallelEnd+nSerial; \
    for(int jLoop=iParallelEnd;jLoop<iSerialEnd;jLoop++) \
    { \
        cBlock \
    } \
    commandArray[cmdAdr++]=COMMAND_SYNC_WORKER; \
}

                       
            void setShipMoveTarget(int shipId, float X, float Y, int * adr, int * dataAdr, __global int * command, 
                                   __global float * commandData, __global int * dataInt, __global float * dataFloat)
            {
                command[*adr]=COMMAND_SET_SHIP_MOVE_TARGET;
                commandData[COMMAND_PARAMETER_0(*adr)]=*dataAdr;
                dataInt[(*dataAdr)++]=shipId;
                dataFloat[(*dataAdr)++]=X;
                dataFloat[(*dataAdr)++]=Y;
                (*adr)++;
            } 

            void setShipShipTarget(int shipId, int targetShipId, int * adr, int * dataAdr, __global int * command, 
                                   __global float * commandData, __global int * dataInt, __global float * dataFloat)
            {
                command[*adr]=COMMAND_SET_SHIP_SHIP_TARGET;
                commandData[COMMAND_PARAMETER_0(*adr)]=*dataAdr;
                dataInt[(*dataAdr)++]=shipId;
                dataInt[(*dataAdr)++]=targetShipId;
                (*adr)++;
            } 



            void moveCameraToShipAnimated(int shipId,float forMilisecond, int * adr, int * dataAdr, 
                __global int * command, __global float *  commandData,__global int * dataInt, __global float * dataFloat)
            {
                command[*adr]=COMMAND_MOVE_CAMERA_TO_SHIP_ANIMATED;
                commandData[COMMAND_PARAMETER_0(*adr)]=(*dataAdr);
                dataInt[(*dataAdr)++]=shipId;
                dataFloat[(*dataAdr)++]=forMilisecond;
                dataFloat[(*dataAdr)++]=0.0f; // memory for current animation time (to calculate percentage of animation location)
                dataFloat[(*dataAdr)++]=0.0f; // memory for starting cam position x 
                dataFloat[(*dataAdr)++]=0.0f; // memory for starting cam position y
                (*adr)++; 
            }
     
__kernel void setup1080pBenchmarkScript(
                                        __global int * engineState, 
                                        __global int * command,    
                                        __global float * commandData,
                                        __global int * commandPointer,
                                        __global int * dataInt,
                                        __global float * dataFloat,
                                        __global uint * randBuf)
{
    int i=get_global_id(0);
    if(i==0)
    {
        if(engineState[ENGINE_STATE_FRAME_COUNT]==1)
        {
            int adr = 0; // command register
            int dataAdr = 0; // data register
            int trigMs=0;  // wait time
            for(int j=0;j<N_SCRIPT_WORKER;j++)
            {
                commandPointer[j]=0;
            }

            // clear map of all ships
            clearMap(&adr, command);
            disableMousePointer(&adr, command);  
            enableCaptainExperienceView(&adr, command);

            int teamBlue=2;
            int teamGreen=1;
            int teamRed=0;
            int newShipCreateId=0; // current ship id

            for(int j=0;j<20;j++)
            {
                float jx=(j/5)*100+200;
                float jy=(j%5)*100+200;
                createShipAtMapCoordinate(newShipCreateId++,teamRed, true, 45.0f, jx,jy, cruiserDesignAntiFrigate, 
                            &adr, &dataAdr, command, commandData, dataInt, dataFloat);
            }
            

            // 0= worker1, 254=worker255, worker0 is not usable
            parallelForScript(adr,command,commandData,0,255,j,
            {
                if(j==0)
                {
                    // lock camera pos to ship for whole benchmark duration
                    lockCameraToShipForTimeSpan(newShipCreateId-3, 120000.0f, &adr, command, commandData);
                }
                else if((j>=1) && (j<21))
                {
                    float rt=tw_rnd(randBuf,i)*3000.0f+250.0f;
                    for(int k=0;k<10000;k++)
                    {
                
                        int m=(j-1);
                        float mx=(m/5)*100+200;
                        float my=(m%5)*100+200;
                        translateShipAtTime(m,k*0.3f+rt, true, false, 
                            mx+k*0.97f,  my+k*0.97f,
                            &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                    }

                }
                else if(j==21)
                {
                    float currentZoom=1.0f;
                    int currentTime=10000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom-=0.002; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                    currentTime+=3000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom+=0.05; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                    currentTime+=5000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom-=0.048; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                    currentTime+=25000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom+=0.048; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                    currentTime+=5000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom-=0.048; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                    currentTime+=15000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom+=0.025; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                    currentTime+=3000;
                    for(int k=0;k<300;k++)
                    {    
                        currentZoom-=0.025; 
                        currentTime+=3;
                        zoomCameraAtTime(currentTime,currentZoom, &adr, command, commandData);
                    }
                }
                else if(j==22)
                {
                    int currentTime=10000;
                    waitForTimePoint(currentTime, &adr, command,  commandData);
                    currentTime+=10000;
                    for(int k=0;k<20;k++)
                        setShipMoveTarget(k,MAP_WIDTH/2.0f,MAP_HEIGHT, &adr, &dataAdr,command, 
                            commandData, dataInt, dataFloat);
                    waitForTimePoint(currentTime, &adr, command,  commandData);
                    currentTime+=7000;
                    for(int k=0;k<20;k++)
                        setShipMoveTarget(k,0,MAP_HEIGHT, &adr, &dataAdr,command, 
                            commandData, dataInt, dataFloat);

                    waitForTimePoint(currentTime, &adr, command,  commandData);
                    currentTime+=10000;
                    for(int k=0;k<20;k++)
                        setShipMoveTarget(k,MAP_WIDTH,2.0f*MAP_HEIGHT/3.0f, &adr, &dataAdr,command, 
                            commandData, dataInt, dataFloat);

                    waitForTimePoint(currentTime, &adr, command,  commandData);
                    
                    for(int k=0;k<20;k++)
                        setShipMoveTarget(k,MAP_WIDTH,MAP_HEIGHT/2.0f, &adr, &dataAdr,command, 
                            commandData, dataInt, dataFloat);
                }
                else if((j>=100) &&  (j<200))
                {
                    {
                        int k=j-100;
                        for(int l=0;l<5;l++)
                        {
                            float X=tw_rnd(randBuf,i)*19900.0f;
                            float Y=tw_rnd(randBuf,i)*19900.0f;
                            float rot=45.0f+180.0f;
                            int currentTeam=-1;
                            if(X+Y>20000.0f)
                                {currentTeam=teamBlue;}
                            else
                                {currentTeam=teamRed;rot-=180.0f;}
                                
                                createShipAtMapCoordinate(newShipCreateId++,currentTeam, true,rot, X,Y, cruiserDesignAntiCorvette, 
                                    &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                    
                        }
                        for(int l=0;l<20;l++)
                        {
                            float X=tw_rnd(randBuf,i)*19900.0f;
                            float Y=tw_rnd(randBuf,i)*19900.0f;
                            float rot=45.0f+180.0f;
                            int currentTeam=-1;
                            if(X+Y>20000.0f)
                                {currentTeam=teamBlue;}
                            else
                                {currentTeam=teamRed;rot-=180.0f;}
                                
                                createShipAtMapCoordinate(newShipCreateId++,currentTeam, true,rot, X,Y, destroyerDesignAntiCorvette, 
                                    &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                    
                        }
                        for(int l=0;l<200;l++)
                        {
                            float X=tw_rnd(randBuf,i)*19900.0f;
                            float Y=tw_rnd(randBuf,i)*19900.0f;
                            float rot=45.0f+180.0f;
                            int currentTeam=-1;
                            if(X+Y>20000.0f)
                                {currentTeam=teamBlue;}
                            else
                                {currentTeam=teamRed;rot-=180.0f;}
                            createShipAtMapCoordinate(newShipCreateId++,currentTeam, true,rot, X,Y, frigateDesignAntiCorvette, 
                                    &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                        }
                        for(int l=0;l<300;l++)
                        {
                            float X=tw_rnd(randBuf,i)*19900.0f;
                            float Y=tw_rnd(randBuf,i)*19900.0f;
                            float rot=45.0f+180.0f;
                            int currentTeam=-1;
                            if(X+Y>20000.0f)
                                {currentTeam=teamBlue;}
                            else
                                {currentTeam=teamRed;rot-=180.0f;}
                            createShipAtMapCoordinate(newShipCreateId++,currentTeam, true,rot, X,Y, corvetteDesignAntiCorvette, 
                                    &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                        }
                        waitForTimePoint(15000.0f, &adr, command,  commandData);
                        for(int l=0;l<300;l++)
                        {
                            float t=tw_rnd(randBuf,i)*(3.14f*2.0f);  // angle
                            float r=10000.0f + tw_rnd(randBuf,i)*500.0f;// distance
                            float rot=180.0f+t*(360.0f/(3.14f*2.0f));            // looking center
                            float X=r*cos(t)+10700.0f;
                            float Y=r*sin(t)+10700.0f;
                            createShipAtMapCoordinate(newShipCreateId++,teamGreen, true,rot, X,Y, corvetteDesignAntiCorvette, 
                                    &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                        }

                        waitForTimePoint(35000.0f, &adr, command,  commandData);
                        for(int l=0;l<200;l++)
                        {
                            float t=tw_rnd(randBuf,i)*(3.14f*2.0f);  // angle
                            float r=10000.0f + tw_rnd(randBuf,i)*500.0f;// distance
                            float rot=180.0f+t*(360.0f/(3.14f*2.0f));            // looking center
                            float X=r*cos(t)+10700.0f;
                            float Y=r*sin(t)+10700.0f;
                            createShipAtMapCoordinate(newShipCreateId++,teamGreen, true,rot, X,Y, frigateDesignAntiCorvette, 
                                    &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                        }
                    }
                }
            });
        }
    }
}

            __kernel void setup720pBenchmarkScript(
                                        __global int * engineState, 
                                        __global int * command,    
                                        __global float * commandData,
                                        __global int * commandPointer,
                                        __global int * dataInt,
                                        __global float * dataFloat,
                                        __global uint * randBuf)
            {
                int i=get_global_id(0);
                if(i==0)
                {
                    // at first frame, setup all scripts of benchmark
                    if(engineState[ENGINE_STATE_FRAME_COUNT]==1)
                    {   

                       int adr = 0; // command register
                       int dataAdr = 0; // data register
                       int trigMs=32000; 
                
                        
                       for(int j=0;j<N_SCRIPT_WORKER;j++)
                       {
                           commandPointer[j]=0;
                       }


                        // clear map of all ships
                        clearMap(&adr, command);

                        int newShipCreateId=0;

                        int teamBlue=2;
                        int teamGreen=1;
                        int teamRed=0;

                        int galactica=newShipCreateId;
                        createShipAtScreenCenter(newShipCreateId++,teamGreen, true, -30.0f, 0.0f,0.0f,true, cruiserDesignAntiCorvette, 
                            &adr, &dataAdr, command, commandData, dataInt, dataFloat);

                        
                        createShipAtScreenCenter(newShipCreateId,teamBlue, true, -30.0f, 150.0f,-60.0f,true, frigateDesignAntiCorvette, 
                            &adr, &dataAdr, command, commandData, dataInt, dataFloat);

                        int corellianCorvette=newShipCreateId;



                        // todo: add crew generation function (buildCruiserCrew(..))

                        enableMousePointer(&adr, command);

                        parallelForScript(adr,command,commandData,0,255,j,
                        {


                            if(j==2)
                            {
                                waitForTimeSpan(16000.0f, &adr, command, commandData);
                                setShipMoveTarget(newShipCreateId-1,0,MAP_HEIGHT/2.0f, &adr, &dataAdr,command, 
                                                    commandData, dataInt, dataFloat);
                            }
                            else if(j==3)
                            {
                                // ships coming out of warp
                                int ts=10500;
                                waitForTimeSpan(ts, &adr, command, commandData);
                                newShipCreateId++;
                                ts+=500;
                                for(int k=0;k<200;k++)
                                {
                                    float x0=900.0f+220.0f*tw_rnd(randBuf,i);
                                    float y0=360.0f-720.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamBlue, true, 180.0f,x0 ,y0,true, corvetteDesignAntiCorvette, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                    
                                    setShipShipTarget(newShipCreateId-1,galactica, &adr, &dataAdr,command, 
                                                    commandData, dataInt, dataFloat);

                                    for(int m=0;m<100;m++)
                                        translateShipAtTime(newShipCreateId-1,ts+=3, true, true, 
                                            x0-m*7.5f+k*15.0f,  y0,
                                            &adr, &dataAdr, command, commandData, dataInt, dataFloat);

                                }

                            }
                            else if((j>=4) && (j<104))
                            {
                                int spawnId=j-4; // 0...99
                                waitForTimeSpan(18500, &adr, command, commandData);
                                for(int k=0;k<3;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=-6000.0f*tw_rnd(randBuf,i)-500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamGreen, true, 80.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true, cruiserDesignAntiCruiser, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }
                                for(int k=0;k<12;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=-6000.0f*tw_rnd(randBuf,i)-500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamGreen, true, 80.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true,destroyerDesignAntiCruiser , 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }
                                for(int k=0;k<20;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=-6000.0f*tw_rnd(randBuf,i)-500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamGreen, true, 80.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true,heavyFrigateDesignAntiCorvette , 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }
                                for(int k=0;k<50;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=-6000.0f*tw_rnd(randBuf,i)-500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamGreen, true, 80.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true, heavyCorvetteDesignAntiFrigate, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }


                                for(int k=0;k<3;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=6000.0f*tw_rnd(randBuf,i)+500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamBlue, true, -100.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true, cruiserDesignAntiCruiser, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }
                                for(int k=0;k<12;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=6000.0f*tw_rnd(randBuf,i)+500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamBlue, true, -100.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true,destroyerDesignAntiCruiser , 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<20;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=6000.0f*tw_rnd(randBuf,i)+500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamBlue, true, -100.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true,heavyFrigateDesignAntiCorvette , 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }
                                for(int k=0;k<50;k++)
                                {
                                    float x0=12000.0f*tw_rnd(randBuf,i)-6000.0f;
                                    float y0=6000.0f*tw_rnd(randBuf,i)+500.0f;
                                    createShipAtScreenCenter(newShipCreateId++,teamBlue, true, -100.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,true, heavyCorvetteDesignAntiFrigate, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                waitForTimeSpan(20000.0f, &adr, command, commandData);
                                for(int k=0;k<10;k++)
                                {
                                    float x0=3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, -10.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false, cruiserDesignAntiCruiser, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<20;k++)
                                {
                                    float x0=3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, -10.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false,destroyerDesignAntiCruiser , 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<40;k++)
                                {
                                    float x0=3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, -10.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false, heavyFrigateDesignAntiCorvette, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<80;k++)
                                {
                                    float x0=3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, -10.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false, heavyCorvetteDesignAntiFrigate, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                waitForTimeSpan(30000.0f, &adr, command, commandData);

                                for(int k=0;k<10;k++)
                                {
                                    float x0=14000-3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, 170.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false, cruiserDesignAntiCruiser, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<20;k++)
                                {
                                    float x0=14000-3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, 170.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false,destroyerDesignAntiCruiser , 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<40;k++)
                                {
                                    float x0=14000-3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, 170.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false, heavyFrigateDesignAntiCorvette, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }

                                for(int k=0;k<80;k++)
                                {
                                    float x0=14000-3000.0f*tw_rnd(randBuf,i);
                                    float y0=14000.0f*tw_rnd(randBuf,i);
                                    createShipAtScreenCenter(newShipCreateId++,teamRed, true, 170.0f+20.0f*tw_rnd(randBuf,i),x0 ,y0,false, heavyCorvetteDesignAntiFrigate, 
                                        &adr, &dataAdr, command, commandData, dataInt, dataFloat);
                                }
                            }
                            else if(j==0)
                            {
                                // camera move side
                                lockCameraToShipForTimeSpan(newShipCreateId-1, 4000.0f, &adr, command, commandData);
                                moveCameraToShipAnimated(newShipCreateId,1000.0f, &adr,&dataAdr, command, commandData, dataInt, dataFloat);
                                lockCameraToShipForTimeSpan(newShipCreateId, 2000.0f, &adr, command, commandData);
                                moveCameraToShipAnimated(newShipCreateId-1,1000.0f, &adr,&dataAdr, command, commandData, dataInt, dataFloat);
                                disableMousePointer(&adr, command);  
                                lockCameraToShipForTimeSpan(newShipCreateId-1, 25000.0f, &adr, command, commandData);
                                for(int k=0;k<4800;k++)
                                {
                                    warpCameraAtTime(33000+3*k, 0+k*3 , MAP_HEIGHT/2 - 200, &adr, command,  commandData);
                                }

                                for(int k=0;k<9600;k++)
                                {
                                    warpCameraAtTime(33000+3*4800+4*k, 4800*3-k*1 , MAP_HEIGHT/2 - 200, &adr, command,  commandData);
                                }

                                for(int k=0;k<9600;k++)
                                {
                                    warpCameraAtTime(8000+33000+3*4800+4*9600+k*4, 4800*3-9600*1+k*1 , MAP_HEIGHT/2 - 200, &adr, command,  commandData);
                                }
                            }
                            if(j==1)
                            {
                                // camera zoom
                                int time0=19000;
                                for(int k=0;k<200;k++)
                                    zoomCameraAtTime(time0+=3,1.0f-k*0.0022f, &adr, command, commandData);
                                time0+=6000;
                                for(int k=0;k<200;k++)
                                    zoomCameraAtTime(time0+=5,1.0f-200*0.0022f+k*0.007f, &adr, command, commandData);
                                time0+=5000;
                                for(int k=0;k<300;k++)
                                    zoomCameraAtTime(time0+=5,1.0f-200*0.0022f+200*0.007f+k*0.05f, &adr, command, commandData);
                                time0+=3000;
                                for(int k=0;k<300;k++)
                                    zoomCameraAtTime(time0+=5,1.0f-200*0.0022f+200*0.007f+300*0.05f-k*0.05f, &adr, command, commandData);
                                time0=45000;
                                for(int k=0;k<200;k++)
                                    zoomCameraAtTime(time0+=5,1.0f-200*0.0022f+200*0.007f+300*0.05f-300*0.05f-k*0.004f, &adr, command, commandData);

                                
                            }
                            else if(j==104)
                            {
         

                            }
                        });


                    }
                }
            }



            // recalculate a newly created ship's module info(and ship stats)
            // i: ship id
            void shipModuleRecalculate(int i, __global uchar * shipModuleType,
                                       __global int * shipModuleEnergy,
                                       __global int * shipModuleEnergyMax,
                                       __global uchar * shipModuleHP,
                                       __global uchar * shipModuleHPMax,
                                       __global uchar * shipModuleState,
                                       __global int * shipModuleWeight,
                                       __global int * shipShield,
                                       __global int * shipShieldMax,
                                       __global uint * randBuf,
                                       __global uchar * shipState,  
                                       bool moving)
            {
                
                mem_fence(CLK_GLOBAL_MEM_FENCE);
                if(moving)
                    shipState[i]|=PROJECTILE_FORWARD;
                else
                    shipState[i]&=~PROJECTILE_FORWARD;
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


            void calculateShipHp(int threadId, int shipId, uchar shipSizeType, __global int * shipHp, 
                                __global int * shipHpMax, __global uint * randSeeds)
            {
	            int nDice=0;
	            int total=0;
	            if(shipSizeType==SHIP_SIZE_TYPE_CORVETTE)
	            { 
		            nDice=7;
		            for(int id=0; id<nDice;id++ )
			            total+=d4(randSeeds,threadId);
	            }
	            else if(shipSizeType==SHIP_SIZE_TYPE_FRIGATE)
	            { 
		            nDice=10;
		            for(int id=0; id<nDice;id++ )
			            total+=d6(randSeeds,threadId);
	            }
	            else if(shipSizeType==SHIP_SIZE_TYPE_DESTROYER)
	            { 
		            nDice=15;
		            for(int id=0; id<nDice;id++ )
			            total+=d8(randSeeds,threadId);
	            }
	            else if(shipSizeType==SHIP_SIZE_TYPE_CRUISER)
	            { 
		            nDice=20;
		            for(int id=0; id<nDice;id++ )
			            total+=d10(randSeeds,threadId);
	            }
	            shipHp[shipId]=total;
	            shipHpMax[shipId]=total;
            }

            // script engine for benchmark + game control
            // control ships, camera, postprocessing
            // N_SCRIPT_WORKER workitems for running, 0th workitem for control
            __kernel void scriptEngine( __global int * command,    
                                        __global float * commandData,
                                        __global int * commandPointer,
                                        __global int * engineState,
                                        __global int * intUserParameters,
                                        __global float * floatUserParameters,
                                        __global float * frameTime,
                                        __global float * frameTimeInner,
                                        __global float * shipX,
                                        __global float * shipY,
                                        __global int * dataInt,
                                        __global float * shipXOld,
                                        __global float * shipYOld,
                                        __global float * dataFloat,
                                        __global uchar * shipTeam,
                                        __global uchar * shipSizeType,
                                        __global uchar * shipModuleType,
                                       __global int * shipModuleEnergy,
                                       __global int * shipModuleEnergyMax,
                                       __global uchar * shipModuleHP,
                                       __global uchar * shipModuleHPMax,
                                       __global uchar * shipModuleState,
                                       __global int * shipModuleWeight,
                                       __global int * shipShield,
                                       __global int * shipShieldMax,
                                       __global uint * randBuf,
                                       __global uchar * shipState,
                                       __global float * shipRotation,
                                       __global int * shipHp,
                                       __global int * shipHpMax,        
                                       __global float * shipTargetX,
                                       __global float * shipTargetY,
                                       __global int * shipSelected,
                                       __global int * shipTargetShip
                                        )
            {
                int id=get_global_id(0);
                for(int rep=0;rep<100;rep++)
                {
  
                    int frameCount=engineState[ENGINE_STATE_FRAME_COUNT];
                    float totalTimeMs = frameTime[TIME_TOTAL_ELAPSED];
                    float checkpointTimeMs = frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id];
                    int pointer = commandPointer[id];
                    int workerActive = engineState[ENGINE_STATE_WORKER_ACTIVE + ENGINE_STATE_PER_THREAD*id];
                    int workerJumpSize = engineState[ENGINE_STATE_WORKER_JUMP_SIZE + ENGINE_STATE_PER_THREAD*id];
                    int workerRunningCount=engineState[ENGINE_STATE_WORKER_RUNNING_COUNT];
                    
                    int workerStepSize=1;



                    barrier(CLK_GLOBAL_MEM_FENCE);
                    
                    if(command[pointer]==COMMAND_BIND_WORKER)                   
                    {
                        int workerId=(int)commandData[COMMAND_PARAMETER_0(pointer)];
                        if(id==0)
                        {
                            engineState[ENGINE_STATE_WORKER_JUMP_SIZE + ENGINE_STATE_PER_THREAD*workerId]= 
                                ((N_SCRIPT_WORKER-1) * (int)commandData[COMMAND_PARAMETER_1(pointer)]) - ((int)commandData[COMMAND_PARAMETER_1(pointer)] - 1);
                            // if worker is not bound already
                            // (it will get there itself)
                            if(engineState[ENGINE_STATE_WORKER_ACTIVE + ENGINE_STATE_PER_THREAD*workerId]==0)
                            {
                                commandPointer[workerId]=pointer+1;
                                engineState[ENGINE_STATE_WORKER_ACTIVE + ENGINE_STATE_PER_THREAD*workerId]=1;
                            }
                            else
                            {
                                // increase number of jumps so worker will jump here when finished
                                // jump size = N_SCRIPT_WORKER - 1 * step size
                                engineState[ENGINE_STATE_WORKER_NUM_JUMPS_LEFT + ENGINE_STATE_PER_THREAD*workerId]++;
                            }
                            commandPointer[id]+=(int)commandData[COMMAND_PARAMETER_1(pointer)];
                            engineState[ENGINE_STATE_WORKER_RUNNING_COUNT]++;
                        }
                        else
                        {

                        }
                    }

                    barrier(CLK_GLOBAL_MEM_FENCE);

                    if(workerActive && (command[pointer]==COMMAND_STOP_WORKER))
                    {
                        // id==0 must not get this command
                        // check if num jumps left is > 0
                        // then jump for N_SCRIPT_WORKER - 1 * step size commands
                        if(engineState[ENGINE_STATE_WORKER_NUM_JUMPS_LEFT + ENGINE_STATE_PER_THREAD*id]>0)
                        {
                            commandPointer[id]+=workerJumpSize;
                            engineState[ENGINE_STATE_WORKER_NUM_JUMPS_LEFT + ENGINE_STATE_PER_THREAD*id]--;
                        }
                        else
                        {
                            engineState[ENGINE_STATE_WORKER_ACTIVE + ENGINE_STATE_PER_THREAD*id]=0;
                            commandPointer[id]=0;
                        }     
                        atomic_add(&engineState[ENGINE_STATE_WORKER_RUNNING_COUNT],-1);          
                    }

                    barrier(CLK_GLOBAL_MEM_FENCE);

                    if((id==0) || workerActive)
                    {
                        if(command[pointer]==COMMAND_MOVE_CAMERA_TO_SHIP_ANIMATED)   
                        {
                            // move camera to ship until it is close enough
                            int dataId=(int)commandData[COMMAND_PARAMETER_0(pointer)];
                            int shipId=dataInt[dataId++];       
                            float totalTimeForAnimation=dataFloat[dataId++];
                            float currentTimeForAnimation=dataFloat[dataId];


                            if(checkpointTimeMs<0.01f)
                            {
                                // animation started
                                frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id]=totalTimeMs;
                                dataFloat[dataId+1]=floatUserParameters[USER_VAR_MAP_X];
                                dataFloat[dataId+2]=floatUserParameters[USER_VAR_MAP_Y];
                            }
                            else
                            if(totalTimeMs-checkpointTimeMs>=totalTimeForAnimation)
                            {
                                // animation complete
                                frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id]=0.0f;
                                pointer+=workerStepSize;
                                commandPointer[id]=pointer;
                            }
                            else
                            {
                                if(currentTimeForAnimation<totalTimeMs-checkpointTimeMs)
                                {
                                    dataFloat[dataId]=totalTimeMs-checkpointTimeMs; 
                                    float animationRatio=(totalTimeMs-checkpointTimeMs)/totalTimeForAnimation;
                                    animationRatio=sin(animationRatio*3.14f/2.0f);
                                    // move camera to point lying between current cam pos and ship pos
                                    floatUserParameters[USER_VAR_MAP_X]=(shipX[shipId]*animationRatio+dataFloat[dataId+1]*(1.0f-animationRatio));
                                    floatUserParameters[USER_VAR_MAP_Y]=(shipY[shipId]*animationRatio+dataFloat[dataId+2]*(1.0f-animationRatio));
                                }
                            }
                        }
                        else if(command[pointer]==COMMAND_SET_SHIP_MOVE_TARGET)
                        {
                            // set ship target location x,y from data
                            int dataId=(int)commandData[COMMAND_PARAMETER_0(pointer)];
                            int shipId=dataInt[dataId++];
                            float targetX=dataFloat[dataId++];
                            float targetY=dataFloat[dataId++];
                            // set ship target
                            shipTargetX[shipId]=targetX;
                            shipTargetY[shipId]=targetY;
                            shipSelected[shipId]=-1; // script selected
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_SET_SHIP_SHIP_TARGET)
                        {
                            // set ship target location x,y from data
                            int dataId=(int)commandData[COMMAND_PARAMETER_0(pointer)];
                            int shipId=dataInt[dataId++];
                            int targetShipId=dataInt[dataId++];
                            shipTargetShip[shipId]=targetShipId;
                            shipSelected[shipId]=-1; // script selected
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_SYNC_WORKER)
                        {
                            // wait for workers completion
                            if(workerRunningCount==0)
                            {
                                commandPointer[id]++;
                            }
                            else
                            {
                                // wait for completion
                            }
                        }
                        else if(command[pointer]==COMMAND_WARP_CAMERA)
                        {
                            // set pointer to next command
                            // do instant camera movement
                            floatUserParameters[USER_VAR_MAP_X]=
                                commandData[COMMAND_PARAMETER_0(pointer)];
                            floatUserParameters[USER_VAR_MAP_Y]=
                                commandData[COMMAND_PARAMETER_1(pointer)];
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_ZOOM_CAMERA)
                        {
                            // set pointer to next command
                            // do instant camera zoom
                            floatUserParameters[USER_VAR_MAP_SCALE]=
                                commandData[COMMAND_PARAMETER_0(pointer)];
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;

                        }
                        else if(command[pointer]==COMMAND_LOCK_CAMERA_TO_SHIP)
                        {
                            floatUserParameters[USER_VAR_MAP_X]=
                                shipX[(int)floor(commandData[COMMAND_PARAMETER_0(pointer)] + 0.1f)];
                            floatUserParameters[USER_VAR_MAP_Y]=
                                shipY[(int)floor(commandData[COMMAND_PARAMETER_0(pointer)]+0.1f)];

                            // wait for miliseconds
                            // set pointer to next command when complete
                            if(checkpointTimeMs<0.01f)
                            {
                                frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id]=totalTimeMs;
                            }
                            else
                            if(totalTimeMs-checkpointTimeMs>=commandData[COMMAND_PARAMETER_1(pointer)])
                            {
                                frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id]=0.0f;
                                pointer+=workerStepSize;
                                commandPointer[id]=pointer;
                            }
                        }
                        else if(command[pointer]==COMMAND_MOVE_SHIP)
                        {
                            int dataId=(int)floor(commandData[COMMAND_PARAMETER_0(pointer)]+0.1f);
                            int newShipId=dataInt[dataId];
                            float newShipX=dataFloat[dataId+1];
                            float newShipY=dataFloat[dataId+2];

                            // if x,y negative, get to camera position (screen center) 
                            // set old position too, for verlet integrator
                            if((newShipX<0.5f) && (newShipY<0.5f))
                            {
                                float newShipTranslationX=dataFloat[dataId+3];
                                float newShipTranslationY=dataFloat[dataId+4];
                                shipX[newShipId]   =floatUserParameters[USER_VAR_MAP_X] + newShipTranslationX;
                                shipXOld[newShipId]=floatUserParameters[USER_VAR_MAP_X] + newShipTranslationX;
                                shipY[newShipId]   =floatUserParameters[USER_VAR_MAP_Y] + newShipTranslationY;                              
                                shipYOld[newShipId]=floatUserParameters[USER_VAR_MAP_Y] + newShipTranslationY;                              
                            }
                            else
                            {
                                shipX[newShipId]=newShipX;
                                shipXOld[newShipId]=newShipX;
                                shipY[newShipId]=newShipY;
                                shipYOld[newShipId]=newShipY;
                            }   
                            bool moving=dataInt[dataId+5];
                            if(moving)
                            {
                                shipState[newShipId]|=PROJECTILE_FORWARD;
                            }
                            else
                            {
                                shipState[newShipId]&=~PROJECTILE_FORWARD;
                            }
                            // if angle is not over critical range (this means only translation, no rotation)
                            if(dataFloat[dataId+6]<999999990.0f)
                                shipRotation[newShipId]=dataFloat[dataId+6];
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_DISABLE_MOUSE_POINTER)
                        {
                            // send mouse pointer to infinity
                            // set pointer to next command
                            floatUserParameters[USER_VAR_MOUSE_X]=-50000.0f;
                            floatUserParameters[USER_VAR_MOUSE_Y]=-50000.0f;

                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_ENABLE_MOUSE_POINTER)
                        {
                            floatUserParameters[USER_VAR_MOUSE_X]=RENDER_WIDTH/2.0f;
                            floatUserParameters[USER_VAR_MOUSE_Y]=RENDER_HEIGHT/2.0f;

                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_ENABLE_HARDPOINT_VIEW)
                        {
                            intUserParameters[USER_VAR_HARDPOINT_VIEW]=1;
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_ENABLE_CAPTAIN_EXPERIENCE_VIEW)
                        {
                            intUserParameters[USER_VAR_CAPTAIN_EXPERIENCE_VIEW]=1;
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;
                        }
                        else if(command[pointer]==COMMAND_MOVE_ALL_SHIPS_OUT)
                        {
                            // send all ships to negative infinity
                            // todo: make this offloadable to threads 0-255 in async
                            // for now, 110ms with R7-240
                            for(int ship=0;ship<N_SHIP_MAX;ship++)
                            {    
                                shipX[ship]=-999999999.0f;
                                shipY[ship]=-999999999.0f;
                                shipXOld[ship]=-999999999.0f;
                                shipYOld[ship]=-999999999.0f;
                            }
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;

                            
                        }
                        else if(command[pointer]==COMMAND_CREATE_SHIP_BY_DATA)
                        {
                            int dataId=(int)floor(commandData[COMMAND_PARAMETER_0(pointer)]+0.1f);
                            int newShipId=dataInt[dataId];
                            float newShipX=dataFloat[dataId+1];
                            float newShipY=dataFloat[dataId+2];

                            // if x,y negative, get to camera position (screen center) 
                            // set old position too, for verlet integrator
                            if((newShipX<0.5f) && (newShipY<0.5f))
                            {
                                float newShipTranslationX=dataFloat[dataId+3];
                                float newShipTranslationY=dataFloat[dataId+4];
                                shipX[newShipId]   =floatUserParameters[USER_VAR_MAP_X] + newShipTranslationX;
                                shipXOld[newShipId]=floatUserParameters[USER_VAR_MAP_X] + newShipTranslationX;
                                shipY[newShipId]   =floatUserParameters[USER_VAR_MAP_Y] + newShipTranslationY;                              
                                shipYOld[newShipId]=floatUserParameters[USER_VAR_MAP_Y] + newShipTranslationY;                              
                            }
                            else
                            {
                                shipX[newShipId]=newShipX;
                                shipXOld[newShipId]=newShipX;
                                shipY[newShipId]=newShipY;
                                shipYOld[newShipId]=newShipY;
                            }
    
                            shipTeam[newShipId]=dataInt[dataId+5];
                            shipSizeType[newShipId]=dataInt[dataId+6];
                            shipModuleType[newShipId]=dataInt[dataId+7];
                            shipModuleType[newShipId+N_SHIP_MAX]=dataInt[dataId+8];
                            shipModuleType[newShipId+N_SHIP_MAX*2]=dataInt[dataId+9];
                            shipModuleType[newShipId+N_SHIP_MAX*3]=dataInt[dataId+10];
                            shipModuleType[newShipId+N_SHIP_MAX*4]=dataInt[dataId+11];
                            shipModuleType[newShipId+N_SHIP_MAX*5]=dataInt[dataId+12];
                            shipModuleType[newShipId+N_SHIP_MAX*6]=dataInt[dataId+13];
                            shipModuleType[newShipId+N_SHIP_MAX*7]=dataInt[dataId+14];
                            shipModuleType[newShipId+N_SHIP_MAX*8]=dataInt[dataId+15];
                            shipModuleType[newShipId+N_SHIP_MAX*9]=dataInt[dataId+16];
                            bool moving=dataInt[dataId+17];
                            shipRotation[newShipId]=dataFloat[dataId+18];
                            shipModuleRecalculate(  newShipId, shipModuleType,
                                                    shipModuleEnergy,shipModuleEnergyMax, shipModuleHP, 
                                                    shipModuleHPMax, shipModuleState, shipModuleWeight,
                                                    shipShield, shipShieldMax, randBuf,shipState,moving);
                            calculateShipHp(        id, newShipId, dataInt[dataId+6],shipHp, 
                                                    shipHpMax, randBuf);
                            pointer+=workerStepSize;
                            commandPointer[id]=pointer;

                           
                        }
                        else if(command[pointer]==COMMAND_WAIT_MS)
                        {
                            // wait for miliseconds
                            // set pointer to next command when complete
                            if(checkpointTimeMs<0.01f)
                            {
                                frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id]=totalTimeMs;
                            }
                            else
                            if(totalTimeMs-checkpointTimeMs>=commandData[COMMAND_PARAMETER_0(pointer)])
                            {
                                frameTimeInner[TIME_CHECKPOINT+ENGINE_STATE_PER_THREAD*id]=0.0f;
                                pointer+=workerStepSize;
                                commandPointer[id]=pointer;

                            }
                        }
                        else if(command[pointer]==COMMAND_WAIT_FOR_FRAME)
                        {
                            if(frameCount>=commandData[COMMAND_PARAMETER_0(pointer)])
                            {
                                pointer+=workerStepSize;
                                commandPointer[id]=pointer;

                               
                            }
                            else
                            {
                            }
                        }
                        else if(command[pointer]==COMMAND_WAIT_FOR_TOTAL_TIME)
                        {
                            if(totalTimeMs>=commandData[COMMAND_PARAMETER_0(pointer)])
                            {
                                pointer+=workerStepSize;
                                commandPointer[id]=pointer;

                               
                            }
                            else
                            {
                            }
                        }

                    }

                    barrier(CLK_GLOBAL_MEM_FENCE);

                }
            }









// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test
// test test


