//civilian randomizer
class CivvieDropper:RandomSpawner{
	default{
		dropitem "PedestrianFod1",256,5;
        dropitem "PedestrianFod2",256,5;
        dropitem "PedestrianFod3",256,5;
        dropitem "PedestrianFod4",256,5;
        dropitem "PedestrianFod5",256,5;
        dropitem "PedestrianFod7",256,5;
        dropitem "PedestrianDoc1",256,5;
		dropitem "PedestrianFod1f",256,5;
        dropitem "PedestrianFod2f",256,5;
        dropitem "PedestrianFod3f",256,5;
        dropitem "PedestrianFod4f",256,5;
        dropitem "PedestrianFod5f",256,5;
        dropitem "PedestrianFod6f",256,5;
        dropitem "PedestrianDoc2f",256,5;
	}
}


class HDCivilian : HDHumanoid
{
    default{
  obituary "%o was somehow killed by a scared civilian???";

  seesound "civvie/sight";
  painsound "civvie/pain";
  deathsound "civvie/death";
  activesound "civvie/active";
  
  //don't use footstep sfx, the sound of dozens of civvies 
  //running around gets real noisy real fast lmao
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
  override void Activate(Actor activator){SetStateLabel("Rescued");}
}

class PedestrianFod1 : HDCivilian   // t-shirt guy
{
  states{
	spawn:
		PEM1 R 1{
		    if(Civvie_SpawnFriendly)
		    {bfriendly=true;
		    bnotarget=false;}
		    
			A_HDLook();
			
			//A_Recoil(frandom(-0.1,0.1));
		}
		#### RRR random(5,17) A_HDLook();
		#### R 1{
			//A_Recoil(frandom(-0.1,0.1));
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
		//#### A 0 A_Recoil(random(-1,1)*0.4);
		#### CD 5 A_SetAngle(angle+random(-4,4));
		#### A 0{
			A_Look();
			//if(!random(0,127))A_Vocalize(activesound);
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
		#### A 0 A_AlertMonsters(128);
		loop;
    
    melee:
        ---- EDCBA 3 A_Recoil(2);
    missile:
		---- A 0 setstatelabel("see");
	    
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
	    #### # 0 {bUseSpecial=false;}
		#### H 5;
		#### I 5 A_Vocalize(deathsound);
		#### J 5 A_NoBlocking();
		#### K 5;
	dead:
		#### L 3 canraise{if(abs(vel.z)<2.)frame++;}
		#### M 5 canraise{if(abs(vel.z)>=2.)setstatelabel("dead");}
		wait;
	xxxdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5;
		#### P 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		PGIB ABCDE 5;
		goto xdead;
	xdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		#### O 0 A_NoBlocking();
		#### P 5 spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
		PGIB ABCDE 5;
		goto xdead;
	xdead:
		PGIB D 3 canraise{if(abs(vel.z)<2.)frame++;}
		PGIB E 5 canraise A_JumpIf(abs(vel.z)>=2.,"xdead");
		wait;
	raise:
		PEM1 L 4;
		#### LK 6;
		#### JIH 4;
	    #### H 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEM1 PONM 4;
		#### M 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("ClipMagPickup");
	    stop;
	}

}




class PedestrianFod2 : HDCivilian //black vest guy
{
  states{
	spawn:
		PEM2 R 1{
		    if(Civvie_SpawnFriendly)
		    {bfriendly=true;
		    bnotarget=false;}
			A_HDLook();
			//A_Recoil(frandom(-0.1,0.1));
		}
		#### RRR random(5,17) A_HDLook();
		#### R 1{
			//A_Recoil(frandom(-0.1,0.1));
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
		//#### A 0 A_Recoil(random(-1,1)*0.4);
		#### CD 5 A_SetAngle(angle+random(-4,4));
		#### A 0{
			A_Look();
			//if(!random(0,127))A_Vocalize(activesound);
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

    melee:
        ---- EDCBA 3 A_Recoil(2);
    missile:
		---- A 0 setstatelabel("see");
	
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
       #### # 0 {bUseSpecial=false;}
		#### H 5;
		#### I 5 A_Vocalize(deathsound);
		#### J 5 A_NoBlocking();
		#### K 5;
	dead:
		#### L 3 canraise{if(abs(vel.z)<2.)frame++;}
		#### M 5 canraise{if(abs(vel.z)>=2.)setstatelabel("dead");}
		wait;
	xxxdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5;
		#### P 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		PGIB ABCDE 5;
		goto xdead;
	xdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		#### O 0 A_NoBlocking();
		#### P 5 spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
		PGIB ABCDE 5;
		goto xdead;
	xdead:
		PGIB D 3 canraise{if(abs(vel.z)<2.)frame++;}
		PGIB E 5 canraise A_JumpIf(abs(vel.z)>=2.,"xdead");
		wait;
	raise:
		PEM2 L 4;
		#### LK 6;
		#### JIH 4;
	    #### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEM2 PONM 4;
	    #### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("ShellRandom");
	    stop;
	}

}


class PedestrianFod3 : HDCivilian   //t-shirt black guy
{
  
