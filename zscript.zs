version "4.8"

#include "zscript/HDCivvies.zs"
#include "zscript/HDFemCivvies.zs"


class Civvie_Spawner : EventHandler{

override void CheckReplacement( ReplaceEvent Civvie ){

    switch ( Civvie.Replacee.GetClassName() ) {

    // Wild spawns: Civilians replace decorative gore and corpses


        case 'ColonGibs'    :   if(Civvie_EnableWorldSpawns&&!random(0,2))
                                    Civvie.Replacement = "CivvieDropper";
            break;
            
        case 'Gibs'     :   if(Civvie_EnableWorldSpawns&&!random(0,2))
                                Civvie.Replacement = "CivvieDropper";
            break;
        
        case 'SmallBloodPool'   :   if(Civvie_EnableWorldSpawns&&!random(0,2))
                                        Civvie.Replacement = "CivvieDropper";
            break;
        
        case 'DeadRifleman'     :   if(Civvie_EnableWorldSpawns&&!random(0,2))
                                        Civvie.Replacement = "CivvieDropper";
            break;
        
        case 'ReallyDeadRifleman'   :   if(Civvie_EnableWorldSpawns&&!random(0,2))
                                            Civvie.Replacement = "CivvieDropper";
            break;
    
        case 'DeadZombieMan'    :   if(Civvie_EnableWorldSpawns&&!random(0,2))
                                        Civvie.Replacement = "CivvieDropper";
            break;
    
        case 'DeadShotgunGuy'   :   if(Civvie_EnableWorldSpawns&&!random(0,2))
                                        Civvie.Replacement = "CivvieDropper";
            break;
            
        case 'DeadDoomImp'  :   if(Civvie_EnableWorldSpawns&&!random(0,2))
                                    Civvie.Replacement = "CivvieDropper";
            break;
            
        case 'DeadDemon'    :   if(Civvie_EnableWorldSpawns&&!random(0,2))
                                    Civvie.Replacement = "CivvieDropper";
            break;
            
        case 'DeadMarine'    :   if(Civvie_EnableWorldSpawns&&!random(0,2))
                                    Civvie.Replacement = "CivvieDropper";
            break;
            
        case 'GibbedMarine'    :    if(Civvie_EnableWorldSpawns&&!random(0,2))
                                        Civvie.Replacement = "CivvieDropper";
            break;
            
    // replace monsters with civilians
        
    // Doom 1 Monsters
        
    // Zombies
        
        case 'ZombieMan'    :   if(Civvie_ReplaceZombiemanSpawns)
                                    Civvie.Replacement = "CivvieDropper";
            break;
    
        case 'ShotgunGuy'   :   if(Civvie_ReplaceShotgunnerSpawns)
                                    Civvie.Replacement = "CivvieDropper";
            break;
            
        case 'ChaingunGuy'  :   if(Civvie_ReplaceChaingunnerSpawns)
                                    Civvie.Replacement = "CivvieDropper";
            break;
            
    // Hell Spawn
            
        case 'DoomImp'  :   if(Civvie_ReplaceImpSpawns)
                                Civvie.Replacement = "CivvieDropper";
            break;

        case 'Demon'    :   if(Civvie_ReplaceDemonSpawns)
                                Civvie.Replacement = "CivvieDropper";
            break;

        case 'Spectre'  :   if(Civvie_ReplaceSpectreSpawns)
                                Civvie.Replacement = "CivvieDropper";
            break;

        case 'Cacodemon'    :   if(Civvie_ReplaceCacoSpawns)
                                    Civvie.Replacement = "CivvieDropper";
            break;

        case 'LostSoul'     :   if(Civvie_ReplaceSkullSpawns)
                                    Civvie.Replacement = "CivvieDropper";
            break;

    // Bosses

        case 'BaronOfHell'  :   if(Civvie_ReplaceBaronSpawns)
                                    Civvie.Replacement = "CivvieDropper";
            break;
            
        case 'Cyberdemon'   :   if(Civvie_ReplaceCybieSpawns)
                                    Civvie.Replacement = "CivvieDropper";
            break;
            
        case 'SpiderMastermind'     :   if(Civvie_ReplaceSpidermindSpawns)
                                            Civvie.Replacement = "CivvieDropper";
            break;
            
    //Doom II Monsters
            
        case 'HellKnight'   :   if(Civvie_ReplaceGoatSpawns)
                                    Civvie.Replacement = "CivvieDropper";
            break;

        case 'Arachnotron'  :   if(Civvie_ReplaceTronSpawns)
                                  Civvie.Replacement = "CivvieDropper";
            break;

        case 'Revenant'     :   if(Civvie_ReplaceBonesSpawns)
                                  Civvie.Replacement = "CivvieDropper";
            break;
            
        case 'PainElemental'    :   if(Civvie_ReplaceMeatballSpawns)
                                        Civvie.Replacement = "CivvieDropper";
            break;
            
        case 'Fatso'    :   if(Civvie_ReplaceMancSpawns)
                                Civvie.Replacement = "CivvieDropper";
            break;
            
        case 'Archvile'     :   if(Civvie_ReplaceArchieSpawns)
                                    Civvie.Replacement = "CivvieDropper";
            break;
            
        case 'WolfensteinSS'    :   if(Civvie_ReplaceNaziSpawns)
                                        Civvie.Replacement = "CivvieDropper";
            break;
        }

    Civvie.IsFinal = false;

    }

}
