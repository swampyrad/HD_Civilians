// civilian spawn randomizer
class CivvieDropper:RandomSpawner{
	default{
    dropitem "Civvie1",256,5;
    dropitem "Civvie2",256,5;
    dropitem "Civvie3",256,5;
    dropitem "Civvie4",256,5;
    dropitem "Civvie5",256,5;
    dropitem "Civvie7",256,5;
    dropitem "CivvieDoc1",256,5;
		dropitem "Civvie1f",256,5;
    dropitem "Civvie2f",256,5;
    dropitem "Civvie3f",256,5;
    dropitem "Civvie4f",256,5;
    dropitem "Civvie5f",256,5;
    dropitem "Civvie6f",256,5;
    dropitem "CivvieDoc2f",256,5;
	}
}

// regular civilian loot drops
class CivvieLootSpawner:RandomSpawner{
	default{
    dropitem "ClipMagPickup",256,20;
    dropitem "ShellRandom",256,15;
    dropitem "CellRandom",256,12;
    dropitem "ShellBoxRandom",256,10;
    dropitem "CellPackReplacer",256,3;
    dropitem "RocketBoxRandom",256,2;
    dropitem "ClipBoxPickup",256,1;
	}
}

// scientist/doctor loot drops
class DoctorLootSpawner:RandomSpawner{
	default{
    dropitem "PortableMedikit",256,20;
    dropitem "PortableStimpack",256,10;
    dropitem "HDHealingPotion",256,5;
    dropitem "ShieldCore",256,2;
    dropitem "PortableBerserkPack",256,1;
	}
}

// base civilian actor, all civilians 
// should inherit from this
class HDCivilian : HDHumanoid
{
  default{
  obituary "%o was somehow killed by a scared civilian???";

  seesound "civvie/sight";
  painsound "civvie/pain";
  deathsound "civvie/death";
  activesound "civvie/active";
  
  // don't use footstep sfx, the sound of dozens of civvies 
  // running around gets real noisy real fast lmao
	hdmobbase.landsound "";
	hdmobbase.stepsound "";
	hdmobbase.stepsoundwet "";
  
  Tag "Civilian";

  -COUNTKILL
  +NOTARGET
  +MISSILEEVENMORE
  -FRIENDLY
  +FRIGHTENED
  
  +USESPECIAL
  Activation THINGSPEC_Activate | THINGSPEC_NoDeathSpecial;
  }
  
  // tracks civilian actor's assigned sprite index,
  // used for recalling appropriate sprites when
  // spawning and ungibbing
  string civviesprite;

  override void postbeginplay(){
    super.postbeginplay();
  
  // if set, civilians won't attack player,
  // but will be attacked by monsters
    if(Civvie_SpawnFriendly){
      bfriendly=true;
      bnotarget=false;
    }
  }

  // all civilian behavior checks
  // should be handled in here
  override void Tick(){
    super.Tick();
    
    // check if civilian is alive first
    if(health>0){
    
      //enable rescue if friendly
      if(bfriendly&&!bUseSpecial){
        bUseSpecial=true;
        bNoTarget=false;
        bMISSILEEVENMORE=true;
      }
    
      // evil civs are hostile and can't be 
      // rescued without being incapped first
      if(!bfriendly
         &&InStateSequence(
             curState, 
             ResolveState("falldown")
           )
        )bUseSpecial=true; // enable rescue if knocked down
      else if(!bfriendly&&bUseSpecial){
        bUseSpecial=false;
        bNoTarget=true;
        bMISSILEEVENMORE=false;
      }
    }else bUseSpecial=false;//disable rescue if dead
  }
  
  override void Activate(Actor activator){
    SetStateLabel("Rescued");
    // civilians get teleported away and 
    // leave items behind as a reward
    
    // display message after successfully 
    // warping a civilian out of the map
    if(bfriendly)A_Log("\c[Sapphire]Civilian rescued.");
    else A_Log("\c[Sapphire]Hostile detained.");
  }
  