  states{
	spawn:
		PEM3 R 1{
		    if(Civvie_SpawnFriendly)
		    {bfriendly=true;
		    bnotarget=false;}
			A_HDLook();
			//A_Recoil(frandom(-0.1,0.1));
		}
		#### RRR random(5,17) A_HDLook();
		#### R 1{
			//A_Recoil(frandom(-0.1,0.1));
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
		//#### A 0 A_Recoil(random(-1,1)*0.4);
		#### CD 5 A_SetAngle(angle+random(-4,4));
		#### A 0{
			A_Look();
			//if(!random(0,127))A_Vocalize(activesound);
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

    melee:
        ---- EDCBA 3 A_Recoil(2);
    missile:
		---- A 0 setstatelabel("see");
	
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
	    #### # 0 {bUseSpecial=false;}
		#### H 5;
		#### I 5 A_Vocalize(deathsound);
		#### J 5 A_NoBlocking();
		#### K 5;
	dead:
		#### L 3 canraise{if(abs(vel.z)<2.)frame++;}
		#### M 5 canraise{if(abs(vel.z)>=2.)setstatelabel("dead");}
		wait;
	xxxdeath:
		#### # 0 {bUseSpecial=false;}
		#### O 5;
		#### P 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		PGIB ABCDE 5;
		goto xdead;
	xdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		#### O 0 A_NoBlocking();
		#### P 5 spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
		PGIB ABCDE 5;
		goto xdead;
	xdead:
		PGIB D 3 canraise{if(abs(vel.z)<2.)frame++;}
		PGIB E 5 canraise A_JumpIf(abs(vel.z)>=2.,"xdead");
		wait;
	raise:
		PEM3 L 4;
		#### LK 6;
		#### JIH 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEM3 PONM 4;
	    #### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("ClipMagPickup");
	    stop;
	}

}

class PedestrianFod4 : HDCivilian   //green tshirt guy
{
  
  states{
	spawn:
		PEM4 R 1{
		    if(Civvie_SpawnFriendly)
		    {bfriendly=true;
		    bnotarget=false;}
			A_HDLook();
			//A_Recoil(frandom(-0.1,0.1));
		}
		#### RRR random(5,17) A_HDLook();
		#### R 1{
			//A_Recoil(frandom(-0.1,0.1));
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
		//#### A 0 A_Recoil(random(-1,1)*0.4);
		#### CD 5 A_SetAngle(angle+random(-4,4));
		#### A 0{
			A_Look();
			//if(!random(0,127))A_Vocalize(activesound);
		}
		#### AB 5 A_SetAngle(angle+random(-4,4));
		#### B 1 A_SetTics(random(10,40));
		#### A 0 A_Jump(256,"spawn");
	spawnwander:
		#### CDAB 5 A_HDWander();
		#### A 0 A_Jump(64,"spawn");
		loop;

	see:
		#### ABCD random(5,5) A_HDChase();
		loop;

