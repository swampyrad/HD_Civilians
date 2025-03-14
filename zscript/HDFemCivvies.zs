class HDFemCivilian : HDCivilian
{
  default{
  //  obituary "%o was somehow killed by a scared civilian???";
    seesound "femciv/sight";
    painsound "femciv/pain";
    deathsound "femciv/death";
    activesound "femciv/active";
    
  //  Tag "Civilian";
  
  //  hdmobbase.landsound "";
	//  hdmobbase.stepsound "";
	//  hdmobbase.stepsoundwet "";
  }
}

class Civvie1f : HDFemCivilian    //white tanktop girl
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="PEF1";
  }
}


class Civvie2f : HDFemCivilian   //green tanktop girl
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="PEF2";
  }
}


class Civvie3f : HDFemCivilian   //black jacket girl
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="PEF3";
  }
}

class Civvie4f : HDFemCivilian   //office lady
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="PEF4";
  }
}

class Civvie5f : HDFemCivilian   //black tanktop girl
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="PEF5";
  }
}

class Civvie6f : HDFemCivilian   //bike shorts girl
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="PEF6";
  }
}

class CivvieDoc2f : HDFemCivilian   //scientist girl
{
  override void postbeginplay(){
    super.postbeginplay();
    civviesprite="DOC2";
  }
  states{
	rescued:
    TNT1 A 0 A_SpawnItem("TeleportFog");
    TNT1 A 0 A_SpawnItem("DoctorLootSpawner");
    stop;
	}
}