  states{
	spawn:
	// preloading civvie sprites
	  PEM1 A 0;
	  PEM2 A 0;
	  PEM3 A 0;
	  PEM4 A 0;
	  PEM5 A 0;
	  PEM7 A 0;
	  DOC1 A 0;
	  PEF1 A 0;
	  PEF2 A 0;
	  PEF3 A 0;
	  PEF4 A 0;
	  PEF5 A 0;
	  PEF6 A 0;
	  DOC2 A 0;
		TNT1 A 0 {sprite = GetSpriteIndex(civviesprite);}
		#### R 1{
			A_HDLook();
		}
		#### RRR random(5,17) A_HDLook();
		#### R 1{
			A_SetTics(random(10,40));
		}
		#### R 0 A_Jump(28,"spawngrunt");
		#### R 0 A_Jump(132,"spawnswitch");
		#### R 8 A_Recoil(frandom(-0.2,0.2));
		loop;
	spawngrunt:
		#### R 0 A_Jump(256,"spawn");
	spawnswitch:
		#### R 0 A_JumpIf(bambush,"spawnstill");
		goto spawnwander;
	spawnstill:
		#### R 0 A_Look();
		#### CD 5 A_SetAngle(angle+random(-4,4));
		#### A 0{
			A_Look();
			if(!random(0,127)
			   &&Civvie_StayQuiet==false
			  )A_Vocalize(activesound);
		}
		#### AB 5 A_SetAngle(angle+random(-4,4));
		#### B 1 A_SetTics(random(10,40));
		#### A 0 A_Jump(256,"spawn");
	spawnwander:
		#### CDAB 5 A_HDWander();
		#### A 0 A_Jump(64,"spawn");
		loop;

	see:
		#### ABCD random(4,5) A_HDChase();
		loop;
		
  missile:
		---- A 0 setstatelabel("see");
	    
	//civilians step back after attacking, so
	//they don't just wail on you indefinitely
	meleeend:
		#### D 3 A_Recoil(frandom(2.,3.));
		#### CBA 3;
		#### A 0 setstatelabel("see");
	    
	pain:
		#### H 2;
		#### H 3 A_Vocalize(painsound);
		#### H 0{
			A_ShoutAlert(0.1,SAF_SILENT);
			if(
				floorz==pos.z
				&&target
				&&(
					!random(0,4)
					||distance3d(target)<128
				)
			){
				double ato=angleto(target)+randompick(-90,90);
				vel+=((cos(ato),sin(ato))*speed,1.);
				setstatelabel("missile");
			}else bfrightened=true;
		}
		#### ABCD 2 A_HDChase();
		---- A 0 setstatelabel("see");
	death:
		#### H 5;
		#### I 5 A_Vocalize(deathsound);
		#### J 5 A_NoBlocking();
		#### K 5;
	dead:
		#### L 3 canraise{if(abs(vel.z)<2.)frame++;}
		#### M 5 canraise{if(abs(vel.z)>=2.)setstatelabel("dead");}
		wait;
	xxxdeath:
		#### O 4;
		#### P 4{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		PGIB ABCDEFG 3;
		goto gibbed;
	gib:
		#### O 4{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		#### O 0 A_NoBlocking();
		#### P 4 spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
		PGIB ABCDEFG 4;
		goto gibbed;
	gibbed:
		PGIB F 4 canraise{if(abs(vel.z)<2.)frame++;}
		PGIB G 4 canraise A_JumpIf(abs(vel.z)>=2.,"gibbed");
		wait;
	raise:
		#### L 4;
		#### LK 6;
		#### JIH 4;
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB GFEDCBA 4;
		#### P 0 {sprite = GetSpriteIndex(civviesprite);}
		#### PO 4;
		#### A 0 A_Jump(256,"see");
	rescued:
    TNT1 A 0 A_SpawnItem("TeleportFog");
    TNT1 A 0 A_SpawnItem("CivvieLootSpawner");
    stop;
	}
}

class Civvie1 : HDCivilian   // t-shirt guy
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="PEM1";
  }
}

class Civvie2 : HDCivilian //black vest guy
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="PEM2";
	}
}

class Civvie3 : HDCivilian   //t-shirt black guy
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="PEM3";
	}
}

class Civvie4 : HDCivilian   //green tshirt guy
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="PEM4";
	}
}

class Civvie5 : HDCivilian   //windbreaker guy
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="PEM5";
	}
}

class Civvie7 : HDCivilian   //brown jacket guy
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="PEM7";
	}
}

class CivvieDoc1 : HDCivilian   //Senior medical specialist
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="DOC1";
	}
	
  states{
	rescued:
    TNT1 A 0 A_SpawnItem("TeleportFog");
    TNT1 A 0 A_SpawnItem("DoctorLootSpawner");
    stop;
	}
}