    melee:
        ---- EDCBA 3 A_Recoil(2);
    missile:
		---- A 0 setstatelabel("see");
	
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
	    #### # 0 {bUseSpecial=false;}
		#### H 5;
		#### I 5 A_Vocalize(deathsound);
		#### J 5 A_NoBlocking();
		#### K 5;
	dead:
		#### L 3 canraise{if(abs(vel.z)<2.)frame++;}
		#### M 5 canraise{if(abs(vel.z)>=2.)setstatelabel("dead");}
		wait;
	xxxdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5;
		#### P 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		PGIB ABCDE 5;
		goto xdead;
	xdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		#### O 0 A_NoBlocking();
		#### P 5 spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
		PGIB ABCDE 5;
		goto xdead;
	xdead:
		PGIB D 3 canraise{if(abs(vel.z)<2.)frame++;}
		PGIB E 5 canraise A_JumpIf(abs(vel.z)>=2.,"xdead");
		wait;
	raise:
		PEM4 L 4;
		#### LK 6;
		#### JIH 4;
	    #### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEM4 PONM 4;
	    #### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
    rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("ClipMagPickup");
	    stop;
	}

}

class PedestrianFod5 : HDCivilian   //windbreaker guy
{
  
  states{
	spawn:
		PEM5 R 1{
		    if(Civvie_SpawnFriendly)
		    {bfriendly=true;
		    bnotarget=false;}
			A_HDLook();
			//A_Recoil(frandom(-0.1,0.1));
		}
		#### RRR random(5,17) A_HDLook();
		#### R 1{
			//A_Recoil(frandom(-0.1,0.1));
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
		//#### A 0 A_Recoil(random(-1,1)*0.4);
		#### CD 5 A_SetAngle(angle+random(-4,4));
		#### A 0{
			A_Look();
			//if(!random(0,127))A_Vocalize(activesound);
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

    melee:
        ---- EDCBA 3 A_Recoil(2);
    missile:
		---- A 0 setstatelabel("see");
	
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
	    #### # 0 {bUseSpecial=false;}
		#### H 5;
		#### I 5 A_Vocalize(deathsound);
		#### J 5 A_NoBlocking();
		#### K 5;
	dead:
		#### L 3 canraise{if(abs(vel.z)<2.)frame++;}
		#### M 5 canraise{if(abs(vel.z)>=2.)setstatelabel("dead");}
		wait;
	xxxdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5;
		#### P 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		PGIB ABCDE 5;
		goto xdead;
	xdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		#### O 0 A_NoBlocking();
		#### P 5 spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
		PGIB ABCDE 5;
		goto xdead;
	xdead:
		PGIB D 3 canraise{if(abs(vel.z)<2.)frame++;}
		PGIB E 5 canraise A_JumpIf(abs(vel.z)>=2.,"xdead");
		wait;
	raise:
		PEM5 L 4;
		#### LK 6;
		#### JIH 4;
	    #### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEM5 PONM 4;
	    #### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("ClipMagPickup");
	    stop;
	}

}

// unused civilian, used sprites that made them
// easy to confuse with enemies from a "street thugs"
// monster replacement pack i'm working on

/*
class PedestrianFod6 : HDCivilian
{
  
  states{
	spawn:
		PEM6 R 1{
		    if(Civvie_SpawnFriendly)
		    {bfriendly=true;
		    bnotarget=false;}
			A_HDLook();
			//A_Recoil(frandom(-0.1,0.1));
		}
		#### RRR random(5,17) A_HDLook();
		#### R 1{
			//A_Recoil(frandom(-0.1,0.1));
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
		//#### A 0 A_Recoil(random(-1,1)*0.4);
		#### CD 5 A_SetAngle(angle+random(-4,4));
		#### A 0{
			A_Look();
			//if(!random(0,127))A_Vocalize(activesound);
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

    melee:
        ---- EDCBA 3 A_Recoil(2);
    missile:
		---- A 0 setstatelabel("see");
		
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
		#### O 5;
		#### P 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		PGIB ABCDE 5;
		goto xdead;
	xdeath:
		#### O 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		#### O 0 A_NoBlocking();
		#### P 5 spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
		PGIB ABCDE 5;
		goto xdead;
	xdead:
		PGIB D 3 canraise{if(abs(vel.z)<2.)frame++;}
		PGIB E 5 canraise A_JumpIf(abs(vel.z)>=2.,"xdead");
		wait;
	raise:
		PEM6 L 4;
		#### LK 6;
		#### JIH 4;
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEM6 PONM 4;
		#### A 0 A_Jump(256,"see");
	}

}
*/

