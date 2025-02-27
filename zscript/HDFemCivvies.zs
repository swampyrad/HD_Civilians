
class HDFemCivilian : HDHumanoid
{
    default{

  obituary "%o was somehow killed by a scared civilian???";
  seesound "femciv/sight";
  painsound "femciv/pain";
  deathsound "femciv/death";
  activesound "femciv/active";
  Tag "Civilian";
  
    hdmobbase.landsound "";
	hdmobbase.stepsound "";
	hdmobbase.stepsoundwet "";

  -COUNTKILL
  +NOTARGET
  +MISSILEEVENMORE
  -FRIENDLY
  +AMBUSH
  +FRIGHTENED
  
  +USESPECIAL
  Activation THINGSPEC_Activate | THINGSPEC_NoDeathSpecial;
  }
  override void Activate(Actor activator){SetStateLabel("Rescued");}
}

class PedestrianFod1f : HDFemCivilian    //white tanktop girl
{
  
  states{
	spawn:
		PEF1 R 1{
            if(Civvie_SpawnFriendly)
		    {bfriendly=true;
		     bnotarget=false;
		    }
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
	//	#### H 0{bfrightened=false;}
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
		PEF1 L 4;
		#### LK 6;
		#### JIH 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEF1 PONM 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("ClipMagPickup");
	    stop;
	}

}

class PedestrianFod2f : HDFemCivilian   //green tanktop girl
{
  states{
	spawn:
		PEF2 R 1{
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
		PEF2 L 4;
		#### LK 6;
		#### JIH 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEF2 PONM 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("ClipMagPickup");
	    stop;
	}

}


class PedestrianFod3f : HDFemCivilian   //black jacket girl
{
  
  states{
	spawn:
		PEF3 R 1{
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
		PEF3 L 4;
		#### LK 6;
		#### JIH 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEF3 PONM 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("ShellRandom");
	    stop;
	}

}

class PedestrianFod4f : HDFemCivilian   //office lady
{
  
  states{
	spawn:
		PEF4 R 1{
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
		PEF4 L 4;
		#### LK 6;
		#### JIH 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEF4 PONM 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("ClipMagPickup");
	    stop;
	}

}

class PedestrianFod5f : HDFemCivilian   //black tanktop girl
{
  states{
	spawn:
		PEF5 R 1{
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
		PEF5 L 4;
		#### LK 6;
		#### JIH 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEF5 PONM 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("ShellRandom");
	    stop;
	}

}


class PedestrianFod6f : HDFemCivilian   //bike shorts girl
{
  states{
	spawn:
		PEF6 R 1{
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
		PEF6 L 4;
		#### LK 6;
		#### JIH 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		PEF6 PONM 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("ClipMagPickup");
	    stop;
	}

}


class PedestrianDoc2f : HDFemCivilian   //scientist girl
{
  states{
	spawn:
		DOC2 R 1{
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
		DOC2 L 4;
		#### LK 6;
		#### JIH 4;
	    #### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	ungib:
		PGIB E 12;
		#### D 8;
		#### BCA 6;
		DOC2 PONM 4;
		#### # 0 {bUseSpecial=true;}
		#### A 0 A_Jump(256,"see");
	rescued:
	    TNT1 A 0 A_SpawnItem("TeleportFog");
	    TNT1 A 0 A_SpawnItem("PortableHealingItemBig");
	    stop;
	}

}