class PedestrianFod7 : HDCivilian   //brown jacket guy
{
  
  states{
	spawn:
		PEM7 R 1{
		    if(Civvie_SpawnFriendly)
		    {bfriendly=true;
		    bnotarget=false;}
			A_HDLook();
			//A_Recoil(frandom(-0.1,0.1));
		}
		#### RRR random(5,17) A_HDLook();
		#### R 1{
			//A_Recoil(frandom(-0.1,0.1));
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
		//#### A 0 A_Recoil(random(-1,1)*0.4);
		#### CD 5 A_SetAngle(angle+random(-4,4));
		#### A 0{
			A_Look();
			//if(!random(0,127))A_Vocalize(activesound);
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

    melee:
        ---- EDCBA 3 A_Recoil(2);
    missile:
		---- A 0 setstatelabel("see");
	
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
	    #### # 0 {bUseSpecial=false;}
		#### H 5;
		#### I 5 A_Vocalize(deathsound);
		#### J 5 A_NoBlocking();
		#### K 5;
	dead:
		#### L 3 canraise{if(abs(vel.z)<2.)frame++;}
		#### M 5 canraise{if(abs(vel.z)>=2.)setstatelabel("dead");}
		wait;
	xxxdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5;
		#### P 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		PGIB ABCDE 5;
		goto xdead;
	xdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		#### O 0 A_NoBlocking();
		#### P 5 spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
		PGIB ABCDE 5;
		goto xdead;
	xdead:
		PGIB D 3 canraise{if(abs(vel.z)<2.)frame++;}
		PGIB E 5 canraise A_JumpIf(abs(vel.z)>=2.,"xdead");
		wait;
	raise:
		PEM7 L 4;
		#### LK 6;
		#### JIH 4;
	    #### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEM7 PONM 4;
	    #### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("ShellRandom");
	    stop;
	}

}


class PedestrianDoc1 : HDCivilian   //Senior medical specialist
{
  states{
	spawn:
		DOC1 R 1{
		    if(Civvie_SpawnFriendly)
		    {bfriendly=true;
		    bnotarget=false;}
			A_HDLook();
			//A_Recoil(frandom(-0.1,0.1));
		}
		#### RRR random(5,17) A_HDLook();
		#### R 1{
			//A_Recoil(frandom(-0.1,0.1));
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
		//#### A 0 A_Recoil(random(-1,1)*0.4);
		#### CD 5 A_SetAngle(angle+random(-4,4));
		#### A 0{
			A_Look();
			//if(!random(0,127))A_Vocalize(activesound);
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

    melee:
        ---- EDCBA 3 A_Recoil(2);
    missile:
		---- A 0 setstatelabel("see");
		
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
	    #### # 0 {bUseSpecial=false;}
		#### H 5;
		#### I 5 A_Vocalize(deathsound);
		#### J 5 A_NoBlocking();
		#### K 5;
	dead:
		#### L 3 canraise{if(abs(vel.z)<2.)frame++;}
		#### M 5 canraise{if(abs(vel.z)>=2.)setstatelabel("dead");}
		wait;
	xxxdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5;
		#### P 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		PGIB ABCDE 5;
		goto xdead;
	xdeath:
	    #### # 0 {bUseSpecial=false;}
		#### O 5{
			spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
			A_XScream();
		}
		#### O 0 A_NoBlocking();
		#### P 5 spawn("MegaBloodSplatter",pos+(0,0,34),ALLOW_REPLACE);
		PGIB ABCDE 5;
		goto xdead;
	xdead:
		PGIB D 3 canraise{if(abs(vel.z)<2.)frame++;}
		PGIB E 5 canraise A_JumpIf(abs(vel.z)>=2.,"xdead");
		wait;
	raise:
		DOC1 L 4;
		#### LK 6;
		#### JIH 4;
	    #### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		DOC1 PONM 4;
	    #### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("PortableHealingItemBig");
	    stop;
	}

}
